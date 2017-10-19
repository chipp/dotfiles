# code of Installer and etc. was taken from https://github.com/KrauseFx/xcode-install

require 'pathname'
require 'fileutils'

CACHE_DIR = Pathname.new("#{ENV['HOME']}/Library/Caches/XcodeInstall")

class Installer
  attr_reader :xcodes

  def initialize
    FileUtils.mkdir_p(CACHE_DIR)
  end

  def cache_dir
    CACHE_DIR
  end

  def current_symlink
    File.symlink?(SYMLINK_PATH) ? SYMLINK_PATH : nil
  end

  def exist?(version)
    list_versions.include?(version)
  end

  def installed?(version)
    installed_versions.map(&:version).include?(version)
  end

  def installed_versions
    installed.map { |x| InstalledXcode.new(x) }.sort do |a, b|
      Gem::Version.new(a.version) <=> Gem::Version.new(b.version)
    end
  end

  def list_annotated(xcodes_list)
    installed = installed_versions.map(&:version)
    xcodes_list.map { |x| installed.include?(x) ? "#{x} (installed)" : x }.join("\n")
  end

  def list
    list_annotated(list_versions.sort)
  end

  def rm_list_cache
    FileUtils.rm_f(LIST_FILE)
  end

  def symlink(version)
    xcode = installed_versions.find { |x| x.version == version }
    `sudo rm -f #{SYMLINK_PATH}` unless current_symlink.nil?
    `sudo ln -sf #{xcode.path} #{SYMLINK_PATH}` unless xcode.nil? || SYMLINK_PATH.exist?
  end

  def symlinks_to
    File.absolute_path(File.readlink(current_symlink), SYMLINK_PATH.dirname) if current_symlink
  end

  def mount(dmg_path)
    plist = hdiutil('mount', '-plist', '-nobrowse', '-noverify', dmg_path.to_s)
    document = REXML::Document.new(plist)
    node = REXML::XPath.first(document, "//key[.='mount-point']/following-sibling::*[1]")
    fail Informative, 'Failed to mount image.' unless node
    node.text
  end

  private

  LIST_FILE = CACHE_DIR + Pathname.new('xcodes.bin')
  MINIMUM_VERSION = Gem::Version.new('4.3')
  SYMLINK_PATH = Pathname.new('/Applications/Xcode.app')

  def enable_developer_mode
    `sudo /usr/sbin/DevToolsSecurity -enable`
    `sudo /usr/sbin/dseditgroup -o edit -t group -a staff _developer`
  end

  def installed
    unless (`mdutil -s /` =~ /disabled/).nil?
      $stderr.puts 'Please enable Spotlight indexing for /Applications.'
      exit(1)
    end

    `mdfind "kMDItemCFBundleIdentifier == 'com.apple.dt.Xcode'" 2>/dev/null`.split("\n")
  end

  def list_versions
    seedlist.map(&:name)
  end

end

class InstalledXcode
  attr_reader :path
  attr_reader :version
  attr_reader :bundle_version
  attr_reader :uuid
  attr_reader :downloadable_index_url
  attr_reader :available_simulators

  def initialize(path)
    @path = Pathname.new(path)
  end

  def version
    @version ||= fetch_version
  end

  def bundle_version
    @bundle_version ||= Gem::Version.new(plist_entry(':DTXcode').to_i.to_s.split(//).join('.'))
  end

  def uuid
    @uuid ||= plist_entry(':DVTPlugInCompatibilityUUID')
  end

  def downloadable_index_url
    @downloadable_index_url ||= begin
      if Gem::Version.new(version) >= Gem::Version.new('8.1')
        "https://devimages-cdn.apple.com/downloads/xcode/simulators/index-#{bundle_version}-#{uuid}.dvtdownloadableindex"
      else
        "https://devimages.apple.com.edgekey.net/downloads/xcode/simulators/index-#{bundle_version}-#{uuid}.dvtdownloadableindex"
      end
    end
  end

  def approve_license
    license_path = "#{@path}/Contents/Resources/English.lproj/License.rtf"
    license_id = IO.read(license_path).match(/\bEA\d{4}\b/)
    license_plist_path = '/Library/Preferences/com.apple.dt.Xcode.plist'
    `sudo rm -rf #{license_plist_path}`
    `sudo /usr/libexec/PlistBuddy -c "add :IDELastGMLicenseAgreedTo string #{license_id}" #{license_plist_path}`
    `sudo /usr/libexec/PlistBuddy -c "add :IDEXcodeVersionForAgreedToGMLicense string #{@version}" #{license_plist_path}`
  end

  def available_simulators
    @available_simulators ||= JSON.parse(`curl -Ls #{downloadable_index_url} | plutil -convert json -o - -`)['downloadables'].map do |downloadable|
      Simulator.new(downloadable)
    end
  rescue JSON::ParserError
    return []
  end

  def install_components
    # starting with Xcode 9, we have `xcodebuild -runFirstLaunch` available to do package
    # postinstalls using a documented option
    if Gem::Version.new(@version) >= Gem::Version.new('9')
      `sudo #{@path}/Contents/Developer/usr/bin/xcodebuild -runFirstLaunch`
    else
      Dir.glob("#{@path}/Contents/Resources/Packages/*.pkg").each do |pkg|
        `sudo installer -pkg #{pkg} -target /`
      end
    end
    osx_build_version = `sw_vers -buildVersion`.chomp
    tools_version = `/usr/libexec/PlistBuddy -c "Print :ProductBuildVersion" "#{@path}/Contents/version.plist"`.chomp
    cache_dir = `getconf DARWIN_USER_CACHE_DIR`.chomp
    `touch #{cache_dir}com.apple.dt.Xcode.InstallCheckCache_#{osx_build_version}_#{tools_version}`
  end

  :private

  def plist_entry(keypath)
    `/usr/libexec/PlistBuddy -c "Print :#{keypath}" "#{path}/Contents/Info.plist"`.chomp
  end

  def fetch_version
    output = `DEVELOPER_DIR='' "#{@path}/Contents/Developer/usr/bin/xcodebuild" -version`
    return '0.0' if output.nil? || output.empty? # ¯\_(ツ)_/¯
    output.split("\n").first.split(' ')[1]
  end
end

class Xcode
  attr_reader :date_modified
  attr_reader :name
  attr_reader :path
  attr_reader :url
  attr_reader :version
  attr_reader :release_notes_url

  def initialize(json, url = nil, release_notes_url = nil)
    if url.nil?
      @date_modified = json['dateModified'].to_i
      @name = json['name'].gsub(/^Xcode /, '')
      @path = json['files'].first['remotePath']
      url_prefix = 'https://developer.apple.com/devcenter/download.action?path='
      @url = "#{url_prefix}#{@path}"
      @release_notes_url = "#{url_prefix}#{json['release_notes_path']}" if json['release_notes_path']
    else
      @name = json
      @path = url.split('/').last
      url_prefix = 'https://developer.apple.com/'
      @url = "#{url_prefix}#{url}"
      @release_notes_url = "#{url_prefix}#{release_notes_url}"
    end

    begin
      @version = Gem::Version.new(@name.split(' ')[0])
    rescue
      @version = Installer::MINIMUM_VERSION
    end
  end

  def to_s
    "Xcode #{version} -- #{url}"
  end

  def ==(other)
    date_modified == other.date_modified && name == other.name && path == other.path && \
      url == other.url && version == other.version
  end

  def self.new_prerelease(version, url, release_notes_path)
    new('name' => version,
        'files' => [{ 'remotePath' => url.split('=').last }],
        'release_notes_path' => release_notes_path)
  end
end

req = Gem::Requirement.new(ARGV[0].to_s)

installer = Installer.new
installed = installer.installed_versions.reverse
xcode = installed.detect do |xcode|
  req.satisfied_by? Gem::Version.new(xcode.version)
end

xcode ||= installed.first
puts xcode.path

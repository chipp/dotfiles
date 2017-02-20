function xc {
  local xcode_proj
  xcode_proj=(*.{xcworkspace,xcodeproj}(N))

  if [[ ${#xcode_proj} -eq 0 ]]; then
    echo "No xcworkspace/xcodeproj file found in the current directory."
    return 1
  else
    echo "Found ${xcode_proj[1]}"
    _xc "${xcode_proj[1]}"
  fi
}

function _xc() {
  local app
  if [[ -e ".xcversion" ]] then
    xcode="Xcode-$(cat .xcversion).app"
    if [[ -e "/Applications/$xcode" ]] then
      app="-a$xcode"
    fi
  fi
  open "$1" $app
}

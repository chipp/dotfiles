#!/bin/zsh

error() {
    tput setaf 1
    echo $1 > /dev/stderr
    tput sgr0
}

warning() {
    tput setaf 3
    echo $1 > /dev/stderr
    tput sgr0   
}

info() {
    tput setaf 2
    echo $1
    tput sgr0   
}

download() {
    if [[ $(git diff --name-only --diff-filter=U | wc -l | tr -d ' ') -ne 0 ]];
    then
        error "There are unmerged files in the work tree"
        exit -1
    fi

    stashed_changes=0
    if [[ $(git diff --name-only | wc -l | tr -d ' ') -ne 0 || $(git diff --staged --name-only | wc -l | tr -d ' ') -ne 0 ]];
    then
        info "Stashing local changes"
        git stash
        stashed_changes=1
        echo
    fi

    info "Pulling remote changes..."
    git pull --rebase
    info "Pulled remote changes"
    echo

    if [[ $(git diff --name-only --diff-filter=U | wc -l | tr -d ' ') != 0 ]];
    then
        error "There are some conflicts after \`git pull --rebase\`"
        exit -1
    fi

    if [[ $stashed_changes -eq 1 ]];
    then
        info "Restoring stashed changes"
        git stash pop > /dev/null

        git --no-pager diff --name-only
        echo
    fi
}

copy() {
    info "Copying home dotfiles"
    cp $HOME/.dir_colors ./
    cp $HOME/.gemrc ./
    cp $HOME/.gitconfig ./
    cp $HOME/.gitignore_global ./
    cp $HOME/.p10k.zsh ./
    cp $HOME/.zshrc ./
    cp $HOME/.ssh/config ./ssh_config

    info "Copying Sublime Text settings"
    cp -r $HOME/Library/Application\ Support/Sublime\ Text/Packages/User/* \
        Library/Application\ Support/Sublime\ Text/Packages/User/

    info "Copying Sublime Merge settings"
    cp -r $HOME/Library/Application\ Support/Sublime\ Merge/Packages/User/* \
        Library/Application\ Support/Sublime\ Merge/Packages/User/

    info "Copying Xcode settings"
    cp $HOME/Library/Developer/Xcode/UserData/FontAndColorThemes/One\ Dark.xccolortheme \
        ./Library/Developer/Xcode/UserData/FontAndColorThemes/
    cp $HOME/Library/Developer/Xcode/UserData/KeyBindings/My.idekeybindings \
        ./Library/Developer/Xcode/UserData/KeyBindings/
}

commit() {
    unstaged=$(git diff --name-only)
    staged=$(git diff --staged --name-only)
    if [[ ${#unstaged[@]} -eq 0 && ${#staged[@]} -eq 0 ]];
    then
        warning "There are no local changes, nothing to upload"
        exit 0
    fi

    if [[ ${#unstaged[@]} -ne 0 ]];
    then
        git add ${unstaged[@]}
    fi

    files=("${unstaged[@]}" "${staged[@]}")
    files=($(printf "%s\n" "${files[@]}" | sort -u))

    info "Commiting files:"
    echo $(printf "%s\n" "${files[@]}")
    echo

    git commit -m "Automatic update $(date)"
    echo
}

upload() {
    info "Pushing local changes..."
    git push > /dev/null
    info "Pushed local changes"
}

download
copy
commit
upload

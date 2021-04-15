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
commit
upload

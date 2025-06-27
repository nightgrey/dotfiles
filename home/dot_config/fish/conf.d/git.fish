# Git version checking
set -l git_version (git version ^/dev/null | awk '{print $3}')
set -l is_v2 (string match -rq '^2\.([3-9][0-9]|[1-9][0-9][0-9]+)' $git_version)

#
# Functions Current
#

# The name of the current branch
function current_branch
    git rev-parse --abbrev-ref HEAD
end

# Check for develop and similarly named branches
function git_develop_branch
    git rev-parse --git-dir ^/dev/null; or return
    for branch in dev devel develop development
        if git show-ref -q --verify refs/heads/$branch
            echo $branch
            return 0
        end
    end
    echo develop
    return 1
end

# Check if main exists and use instead of master
function git_main_branch
    git rev-parse --git-dir ^/dev/null; or return
    for ref in refs/heads/main refs/heads/trunk refs/heads/mainline refs/heads/default refs/heads/stable refs/heads/master refs/remotes/origin/main refs/remotes/origin/trunk refs/remotes/origin/mainline refs/remotes/origin/default refs/remotes/origin/stable refs/remotes/origin/master refs/remotes/upstream/main refs/remotes/upstream/trunk refs/remotes/upstream/mainline refs/remotes/upstream/default refs/remotes/upstream/stable refs/remotes/upstream/master
        if git show-ref -q --verify $ref
            echo (string split -r / $ref)[-1]
            return 0
        end
    end
    echo master
    return 1
end

function grename
    if test (count $argv) -ne 2
        echo "Usage: grename old_branch new_branch"
        return 1
    end
    git branch -m $argv[1] $argv[2]
    if git push origin :$argv[1]
        git push --set-upstream origin $argv[2]
    end
end

#
# Functions Work in Progress (WIP)
#

function gunwipall
    set -l _commit (git log --grep='--wip--' --invert-grep --max-count=1 --format=format:%H)
    if test "$_commit" != (git rev-parse HEAD)
        git reset $_commit; or return 1
    end
end

function work_in_progress
    git -c log.showSignature=false log -n 1 ^/dev/null | grep -q -- "--wip--"; and echo "WIP!!"
end

#
# Aliases
#

alias grt='cd (git rev-parse --show-toplevel ^/dev/null; or echo .)'

function ggpnp
    if test (count $argv) -eq 0
        ggl; and ggp
    else
        ggl $argv; and ggp $argv
    end
end

alias ggpur='ggu'
alias g='git'
alias ga='git add'
alias gaa='git add --all'
alias gapa='git add --patch'
alias gau='git add --update'
alias gav='git add --verbose'
alias gwip='git add -A; and git rm (git ls-files --deleted) ^/dev/null; and git commit --no-verify --no-gpg-sign --message "--wip-- [skip ci]"'
alias gam='git am'
alias gama='git am --abort'
alias gamc='git am --continue'
alias gamscp='git am --show-current-patch'
alias gams='git am --skip'
alias gap='git apply'
alias gapt='git apply --3way'
alias gbs='git bisect'
alias gbsb='git bisect bad'
alias gbsg='git bisect good'
alias gbsn='git bisect new'
alias gbso='git bisect old'
alias gbsr='git bisect reset'
alias gbss='git bisect start'
alias gbl='git blame -w'
alias gb='git branch'
alias gba='git branch --all'
alias gbd='git branch --delete'
alias gbD='git branch --delete --force'

function gbda
    git branch --no-color --merged | grep -vE "^([+*]|\s*(" (git_main_branch) "|" (git_develop_branch) ")\s*\$)" | xargs git branch --delete ^/dev/null
end

function gbds
    set -l default_branch (git_main_branch)
    if not test $status -eq 0
        set default_branch (git_develop_branch)
    end
    git for-each-ref refs/heads/ "--format=%(refname:short)" | while read branch
        set -l merge_base (git merge-base $default_branch $branch)
        if test (git cherry $default_branch (git commit-tree (git rev-parse $branch^'{tree}') -p $merge_base -m _)) = -* 
            git branch -D $branch
        end
    end
end

alias gbgd='LANG=C git branch --no-color -vv | grep ": gone]" | cut -c 3- | awk \'{print $1}\' | xargs git branch -d'
alias gbgD='LANG=C git branch --no-color -vv | grep ": gone]" | cut -c 3- | awk \'{print $1}\' | xargs git branch -D'
alias gbm='git branch --move'
alias gbnm='git branch --no-merged'
alias gbr='git branch --remote'
alias ggsup='git branch --set-upstream-to=origin/(current_branch)'
alias gbg='LANG=C git branch -vv | grep ": gone]"'
alias gco='git checkout'
alias gcor='git checkout --recurse-submodules'
alias gcb='git checkout -b'
alias gcB='git checkout -B'
alias gcd='git checkout (git_develop_branch)'
alias gcm='git checkout (git_main_branch)'
alias gcp='git cherry-pick'
alias gcpa='git cherry-pick --abort'
alias gcpc='git cherry-pick --continue'
alias gclean='git clean --interactive -d'
alias gcl='git clone --recurse-submodules'
alias gclf='git clone --recursive --shallow-submodules --filter=blob:none --also-filter-submodules'

function gccd
    set -l repo $argv[-1]
    git clone --recurse-submodules $argv; or return
    if test -d $repo
        cd $repo
    else
        set -l dir (basename $repo .git)
        cd $dir
    end
end

alias gcam='git commit --all --message'
alias gcas='git commit --all --signoff'
alias gcasm='git commit --all --signoff --message'
alias gcs='git commit --gpg-sign'
alias gcss='git commit --gpg-sign --signoff'
alias gcssm='git commit --gpg-sign --signoff --message'
alias gcmsg='git commit --message'
alias gcsm='git commit --signoff --message'
alias gc='git commit --verbose'
alias gca='git commit --verbose --all'
alias 'gca!'='git commit --verbose --all --amend'
alias 'gcan!'='git commit --verbose --all --no-edit --amend'
alias 'gcans!'='git commit --verbose --all --signoff --no-edit --amend'
alias 'gcann!'='git commit --verbose --all --date=now --no-edit --amend'
alias 'gc!'='git commit --verbose --amend'
alias gcn='git commit --verbose --no-edit'
alias 'gcn!'='git commit --verbose --no-edit --amend'
alias gcf='git config --list'
alias gcfu='git commit --fixup'
alias gdct='git describe --tags (git rev-list --tags --max-count=1)'
alias gd='git diff'
alias gdca='git diff --cached'
alias gdcw='git diff --cached --word-diff'
alias gds='git diff --staged'
alias gdw='git diff --word-diff'

function gdv
    git diff -w $argv | view -
end

alias gdup='git diff @{upstream}'

function gdnolock
    git diff $argv ":(exclude)package-lock.json" ":(exclude)*.lock"
end

alias gdt='git diff-tree --no-commit-id --name-only -r'
alias gf='git fetch'
if test -n $is_v2
    alias gfa='git fetch --all --tags --prune --jobs=10'
else
    alias gfa='git fetch --all --tags --prune'
end
alias gfo='git fetch origin'
alias gg='git gui citool'
alias gga='git gui citool --amend'
alias ghh='git help'
alias glgg='git log --graph'
alias glgga='git log --graph --decorate --all'
alias glgm='git log --graph --max-count=10'
alias glods='git log --graph --pretty="%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ad) %C(bold blue)<%an>%Creset" --date=short'
alias glod='git log --graph --pretty="%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ad) %C(bold blue)<%an>%Creset"'
alias glola='git log --graph --pretty="%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset" --all'
alias glols='git log --graph --pretty="%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset" --stat'
alias glol='git log --graph --pretty="%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset"'
alias glo='git log --oneline --decorate'
alias glog='git log --oneline --decorate --graph'
alias gloga='git log --oneline --decorate --graph --all'

function _git_log_prettily
    if test (count $argv) -ge 1
        git log --pretty=$argv[1]
    end
end

alias glp='_git_log_prettily'
alias glg='git log --stat'
alias glgp='git log --stat --patch'
alias gignored='git ls-files -v | grep "^[[:lower:]]"'
alias gfg='git ls-files | grep'
alias gm='git merge'
alias gma='git merge --abort'
alias gmc='git merge --continue'
alias gms="git merge --squash"
alias gmff="git merge --ff-only"
alias gmom='git merge origin/(git_main_branch)'
alias gmum='git merge upstream/(git_main_branch)'
alias gmtl='git mergetool --no-prompt'
alias gmtlvim='git mergetool --no-prompt --tool=vimdiff'

alias gl='git pull'
alias gpr='git pull --rebase'
alias gprv='git pull --rebase -v'
alias gpra='git pull --rebase --autostash'
alias gprav='git pull --rebase --autostash -v'

function ggu
    set -l b (current_branch)
    if test (count $argv) -eq 1
        set b $argv[1]
    end
    git pull --rebase origin $b
end

alias gprom='git pull --rebase origin (git_main_branch)'
alias gpromi='git pull --rebase=interactive origin (git_main_branch)'
alias gprum='git pull --rebase upstream (git_main_branch)'
alias gprumi='git pull --rebase=interactive upstream (git_main_branch)'
alias ggpull='git pull origin "(current_branch)"'

function ggl
    if test (count $argv) -gt 1
        git pull origin $argv
    else if test (count $argv) -eq 1
        git pull origin $argv[1]
    else
        git pull origin (current_branch)
    end
end

alias gluc='git pull upstream (current_branch)'
alias glum='git pull upstream (git_main_branch)'
alias gp='git push'
alias gpd='git push --dry-run'

function ggf
    set -l b (current_branch)
    if test (count $argv) -eq 1
        set b $argv[1]
    end
    git push --force origin $b
end

alias 'gpf!'='git push --force'

if test -n $is_v2
    alias gpf='git push --force-with-lease --force-if-includes'
else
    alias gpf='git push --force-with-lease'
end

function ggfl
    set -l b (current_branch)
    if test (count $argv) -eq 1
        set b $argv[1]
    end
    git push --force-with-lease origin $b
end

alias gpsup='git push --set-upstream origin (current_branch)'
if test -n $is_v2
    alias gpsupf='git push --set-upstream origin (current_branch) --force-with-lease --force-if-includes'
else
    alias gpsupf='git push --set-upstream origin (current_branch) --force-with-lease'
end
alias gpv='git push --verbose'
alias gpoat='git push origin --all; and git push origin --tags'
alias gpod='git push origin --delete'
alias ggpush='git push origin "(current_branch)"'

function ggp
    if test (count $argv) -gt 1
        git push origin $argv
    else if test (count $argv) -eq 1
        git push origin $argv[1]
    else
        git push origin (current_branch)
    end
end

alias gpu='git push upstream'
alias grb='git rebase'
alias grba='git rebase --abort'
alias grbc='git rebase --continue'
alias grbi='git rebase --interactive'
alias grbo='git rebase --onto'
alias grbs='git rebase --skip'
alias grbd='git rebase (git_develop_branch)'
alias grbm='git rebase (git_main_branch)'
alias grbom='git rebase origin/(git_main_branch)'
alias grbum='git rebase upstream/(git_main_branch)'
alias grf='git reflog'
alias gr='git remote'
alias grv='git remote --verbose'
alias gra='git remote add'
alias grrm='git remote remove'
alias grmv='git remote rename'
alias grset='git remote set-url'
alias grup='git remote update'
alias grh='git reset'
alias gru='git reset --'
alias grhh='git reset --hard'
alias grhk='git reset --keep'
alias grhs='git reset --soft'
alias gpristine='git reset --hard; and git clean --force -dfx'
alias gwipe='git reset --hard; and git clean --force -df'
alias groh='git reset origin/(current_branch) --hard'
alias grs='git restore'
alias grss='git restore --source'
alias grst='git restore --staged'
alias gunwip='git rev-list --max-count=1 --format="%s" HEAD | grep -q "\--wip--"; and git reset HEAD~1'
alias grev='git revert'
alias greva='git revert --abort'
alias grevc='git revert --continue'
alias grm='git rm'
alias grmc='git rm --cached'
alias gcount='git shortlog --summary --numbered'
alias gsh='git show'
alias gsps='git show --pretty=short --show-signature'
alias gstall='git stash --all'
alias gstaa='git stash apply'
alias gstc='git stash clear'
alias gstd='git stash drop'
alias gstl='git stash list'
alias gstp='git stash pop'
if test -n $is_v2
    alias gsta='git stash push'
else
    alias gsta='git stash save'
end
alias gsts='git stash show --patch'
alias gst='git status'
alias gss='git status --short'
alias gsb='git status --short --branch'
alias gsi='git submodule init'
alias gsu='git submodule update'
alias gsd='git svn dcommit'
alias git-svn-dcommit-push='git svn dcommit; and git push github (git_main_branch):svntrunk'
alias gsr='git svn rebase'
alias gsw='git switch'
alias gswc='git switch --create'
alias gswd='git switch (git_develop_branch)'
alias gswm='git switch (git_main_branch)'
alias gta='git tag --annotate'
alias gts='git tag --sign'
alias gtv='git tag | sort -V'
alias gignore='git update-index --assume-unchanged'
alias gunignore='git update-index --no-assume-unchanged'
alias gwch='git whatchanged -p --abbrev-commit --pretty=medium'
alias gwt='git worktree'
alias gwta='git worktree add'
alias gwtls='git worktree list'
alias gwtmv='git worktree move'
alias gwtrm='git worktree remove'
alias gstu='gsta --include-untracked'
function gtl
    git tag --sort=-v:refname -n --list "$argv[1]*"
end
alias gk='gitk --all --branches &'
alias gke='gitk --all (git log --walk-reflogs --pretty=%h) &'

set -e git_version

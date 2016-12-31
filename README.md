# dotfiles

My personal dotfiles (for Mac OS). This was mainly built for my own Mac, but as I'm always curious to check [other people's setups](https://dotfiles.github.io/) for cool stuff, feel free to take a look (and especially take what's useful to you)! 

I'm still working on versioning all of my configuration, so there may be some missing things. The essentials are there, though - the rest will be added soon™.

## Setup

_Note: The following steps were never tested. I created this repository shortly after I started configuring a new Mac. I have to try and refine this soon™._

1.  Install brew with `/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"`
2.  `brew install` with [brew/brew-packages](brew-packages)
3.  `brew cask install`from [brew/cask-packages](cask-packages)
4.  Symlink shell configuration with `ln -s ./shell/.* ~/`
5.  Symlink git configuration with `ln -s ./git/.* ~/`
6.  Symlink `oh-my-zsh` custom folder with `rm -r ~/.oh-my-zsh/custom && ln -s ./oh-my-zsh ~/.oh-my-zsh/custom`
7.  Copy SSH keys from backup

### NVM

1.  `nvm install node` to install the latest node version and set it as default

## Todos, ideas and notes

-   Automation, but how?
    -   [Kody, a dotfile and environment manager based on node.js](https://github.com/jh3y/kody)
    -   Ansible
        1.  <https://github.com/fgimian/macbuild>
        2.  <https://github.com/geerlingguy/mac-dev-playbook>
        3.  <https://github.com/mtneug/cfg_mgmt-macos>
    -   Shell script
        1.  <https://github.com/nicksp/dotfiles/blob/master/setup-new-machine.share>
-   This would probably come with the ansible automation, (there are homebrew roles) but ultimately, it'd be awesome to `brew install` => update package list.
-   Encrypt (and thus commit) sensitive data (~/.ssh/ or similar)
-   Command to automatically install from the brew/cask package lists; I have not yet tested if `brew install < .brew-packages` works.
-   Documentation

If you have some awesome or fancy stuff you want to share, well, don't hesitate. I'm open for anything.

## License

MIT.

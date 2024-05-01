# My Dotfiles

This repository contains my personal dotfiles. They contain configuration files for my system, including my terminal, shell, and other tools.

![neofetch](/docs/banner.png)

I've picked up a lot from other developers' dotfiles, which is why I decided to share mine as well. Feel free to copy and use anything as you see fit. Read the source, Luke!

> Note: It is not meant to be copied and run; as it is tailored to my system. Use it as a source for inspiration!

## How I use this repository

**1. Clone to my local machine**

```sh
git clone https://github.com/nightgrey/dotfiles.git
```

**2. Symlink files**

Anything in [`home`](/home/) belongs in `~`, anything in [`root`](/root/) in `/`. By symlinking `.zshrc`, everything in `zsh` will automatically be sourced.

> **Note**: It assumes certain tools to be installed, including but not limited to [zsh](https://www.zsh.org/), [kitty](https://sw.kovidgoyal.net/kitty/), [starship](https://starship.rs/), [git](https://git-scm.com/), [asdf](https://asdf-vm.com/), and [znap](https://github.com/marlonrichert/zsh-snap). I haven't put a list of dependencies here, yet. Maybe one day. For now, it's easiest to just install what is missing, when it is missing. 🤷‍♂️

**3. Use things!**

## Contributing

Feel free to fork this repository and customize it to your liking. If you have any suggestions or improvements, please submit a pull request.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

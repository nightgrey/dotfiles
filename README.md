# Dotfiles

This repository contains my personal dotfiles. They contain configuration files for my system, including my terminal, shell, and other tools.

![neofetch](/docs/banner.png)

I've picked up a lot from other developers' dotfiles, which is why I decided to share mine as well. Feel free to copy and use anything as you see fit. Read the source, Luke!

> Note: It is not meant to be copied and run - I mean, technically you could, but it is tailored to my system. It is 
> meant to be an inspiration, but use it however you like! :)

## How I use this repository

**1. Clone to my local machine**

```sh
git clone https://github.com/nightgrey/dotfiles.git ~/.dot
```

**2. Symlink files**

[`lib`](/lib/) represents `~`. I never automated the symlinking process, so I just manually symlink things:

```sh
ln -s ~/.dot/lib/* ~/
ln -s ~/.dot/lib/.config/* ~/.config/
ln -s ~/.dot/lib/.local/share/* ~/.local/share
```

> Note: It assumes tooling (like [zsh](https://www.zsh.org/), [ghostty](https://ghostty.org), 
> [starship](https://starship.rs/), [git](https://git-scm.com/), [mise](https://mise.sh/) and [zinit](https://github.com/zdharma/zinit)) to be installed.

**3. Use things!**

**Resources**

- https://github.com/davgar99/arch-linux-font-improvement-guide#improving-font-rendering-and-compatibility-on-arch-linux

## Contributing

Feel free to fork this repository and customize it to your liking. If you have any suggestions or improvements, please submit a pull request.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---
layout page:
title: Getting Started
nav_order: 1
---
# Getting Started
{: .no_toc }

#### Table of contents
{: .no_toc }
- TOC
{:toc}

Before you start learning development, let's set up our development environment.

## Installing a patched font

For some symbols to show up properly in our command line, we need to install a patched nerd-font from the [Nerd Fonts Respotitory](https://github.com/ryanoasis/nerd-fonts). I personally use the Hack Nerd font. You can download it [here](https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/Hack/Regular/complete/Hack%20Regular%20Nerd%20Font%20Complete%20Mono.ttf).

## Windows

If you're on Windows, I recommend installing a Ubuntu subsystem. Since Windows 10, Microsoft has added a Windows Subsystem for Linux (WSL) feature enabling you to install an isolated Linux subsystem on your Windows machine. Linux is a fast and versatile operating system preferred by most developers.

### Enabling the Windows Subsystem for Linux Feature

To use WSL, we first need to enable it via the Control Panel. Open your start menu using the `Win` key and search for `Turn Windows features on or off`. Scroll down to the bottom and check the box for `Windows Subsystem for Linux`. It will prompt you to restart your machine.

### Installing WSL

To enable WSL and install Ubuntu, which is a distribution of Linux, follow the instructions from [Install Linux On Windows with WSL](https://docs.microsoft.com/en-us/windows/wsl/install) at Microsoft. Note that you may have to follow the guide [Manual installation steps for older versions of WSL](https://docs.microsoft.com/en-us/windows/wsl/install-manual) if you are on an older build of Windows.

### Installing Windows Terminal

I recommend installing the Windows Terminal app as your terminal emulator. This is the program that you will use to access your Ubuntu installation and input commands. You can find it at the Microsoft Store [here](https://apps.microsoft.com/store/detail/windows-terminal/9N0DX20HK701?hl=en-us&gl=US).

#### Set Ubuntu as the default profile

Open up Windows Terminal and click the dropdown menu in the tab bar, then click `Settings`. Set your default profile to `Ubuntu` so it will open the command prompt to your Ubuntu installation by default. Open a new tab and it should take you your Ubuntu installation.

#### Configure Font Settings

Go to `Settings` in Windows Terminal, then click the hamburger icon in the top left. Click `Defaults` under the Profiles, go to `Appearance`, and select `Hack Nerd Font Mono` as your font face.

### Installing Build Tools

Now that we've installed Ubuntu, if you open it in Windows Terminal, you should see something like this:

```sh
zane@Zane-PC:~$ _
```

This is called the _command prompt_ — used for entering commands to your Linux system. Let's start by installing some useful packages. Paste the following command into your terminal (you may need to use `Ctrl+Shift+V`) and press `Enter`:

```sh
sudo apt-get update && sudo apt-get install -y bat build-essential libssl-dev \
libreadline-dev clang clang-format cmake python3-dev nodejs npm ruby ruby-dev
```

Note that it will prompt you for the password you set when you first installed Ubuntu. You should see a lot of text showing things being downloaded and installed.

Let's break down this command.

* `sudo` is a command put in front of other commmands to indicate to run that command as admin. It stands for 'superuser do'. We often need to put `sudo` in front of commands that will modify our system, such as installing packages or deleting important files.

* `apt-get` is the command for the APT Package Manager, which manages installing software on your system.

* `update` tells `apt-get` to refresh all package sources.

* `&&` allows us run multiple commands with one input, so everything before  `&&` is one command, and everything after is a separate one. Here we use it for convenience, but entering both as separate commands would work too.

* `install` tells `apt-get` that we would like to install some packages, and the `-y` is a flag (flags modify the behavior of commands) that will skip any confirmation prompts. After the `-y` are all the packages we want to install, separated by spaces. All of these packages are available in the default repositories available to Ubuntu, so there should be no need to add any additional ones. The `\` after 'libssl-dev' allows us to split the command to a new line so we can easily read it all.

## macOS

macOS is a Unix-based operating system (which means it derived from a very old operating system from the 1970s), and already includes a lot of the things we need from Ubuntu. Most if not all of the commands listed in [Lesson 1.1: The Command Line](../lessons/lesson_1/lesson_1_1.md) will still work on macOS out of the box. The one thing I would recommend is installing a package manager. This makes it easier to install development tools I will reference in future lessons.

### Installing brew

Installing brew is pretty simple, it just takes a single command. Follow the installation instructions at [brew.sh](https://brew.sh).

### Installing iTerm2

The default Terminal application on macOS is pretty lackluster. If you would like a better one, I would recommend iTerm2. You can download it for free from [iterm2.com](https://iterm2.com).

Make sure to go into the settings and change the font to the newly-installed nerd font.

## Conclusion

That's it! You should now have a decent developement environment. Continue with [Lesson 1.1: The Command Line](../lessons/lesson_1/lesson_1_1.md) to learn more about how to navigate the command line.

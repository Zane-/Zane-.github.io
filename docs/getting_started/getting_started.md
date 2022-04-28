---
layout page:
title: Getting Started
nav_order: 1
---
# Getting Started

Before you start learning how to code, let's get a proper development environment going.


## Windows

If you're on Windows, I recommend installing a Ubuntu subsystem. Since Windows 10, Microsoft has added a Windows Subsystem for Linux (WSL) feature enabling you to install an isolated Linux subsystem on your Windows machine. Linux is a fast and versatile operating system preferred by most developers.

### Enabling the Windows Subsystem for Linux Feature

To use WSL, we first need to enable it via the Control Panel. Open your start menu using the `Win` key and search for `Turn Windows features on or off`. Scroll down to the bottom and check the box for `Windows Subsystem for Linux`. It will prompt you to restart your machine.

### Installing WSL

To enable WSL and install Ubuntu, which is a distribution of Linux, follow the instructions from [Install Linux On Windows with WSL](https://docs.microsoft.com/en-us/windows/wsl/install) at Microsoft. Note that you may have to follow the guide [Manual installation steps for older versions of WSL](https://docs.microsoft.com/en-us/windows/wsl/install-manual) if you are on an older build of Windows.


### Installing Windows Terminal

I recommend installing the Windows Terminal app as your terminal emulator. This is the program that you will use to access your Ubuntu installation and input commands. You can find it at the Microsoft Store [here](https://apps.microsoft.com/store/detail/windows-terminal/9N0DX20HK701?hl=en-us&gl=US)

#### Set Ubuntu as the default profile

Open up Windows Terminal and click the dropdown menu in the tab bar, then click `Settings`. Set your default profile to `Ubuntu` so it will open the command prompt to your Ubuntu installation by default. Open a new tab and it should take you your Ubuntu installation.

### Setting up Ubuntu

If you want a one-touch install for a sensible setup, you can install my dotfiles from github. From your terminal, enter the command:

```
git clone http://github.com/zane-/dotfiles && cd dotfiles && ./setup.sh
```

Enter `y` for `Install dependencies and tools? (y/n)`, `y` for `Are you on WSL and wanting to install Rust? (y/n)`, and `n` for `Install i3-gaps setup? (y/n)`

Note that this step may take a while depending on your internet connection.

That's it! You should now have a decent developement environment. Continue with [Lesson 1: The Linux Command Line](../lessons/lesson_1.md) to learn more about how to navigate the command line.


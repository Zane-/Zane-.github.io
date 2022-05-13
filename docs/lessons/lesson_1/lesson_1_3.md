---
layout: page
title: "1.3 Enhancing the Command Line"
parent: Lesson 1
grand_parent: Lessons
nav_order: 3
---
# Lesson 1.3: Enhancing the Command Line
{: .no_toc }

#### Table of contents
{: .no_toc }
- TOC
{:toc}

In [Lesson 1.1](lesson_1_1.html), we learned commands for navigating directories and managing files. In this lesson we will learn more about shells, what scripts are and how to execute them, and some better and faster ways of navigating your command line.

## Upgrading your Shell

As previously stated in Lesson 1.1, a shell is the program that processes your commands, and the shell that ships with most distributions of Linux is called bash. The shell I recommend is called _zsh_, and it has a rich community that creates plugins for it to make life easier. To install zsh and a sensible configuration for it, you can clone my dotfiles repo from Github:

```sh
$ git clone https://github.com/zane-/dotfiles ~/dotfiles && cd ~/dotfiles
```

This command will first clone the repo to your home directory, then `cd` into it. If you `ls`, you'll see there are several files and folders, some ending in `.sh`. A file that ends in `.sh` is known as a _shell script_. In short, a shell script is a program that executes multiple commands and has some programming language constructs. If you peer into one using `cat`, you'll see some familiar commands such as `apt-get`, `mv`, `cd`, and more. Shell scripts provide an excellent way to automate long and complex tasks or reproduce something on another system.

The shell scripts I have created in my dotfiles repo contain scripts to replicate my command line setup on any Ubuntu system. To run the script `zsh.sh`, which will install `zsh` and a couple of other useful tools, enter the command:

```sh
$ ./zsh.sh
```

`./` followed by an executable filename is how you run an executable from the command line. As the script runs, you should see output indicating things being installed, created, and linked. After the script finishes, enter `cd` to return to your home directory, and enter `ls -a` to show all files. You should now see some new files such as `.zshrc`, `.zshenv` and `.zpreztorc`. These are configuration files used by zsh that determine the behavior and features of your shell.

Now, we need to change our default shell from bash to zsh. Run the following command:

```sh
$ chsh -s /bin/zsh
```

`chsh` means 'change shell', then we provide it the filepath to the zsh executable. Most executables on Linux systems are located in `/bin/`, but there are several other directories too. If you enter the command `zsh` now, zsh should start and diplay a new command prompt.

Note that if you skipped installing fonts in [Getting Started](../../getting_started), certain characters will not display correctly.

### Included zsh Plugins

Note that the features described here are not built-in to zsh by default, but are plugins hosted on Github.

* __Command highlighting__: Commands you type that exist will be in green, while non-existent commands will be in red. Additionally, when you type in the prefix to a command that you have entered previously, the rest will show greyed-out. You can press the right arrow key to complete it.

* __Git integration__: The status of your repo will be displayed on your prompt. It will show you what branch you are on, and will display an up arrow if you have a commit to push, or a down arrow if you have a commit to pull.

## File Permissions

All files and directories in Linux has file permissions associated with them. Permissions fall into three categories, _read_, which grants permission to view the file; _write_, which grants permission to modify the file; and _execute_, which grants permission to execute or run the file.

### Viewing Permissions

To view the permissions of files, you can pass the `-l` flag to `ls`. This will show more info, including the permissions, filesize, owner, and last modified date. Run the command in your home directory:

```sh
$ ls -la
```

You should see a big list of files. On the very left of each row are the file permissions. The first letter indicates the type of the file, 'd' for directory, '-' for file, or 'l' for link. A link is just like a shortcut — it points to the real file. After the filetype, there are three sets of three characters. Each set of three characters describes the permissions for a certain set of users.

The first character is for read permission, it will be `r` if read permission is granted, or `-` if not. Next is the character `w` for write permission, and `x` for execute permission.

The first set of rwx permissions is for the owner, which is the user who created the file. The next set is for any user who is in the same group as the owner (a group in linux is just a label given to a set of users), and the last set is for everyone else.

In conclusion, you would read the permission `drwxr-xr-x` as a "directory that grants the owner read, write, and execute permission, the owner's group read and execute, but not write permissions, and everyone else only read and execute permission as well.

### Changing Permissions

You can change the permission of a file or directory by using the `chmod` command. The `chmod` command takes a numeric representation of the permission to set along with the file to change it for.

The numeric representation is three digits, where each digit is either 7, 6, 3, or 0 and corresponds to the same ordering of permission sets previously mentioned: owner, owner's group, everyone else.

To calculate the digit to use, you add up the integer values corresponding to the permission you want to grant:

| Permission | Integer |
|------------|---------|
| read       | 4       |
| write      | 2       |
| execute    | 1       |

So to give a set of users read and write permissions, you would add up 4 and 2 to get a 6. To grant all 3, you would add up 4, 2, and 1 to get 7. To grant no permission, you would use 0.

Thus, the corresponding integer for the permission `rwxr-xr-x` would be 755.

Now, let's change the permissions of one of the scripts we ran earlier to demonstrate `chmod`. First, navigate to the dotfiles repo using `cd ~/dotfiles`. Then, strip the `zsh.sh` script we ran earlier of its execute permission:

```sh
$ chmod 666 zsh.sh
```

Try running `zsh.sh` again by entering `./zsh.sh`. You should see:

```
zsh: permission denied: ./zsh.sh
```

Run `ls -l zsh.sh` to note that the 'x' character is missing from the file permissions. You can restore the execute permission by adding 1 to each digit:

```sh
$ chmod 777 zsh.sh
```

Check `ls -l zsh.sh` again to see that the 'x' is back.

If you are on a Linux system shared by multiple people (each with their own user), file permissions are a simple but secure way to restrict file access to only the people that should have it.

## The $PATH Environment Variable

At this point, you may be wondering how Linux knows what commands exist and what commands do not. The answer is the `$PATH` environment variable. As discussed earlier, an environment variable is a named variable accessible anywhere on your system and is often used to set default behavior such as text editors, browsers, and more.

The `$PATH` variable is a list of directories separated by colons, for example `/usr/share/bin:/usr/local/bin:/usr/bin`. Any executables in one of the directories in the list will be made available to run as a command from your shell. You can view your own `$PATH` variable by entering the command `echo $PATH`.

If you ever install something on your Linux system that you expect to be runnable as a command and it says "command not found," it is likely due to wherever the commmand executable is installed not being in `$PATH`. The way to fix this is to update your shell's configuration files to include the missing directory.

If you peer into `~/.zshenv` with `cat ~/.zshenv`, you will see the line:

```sh
export PATH="$HOME/.local/bin:$HOME/.npm-packages/bin:$PATH"
```

This line uses the `export` command, which modifies an environment variable, then specifies `PATH` as the variable name to change. You'll then notice we reference the `$HOME` environment variable in the value, which points to our home directory, add a few more directories separated by colons, and then end it with `$PATH`. Ending with `$PATH` is essential here so we don't overwrite it completely; this includes whatever directories `$PATH` used to have.

## Command Aliases

An alias is another way to refer to a command. Typically they are created to shorthand otherwise long commands. A few I use are the aliases `gpom` for `git push origin main` and `agi` for `sudo apt-get install`. If you enter the command `alias`, all the aliases set on your system will be displayed. If you installed my zsh setup earlier, you'll see I created quite a few.

You can set an alias by using the `alias` command followed by the alias, an `=` sign, and then the command you want to create an alias for wrapped in quotes. For example:

```
$ alias cls="clear"
```

The `clear` command clears the output on your terminal, after we run this command, we can now run the `clear` command with the alias `cls`. However, aliases set this way do not persist across reboots. To persist an alias, we need to add them to our shell configuration so they are loaded each time we start our shell.

If you run the command `cat ~/.zshrc`, you should see:

```sh
# Source aliases
source ~/dotfiles/.aliases
```

The `source` command takes a file and executes the commands in it. If you run `cat ~/dotfiles/.aliases`, you will see a long list of `alias` commands, one per line. When your zsh shell first loads, the `~/.zshrc` file will be loaded, which then loads the `~/dotfiles/.aliases` file.

If you ever want to declare your own aliases, you can add them to this file, then run the command `sal` manually (which is an alias to `source ~/dotfiles/.aliases`), or, you could create your own file somewhere else and source it in the file `~/.zshrc`. Note that changes to the `~/.zshrc` file don't take effect until you source that file using the `source` command or restart zsh.

## Productivity Tools

### tmux

tmux stands for 'terminal multiplexer'. It is a program that runs in your shell that allows you to run multiple programs in one terminal window. You can split your terminal vertically or horizontally into 'panes' and can create as many as you want. This is very useful for doing multiple things as once, such as editing multiple files while running another program. You can install my tmux setup by using my installation script:

```sh
$ cd ~/dotfiles && ./tmux.sh
```

This will install tmux to your system, copy over some configuration, and install plugins. After the script completes, you will need to run the command `source ~/.zshrc` (or the alias `sz`) again to reload your shell. If you see the line `.tmux.conf:12: no current session`, hit `q` and it should start one. You should now see a status bar at the bottom of your terminal, indicating your username, hostname, running program, and the time.

#### tmux shortcuts

To enter a tmux shortcut, you first press the assigned prefix key. I have set this to be `Ctrl+a`: if you press `Ctrl+a`, you should see a symbol with `^A` on the status bar. This symbol indicates tmux is ready to receive a command.

Here is an abridged table of shortcuts in tmux and what they do (note that this is my personal configuration and not anything default to tmux):

| Key   | Action                        |
|-------|-------------------------------|
| `v`   | Vertical split                |
| `s`   | Horizontal split              |
| `tab` | Cycle between panes           |
| `x`   | Kills currently selected pane |
| `c`   | Creates a new window          |
| `n`   | Cycles to next window         |
| `p`   | Cycles to previous window     |
| `&`   | Kills current window          |

You can resize your panes by clicking and dragging with your mouse at the border, and you can right click any of the panes as well to close them or create another split within them.  For a full list of shortcuts, you can look in the file `~/.tmux.conf`, or consult the internet for the default shortcuts.

### fasd

fasd is a tool that makes navigating directories and editing files a lot quicker. It stores a database of your most-used directories, and when you type in a fasd command along with a substring of a directory you want to jump to, it will intelligently complete the rest of the directory you likely intended. As soon as you installed zsh, `fasd` has been tracking the directories you've visited.

If you try the command:

```
$ z do
```

It should jump you to the `dotfiles` directory given you've visited it since installation of zsh.

You can make the substring you use as long or short as you want, you just need to disambiguiate it from any other directories that have the same substring. For example, if there was another directory called `door` that you've visited more often than `dotfiles`, then we would need to enter `dot` as our prefix to ensure `door` isn't picked. You can also use the `zz` command to have a choice of what directory to navigate to in the case there are multiple directories sharing the same substring you used.

See the bottom of `~/dotfiles/.aliases` for a full list of fasd command aliases.

### fzf

fzf is a command that lets you search for a text pattern in the output of another command. I have added shortcuts to zsh to invoke it.

If you press `Ctrl+t`, a tmux pane should popup (note that nothing will happen if you didn't install tmux), and you can search for any file in your current directory as well as any nested directories. A preview of the file will also be displayed. Pressing `Enter` on the selected file will paste it into your command prompt, so if you are typing a command that takes a file, you can type the command, then use `Ctrl+t` to search for the file you want.

Another useful shortcut is `Ctrl+r` this opens up a tmux pane containing your command history. You can search for any command you have previously entered and paste it into your command prompt.


Additionally, you can use `Alt+c` to open a tmux pane that will allow you to search for a directory and `cd` into it.

### exa

exa is an enhanced version of the `ls` command that includes icons for files as well as better coloring. To install it, we need to add a PPA. PPA stands for personal package archive, and they allow you to add another source to the `apt` package manager to install things from. To install exa, run the command:

```sh
$ sudo add-apt-repository ppa:spvkgn/exa && sudo apt-get update && sudo apt-get install exa
```

This command will add the new PPA repository, refresh APT, then install exa. Below are the aliases I use to run the `exa` command:

| Command | Action                       |
|---------|------------------------------|
| `l`     | Lists all files              |
| `la`    | Lists all files, same as `l` |
| `ll`    | Lists details for all files  |

### bat

bat is an enhanced version of `cat` that includes syntax highlighting, line numbers, and more. If you installed my zsh setup using the `zsh.sh` script, you should already have it. Enter the command:

```
bat ~/.zshrc
```

It will open a scrollable view of the `~/.zshrc` file. Navigate with the arrow keys, or press `q` to quit. If a file is small enough to fit on-screen, bat will display it directly instead of opening another window.

### ripgrep

ripgrep is just like the `grep` command, it searches for patterns in files, but it is a lot faster and a little easier to use. It should already be installed if you ran the `zsh.sh` script; the command is `rg`. The basic usage is `rg` followed by the text pattern to search for, then optionally a file to search in. If no file is given, it will search all files in the current directory as well as any subdirectories. Note that by default, ripgrep does not search hidden files (files starting with '.'), you must pass the `--hidden` flag to search these files.

To search for all files with the pattern 'alias' in them, we would enter:

```sh
rg --hidden alias
```

You should see a bunch of files returned along with the line numbers where the word 'alias' occurred.

## tldr

* A script is a file containing a series of commands and other logic that can be executed.

* zsh is a good alternative to bash and is more feature-rich.

* File permissions control who can read, write, or execute files. They can be changed with the `chmod` command and viewed with the `ls -l` command.

* The `$PATH` environment variable is how your linux system knows what commands are available, and it is a colon-separated list of directories.

* A command alias is another way to refer to a command. The `alias` command displays all aliases on your system.

* PPA stands for personal package archive, and is how you can add third-party repositories as a source for the APT package manager.

* tmux is a program that lets you run multiple shells in your terminal at once.

* fasd is a program that keeps track of your visited directories and lets you jump to them with shortcuts.

* fzf is a program that lets you search through the output of other commands with text patterns.

* exa is an improved version of `ls` with file icons and better color highlighting.

* bat is an improved version of `cat` with syntax highlighting and line numbers.

* ripgrep is an improved version of `grep` and can search files for text patterns very quickly.

## Conclusion

If you followed through this lesson, you should now have a very powerful terminal set-up that will enable you to multitask and quickly navigate between files and directories. Continue to [Lesson 1.4: Text Editors](lesson_1_4.html) to pick a text editor to use for programming.


---
layout: page
title: "1.1 The Linux Command Line"
parent: Lessons
---
# Lesson 1.1: The Linux Command Line
{: .no_toc }

#### Table of contents
{: .no_toc }
- TOC
{:toc}

In this lesson we will explore the Linux Command Line and learn some basic commands to deal with creating and navigating files. Skip ahead to [tldr](#tldr) if you want a quick summary.

A program that processes commands is called a _shell_. There are many different shells out there, some popular ones being zsh and fish, but the shell that ships with most distributions of Linux is bash. It stands for <ins>B</ins>ourne <ins>a</ins>gain <ins>sh</ins>ell.

Open up your terminal, and once again you should see something like:

```sh
zane@Zane-PC:~$
```

From now on, I will shorthand this to:

```sh
$
```

When you see `$`, that means anything you see after should be entered into your command prompt, not including `$`.

One thing you should know that if any command seems to freeze, or you want to cancel it for any reason, use `Ctrl+c`. If that doesn't work, try pressing  `Ctrl+d` or `q`.

## File Commands

### Viewing Files

The directory you are currently in is displayed in your prompt. When you first open your terminal, it will open to your home directory by default. The home directory in Linux is referred to by `~`.

To list all the files in your current directory, enter the command:

```sh
$ ls
```

You should see nothing. This is because by default, `ls` does not show hidden files. Files in Linux are hidden if they start with a `.`. Now try:

```sh
$ ls -a
```

Note that `-a` is a flag being passed to the `ls` command, it means 'all', and tells `ls` to show all files, even hidden ones. You should see something similar to:


```
.  ..  .bash_history  .bash_logout  .bashrc  .landscape  .motd_shown  .profile  .sudo_as_admin_successful
```

Tip: You can use the up arrow key in your command line to cycle between your last-used commands.

You can also pass a directory to `ls` to list the files there instead of the current directory. Try `ls /` to list the contents of the root directory.

The `ls` command has various flags that do different things. To view them all, you can use the `man` command, short for 'manual'. In general, you can enter `man` followed by any command and it will give you detailed instructions on how to use it. Try:

```sh
$ man ls
```

You can scroll through the output with your arrow keys, and press `q` to quit when finished.

Now, let's print the contents of one of these files. The `cat` command is the simplest command to do so:

```sh
$ cat .bashrc
```

The contents of `.bashrc` should now be displayed on your terminal, and you can scroll up to read all of it. To look at the contents of a file without flooding our terminal with it, we can use the command `less`:

```sh
$ less .bashrc
```

This should open .bashrc in a scrollable view. Press `q` to exit `less`.

### Managing Files

You can create a new file by using the `touch` command. `touch` is a command that normally updates the timestamps of file access/modification, but if you give it a file that doesn't exist, it creates it.

```sh
$ touch file.txt
```

Now, enter `ls` and you should see your `file.txt` file there. Let's open our file in a text editor and give it some content. The simplest file editor on Linux is `nano`. Use it by entering the command:

```sh
$ nano file.txt
```

Enter some text, then press `Ctrl+O` and then `Enter` to save the file, then `Ctrl+X` to exit `nano`. Display the contents of your file using `cat` and it should display what you wrote to the terminal.

Let's move `file.txt` into its own directory (aka folder) now. The `mkdir` command is used to make directories:

```sh
$ mkdir files
```

One caveat with the `mkdir` command is if you're creating a nested directory, i.e. `files/more_files/even_more_files`, it will fail with the error:

```
mkdir: cannot create directory 'files/more_files/even_more_files': No such files or directory
```

It says this because the parent directory of `even_more_files`, `more_files`, does not exist yet. We can pass the `-p` flag to `mkdir` to create any parent directories needed:

```sh
mkdir -p files/more_files/even_more_files
```

The command should now succeed.

If you enter `ls` now, you should see your `files` directory in blue alongside the `file.txt` file. To move `file.txt` into the `files` directory, use the `mv` command:

```sh
$ mv file.txt files
```

The `mv` command first takes the file or directory you want to move, then the destination. This command is saying take `file.txt` and move it into the files directory. Enter `ls` and you should only see `files` now.

You can also rename a file using the `mv` command:

```sh
$ mv file.txt file_new_name.txt
```

If the directory you are trying to move your file into doesn't exist, you will rename the file instead.

To change into a different directory, use the `cd` command, short for 'change directory':

```sh
$ cd files
```

Note that entering `cd` by itself is a shortcut to return to your home directory.

You should now see that your prompt has changed to `~/files`, indicating that you are in the files directory within your home directory. Enter `ls` and you should see your `file.txt` file.

To copy files, use the `cp` command. The `cp` command takes the file or directory you want to copy, then the destination to copy it to, which includes the filepath and filename:

```sh
$ cp files.txt files_copy.txt
```

Enter `ls` and you should see your copied `files_copy.txt` file. Use `cat` on it to confirm it is indeed a copy.

To delete files, use the `rm` command:

```sh
$ rm files.txt
```

Note that the command line has tab completion. This means that you can type the first few characters of something and it will try to autocomplete it. If you type `rm f` and then press `Tab`, it should complete `files.txt` for you. If there are multiple files or directories starting with 'f', you may need to type up until there's only one possible option for it to autocomplete.

To go back a directory, enter:

```sh
$ cd ..
```

`..` in a command refers to the directory one level above your current directory, in this case `~`. If you were in a directory `~/files/more_files`, `..` would then refer to `files`.

Try deleting the `files` directory with `rm`. You should see this:

```
rm: cannot remove 'files': Is a directory
```

By default, `rm` does not delete directories. You need to pass it the `-r` flag to do so, which stands for 'recursive':

```sh
rm -r files
```

Enter `ls` and you should see your `files` directory has been deleted.

#### Trashing Files

Unlike deleting files in Windows or macOS, `rm` does not move the file to trash; it is permanently deleted. If this scares you, feel free to install the `trash` command:

```sh
$ sudo apt-get -y install trash-cli
```

After installation, you should now have access to the `trash` command. Create a file using `touch`, and then trash it with the `trash command`:

```sh
$ touch file.txt && trash file.txt
```

Using `&&` allows us to enter multiple commands at once, so `touch` will run first, followed by `trash` after `touch` completes.

Trashed files go to a certain directory in your home directory, you can display the contents of it with the `ls` command:

```sh
$ ls ~/.local/share/Trash/files
```

The `trash` package also comes with several other useful commands to empty, view, or restore trashed files. To list trashed files, use `trash-list`. To restore trashed files, use `trash-restore`. And to empty the trash, use `trash-empty`.

### Searching Files

We can search for files using the `find` command:

```sh
$ find ~/.bash*
```

This means 'find all files in our home directory starting with '.bash' and ending with anything (`*` means match anything). It should return:

```
.bash_history
.bash_logout
.bashrc
```

To search text patterns in files, use the `grep` command. `grep` can do very complex things, so check out the manual page with `man grep` if you want to learn more. To search all the files in our home directory for the string 'bash', enter the command:

```sh
$ grep -r bash
```

The output should show you each line containing 'bash' in each file in your home directory. The `-r` flag we passed means 'recursive', so it searches each file in the directory. You can also specify the file you want to search — for example `grep bash .bashrc` to only search the file `.bashrc`.

## Filepaths

In general, there are two types of filepaths: _relative_ and _absolute_.

Relative filepaths are given relative to wherever the filepath is being given. For example, if you are in your home directory (`~`), and there is a folder named `files` with a file `file.txt` inside it, you could refer to this file with the filepath `files/file.txt`. However, if you were inside the directory `~/files`, using `files/file.txt` would no longer work because relative to where we are now, the `files` directory doesn't exist. The correct way to refer to `file.txt` would now just simply be `file.txt`.

Absolute filepaths work regardless of what directory you're in. They typically specify something relative to the root directory, `/`, or your home directory, `~`. The root directory is the top-level directory of your Linux operating system, you can display the contents by entering `ls /`.

In our previous example, we used the relative filepath `files/file.txt` to refer to `file.txt` while we were in our home directory. If we were somewhere else on our system but still wanted to access `file.txt`, we could use the absolute filepath `~/files/file.txt`. This means 'start at my home directory, then go into the files folder and give me file.txt'. We could also specify this absolute filepath relative to the root directory: `/home/$USER/files/file.txt`.

`$USER` is a special environment variable that holds whatever you set as your Linux username. There are many environment variables used across Linux, and all of them are referred to by using the ${NAME} syntax.

A couple more things to note is that `..` refers to the directory one level above your current working directory, and `.` refers to the directory you are currently in. `.` is useful when you're copying files from somewhere else to your current directory, for example:

```sh
$ cp ~/some/remote/directory/file.txt .
```

## Wildcards

The `*` symbol in commands is known as a wildcard. It basically means 'anything'. If we navigate to our root directory using `cd /` and then enter `ls *`, you'll note that it shows the directory contents of every directory within the root directory. We can also use the wildcard within text patterns; the command `ls l*` means 'ls every directory starting with an l; anything can come after the l'.

One particularly dangerous way of using wildcards is deleting files with `rm`. If you enter the command `rm *`, it will attempt to delete everything (except for directories, unless you add the `-r` flag). Wildcards are a very powerful tool for working with multiple files, but use them with caution.

## tldr

| Command | Description                                         | Example                      |
|---------|-----------------------------------------------------|------------------------------|
| `ls`    | List files. Use `ls -a` to list hidden files        | `ls ~`, `ls -a`              |
| `cat`   | Display the contents of a file to your terminal     | `cat file.txt`               |
| `less`  | Display the contents of a file in a separate view   | `less file.txt`              |
| `touch` | Creates a file if it does not exist                 | `touch file.txt`             |
| `mkdir` | Creates a directory                                 | `mkdir files`                |
| `mv`    | Moves a file or directory                           | `mv file.txt files`          |
| `cp`    | Copies an input file/directory to a destination     | `cp file.txt files_cp.txt`   |
| `rm`    | Removes a file. Use `rm -r` to remove a directory   | `rm file.txt`, `rm -r files` |
| `find`  | Finds files matching a text pattern                 | `find ~/.bash*`              |
| `grep`  | Search for a text pattern within files              | `grep -r bash`               |

* `~` means home directory, `.` means current directory, `..` means the directory one level above the current directory.

* Relative filepath: a filepath relative to your current working directory. For example: `.bashrc`.
* Absolute filepath: a filepath starting from the root or home directory. For example: `~/.bashrc` or `/home/$USER/.bashrc`.

* Use `man {command}` if you need help with a command.

* Use `Ctrl+c`, `Ctrl+d`, or `q` to quit a command.

* Use the up/down arrow keys to navigate previously entered commands.

## Conclusion

You now have the basic tools needed to navigate and manage files. Continue to [Lesson 1.2: Remote Repositories with Git](lesson_1_2.md) to learn how to create git repositories to manage files remotely and collaborate with others.

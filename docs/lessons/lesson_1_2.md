---
layout: page
title: "1.2 Remote Repositories with Git"
parent: Lessons
---
# Lesson 1.2: Remote Repositories with Git
{: .no_toc }

#### Table of contents
{: .no_toc }
- TOC
{:toc}

Imagine you're working on a software project with other people. How would you go about sharing all the files? You could simply host all the code on Google Drive or another file sharing service, but what happens when people want to work on the same file at the same time? What happens when someone messes up and you need to undo changes? It turns out someone thought of these problems a long time ago, and the solution is called _version control_ (aka _source control_). The first version control system was created in 1972 (it probably sucked).

In short, a version control system manages changes to a set of files. They store a history of the changes so you can revert to any point of time. There are many different version control systems out there, each with their own advantages and disadvantages, but the most popular system is called _git_. Git was developed in 2005 by Linus Torvalds, the creator of Linux. It is a very powerful tool, but you can get by only knowing a few simple commands.

## Signing up for Github

[Github](https://github.com), owned by Microsoft since 2018, is the world's largest hosting provider for software development projects. Github allows us to host our software projects for free, and they can be viewed by anyone (there can also be private projects), or modified by people who are granted permission. If you don't already have an account, [sign up](https://github.com/signup) for free.

### Adding SSH keys to your Github account

We will modify projects on Github by using the command line from our Ubuntu system we set up in [Getting Started](../getting_started). To do this, we need to add an SSH key to our account, which Github uses for authentication. Simply put, an SSH key is a pair comprised of a public and private key (sequence of characters) that can be used for encryption. Anyone can encrypt something with your public key, but you can only decrypt the message if you have the private key. We will generate a new SSH key, and add the key to our Github account.

#### Generating a new SSH key

To generate a new SSH key, we can use the `ssh-keygen` command:

```sh
$ ssh-keygen -t ed25519 -C "your_email@something.com"
```

`ed25519` is the algorithm being used to generate the key, and the email is just used as a label to identify the key. The command will prompt you to enter where to save it, just hit `Enter` to accept the default location. It will then ask for a passphrase, choose anything, but don't forget it.

#### Adding the SSH key to ssh-agent

To actually use our key when we interact with Github, we need to add it to our ssh-agent. ssh-agent is just a program that can store our key so we don't have to enter our passphrase each time. Run the following command to start the ssh-agent:

```sh
$ eval "$(ssh-agent -s)"
```

It should return an agent pid if successful. Now enter this to add the key:

```sh
$ ssh-add ~/.ssh/id_ed25519
```

If you created your key with a different filename, use that instead. The command should output `Identity added: ...`.

#### Adding your SSH key to Github

Next, we need to add our key to our Github account. First, output your key and copy the contents to your clipboard:

```sh
$ cat ~/.ssh/id_ed25519
```

If you are using WSL, you can use this command to copy directly to your clipboard:

```sh
$ cat ~/.ssh/id_ed25519 | clip.exe
```

`|` is called the _pipe_ command, it lets you redirect the output of one command into the input of another. Here we give the command `clip.exe`, which copies whatever you give to it to your clipboard, the output of `cat`, which just displays the file contents to your terminal.

Now, navigate to the [SSH and GPG keys](https://github.com/settings/keys) settings page on Github, click `New SSH key`, give it a title, paste in your key, and click `Add SSH key`. If it worked, you should now be able to modify any of your repositories hosted on Github from your Ubuntu system.


## Creating our first Repository

Navigate to the [Create a new repository](https://github.com/new) page on Github by clicking the `+` in the top-right corner. Give it the title 'python-club', and make sure to tick the `Add a README file` checkbox. Click `Create Repository` and it will redirect you to your newly created repository. There should be one file in it now, `README.md`, which holds a description of the repository in markdown, a mini-language used for formatting text.

## The Git Command Line

The `git` commands ships with most distributions of Linux by default, so you should already have it. Enter `git` into your command line to make sure something pops up. If it says 'command not found', you can install it with:

```sh
$ sudo apt-get install git
```

### Cloning a Repository

To clone a remote repository (ie a repo hosted on Github), use the `git clone` command. The command takes the remote url to the repo as well as the directory to clone it to. If no directory is provided, it clones it to the current directory using the title of the repo. From your `python-code` repo on Github, click the green `Code` button, then the `SSH` tab in the popup window. Copy the url to your clipboard, paste it after the following command, and press `Enter`:

```sh
$ git clone
```

You should get output similar to:

```
Cloning into 'python-club'...
remote: Enumerating objects: 3, done.
remote: Counting objects: 100% (3/3), done.
remote: Total 3 (delta 0), reused 0 (delta 0), pack-reused 0
Receiving objects: 100% (3/3), done.
```

If you `ls` now, you'll notice there is a `python-club` directory, `cd` into it now. If you run `ls -a`, you'll notice a `.git` directory. This is what defines a directory as a git repository, and it stores all the history and metadata for your repo. You won't have to directly interact with this directory, but just know it's there, and if you deleted it, git would not work.

### Making changes to a Repository

Any files you create within your repo's directory aren't going to magically appear in Github, you need to first _stage_ the changes, which simply means telling git about the changes, then you need to _commit_ the changes, which snapshots the state of the repo. Finally, you need to _push_ the changes, which uploads your commit to Github for the rest of the world to see.


#### Staging Changes

Changed files are staged in git by using the `add` command. Let's create a new text file and stage it:

```sh
$ echo "test" > test.txt
```

The `>` symbol redirects output to a file, `test.txt` in this case, and the `echo` command simply prints whatever you give it to the terminal. This command is a simple way to create a new file with some contents. To stage the file, enter the command:

```sh
$ git add test.txt
```

This command doesn't output anything itself, but if you now enter:

```sh
$ git status
```

you should see that you have a new file change to be committed.

A useful shortcut with `git add` is `git add .`. This means to stage all file changes in your repo.

#### Committing Changes

To commit the staged changes, use the `git commit` command. If you only enter `git commit`, it will open a text editor and ask you to enter a commit messsage. We can pass the `-m` flag to `git commit` to provide the message to the command line:

```sh
$ git commit -m "Added test.txt"
```

Commit messages should be somewhat descriptive, so you know what was changed in that commit in case you need to undo it. Now that our changes are committed, we can do whatever we want in our repo and it will not be included in our push to Github. For more changes to be included, we need to use `git add` and `git commit` again.

A commit acts as a sort of checkpoint for the repo; it is possible to restore the repo to any commit in case anything bad happens. As a general rule of thumb, you should not include too many changes in a commit at the same time because it becomes more likely to break something. For example, if something breaks in a large commit containing a dozen different changes, all of those changes have to be rolled back instead of just the offending change. Small changes also make it easier to figure out what actually broke something.

##### Resetting a Commit

If you use `git commit`, but find you forgot about a file you wanted to include in it, you can undo it by using this command:

```sh
$ git reset HEAD~
```

This command will wipe out the commit you just created, but keep your local changes. You will have to stage all the changes again using `git add`.

There are various other ways to use `git reset`, including throwing away all changes and jumping back in time to an earlier commit. See [git reset documentation](https://git-scm.com/docs/git-reset) for more details.

#### Pushing Changes

After you create your commit with the `test.txt` file, we can push it to our remote repository by using the `git push` command. The command takes the remote repositories URL, as well as the branch to push to. When we create a repo using Github, our branch will be named 'main' by default. For the url, we can use the shorthand 'origin' to refer to the url we originally cloned our repo from. Putting that together, we can push our change to Github using the command:

```sh
$ git push origin main
```

You should see output similar to:

```
Enumerating objects: 4, done
Counting objects: 100% (4/4), done.
Delta compression using up to 16 threads
Compression objects: 100% (2/2), done.
Writing objects: 100% (3/3), 275 bytes | 275.00 KiB/s, done.
Total 3 (delta 0), reused 0 (delta 0)
```

Refresh your repo on Github, and you should see your `test.txt` file there. Click on it to see that it contains the content we wrote to it. You can share your webpage url with anyone in the world, and they will be able to see the contents of your `test.txt` file.

Now, let's delete the `test.txt` file so we can demonstrate refreshing the repo from our command line. Click the trash icon located on the right-hand side of the screen, then the green `Commit changes` button to confirm.

#### Pulling Changes

Since we pushed a commit from Github itself, our copy of the repo on our Ubuntu system is 1 commit behind `HEAD`. In version control systems, `HEAD` refers to the most recent version of the repo. To catch up to `HEAD`, we can use the `git pull` command while inside of our repo directory:

```
$ git pull
```

You should see output similar to:

```
Updating 302dec5...958ea33
Fast-forward
  test.txt | 1 -
  1 file changed, 1 deletion(-)
  delete mode 100644 test.txt
```

If you run `ls` now, you should see that the `test.txt` file is gone, and `git status` will tell you that your branch is up to date.

When working with multiple people on the same repo, `git pull` is where you can run into a lot of issues, especially if you were working on the same files. These are called merge conflicts, and you must resolve them by telling git what you want to keep from your local state of the repo as well as the state being pulled in. I will not go over how to resolve these issues here, so if you run into any, google whatever shows up on your screen.

### A note on Branches

Earlier, we noted that the default branch that Github creates when we made our repo was 'main'. In git, we can create multiple branches, switch between them, push changes to certain branches, or merge branches together. Think of a branch as another version of the repo. When working with multiple people on a project, someone might be developing on one branch specifically related to whatever feature they are working on. Once that feature is thoroughly tested and ready to be released, that branch would be merged with the `main` branch. In general, the `main` branch should be a pristine, working copy of the project.

## tldr

| Command                    | Description                               | Example                                          |
|----------------------------|-------------------------------------------|--------------------------------------------------|
| `git clone {url}`          | Clones a remote repo                      | `git clone git@github.com:{Username}/{repo}.git` |
| `git add {file}`           | Stages a single file to be committed      | `git add file.txt`                               |
| `git add .`                | Stages all modified files to be committed | `git add .`                                      |
| `git commit -m "message"`  | Creates a new commit with a description   | `git commit -m "Added file.txt"`                 |
| `git status`               | Displays the status of the repo           | `git status`                                     |
| `git push origin {branch}` | Pushes commits to the repo at the branch  | `git push origin main`                           |
| `git pull`                 | Pulls any commits from the remote repo    | `git pull`                                       |
| `git reset HEAD~`          | Resets any unpushed commits               | `git reset HEAD~`                                |

* Git is a version control system, which manages making changes to a set of files, also known as a repository or repo.

* Github is a free hosting service for git repositories.

* A commit in git is a snapshot of the repo.

* Commits should be small and have descriptive messages so they are easy to track.

* A branch in git is an isolated offshoot of the main branch, like a tree branch from the main trunk.

* Features should be isolated into branches until they are ready to be merged back into the main branch.

* `HEAD` means the most recent commit of a branch.

## Conclusion

You should now be able to create and modify repos using Github and `git`. I left out a lot of details, so feel free to search for documentation online if you run into any problems or want to learn more.

From now on, I encourage you to store any files you work on throughout lessons in a repository on Github, as it will enable me to see them and help if needed, and it is a great way to copy projects between computers.

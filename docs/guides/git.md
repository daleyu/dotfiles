## Github Setup 

### Personal Github
If you are using work-laptop for like a personal reason, then there are some steps that you want to do to ensure you have access to your personal repos and also so that you are correctly signing your commits.
- Generate a new SSH key. And You want to add it into your .ssh config files as so. 
```bash
Host daleyu1-github
        HostName github.com
            User git
                IdentityFile ~/.ssh/daleyu1_rsa
```
Personally, I found that the like .gitconfig redirection if it is in the personal directory doesn't actually work. 
- Note: You should be cloning from ssh, with the ssh hostname that you defined in the .ssh/config. Looks like this
`git clone git@daleyu1-github:daleyu/dotfiles.git`
So, what I do is I just set my email for a single repository, as I likely won't be having many personal repos on here other than for like dotfiles, etc. 
```
// Set the email from this local repository
git config user.email "YOUR_EMAIL"
// git config user.email "yudale2003@gmail.com" 
```
Reference: https://stackoverflow.com/questions/3860112/multiple-github-accounts-on-the-same-computer
### Personal Github
If you are using work-laptop for like a personal reason, then there are some steps that you want to do to ensure you have access to your personal repos and also so that you are correctly signing your commits.
- Generate a new SSH key. And You want to add it into your .ssh config files as so.
```
    Host daleyu1-github
            HostName github.com
                User git
                    IdentityFile ~/.ssh/daleyu1_rsa
```
Note: the hostname will now replace the github.com ending and now be what is used to  tell git where to look. See Debugging tips for teails
    Personally, I found that the like .gitconfig redirection if it is in the personal directory doesn't actually work.
    - Note: You should be cloning from ssh, with the ssh hostname that you defined in the .ssh/config. Looks like this
    `git clone git@daleyu1-github:daleyu/dotfiles.git`
#### Signing git commits

So, what I do is I just set my email for a single repository, as I likely won't be having many personal repos on here other than for like dotfiles, etc.
```
// Set the email from this local repository
git config user.email "YOUR_EMAIL"
// git config user.email "yudale2003@gmail.com"
```

Reference: https://stackoverflow.com/questions/3860112/multiple-github-accounts-on-the-same-computer
#### Debugging Git Tips
- Make sure that you are cloning repositories like the following format
```
 git clone git@daleyu1-github:daleyu/<repo-name>.git
 // hostname after the @
 git clone git@<hostname>:<username>/<repo-name>.git
```
You can check if you are authenticated though
```
 ssh -T git@daleyu1-github
 ssh -T git@<host-name>
```
If you are finding that the commits are signed the wrong way then you have to
look into your git config.

*Fixing delta and Bat*
- You have to make sure that both bat, delta, and git are all stowed. Check to
make sure that git has access to the global git config. 

Bat sometimes isn't able to find the themes, so it might be best to run `bat
cache --build`. This will allow it to find the theme. 

### Git Guides

##### Ignoring a file only locally
- If you want a file on your local computer like an editorconfig or something,
but don't want it to be upstream then you can add it to your local git info
exclude, like this.
```bash
echo mise.toml >> .git/info/exclude
```
I use this for mise so it doesn't get pushed upstream

##### Rebasing Workflow using Neogit and Neovim
Rebase on pull should be the default for many reasons. 

Neogit has some options, but usually I start from the command line and the
rebase through diffview and neogit. 
- Push r as the rebase option and then continue or abort :)

##### Code Review Practices
Often times you will get comments on an MR and you will want to be able to add
in a quick typo fix without changing the commit hash. 
`git commit --amend`
- Just make the changes and then commit ammend them to keep the hash and not
need to squash again

##### Undoing any Git Reset Command

It is very often that you might do something like 

##### Squashing to One Commit
Often times it is best practice to squash to one commit before submitting for
review/etc. You can squash to one commit through doing something like the
following commands
```bash
git reset --soft origin/master
git add .
git commit -m "feat: [feature name]"
```
- This is how I squash to one commit before submitting for code reviews. 

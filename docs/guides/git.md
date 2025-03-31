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
If you are using work-laptop for like a personal reason, then there are some steps that you want to do to ensure you have access to your personal repos and also so that you are correctly signing your commits.               │E37: No write since last change                   │
- Generate a new SSH key. And You want to add it into your .ssh config files as so.                                                                                                                                            ╰──────────────────────────────────────────────────╯
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
    // Set the email from this local repository
    git config user.email "YOUR_EMAIL"
    // git config user.email "yudale2003@gmail.com"
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

### Git Guides
##### Squashing to One Commit
Often times it is best practice to squash to one commit before submitting for
review/etc. You can squash to one commit through doing something like the
following commands
```bash
git reset --soft origin/master
~                             │┃  55 3
git add .
~                             │┃  57 1
git commit -m "feat: [feature name]"
```
- This is

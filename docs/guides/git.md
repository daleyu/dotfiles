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

# Git Internal Notes
For a long time I have been curious about git internals and the way that it
works and all the different commands. I plan to use this document to keep a note
of all the findings I have. I will work through this when I get more time.

Some notes I want to look into the specifics of are: 
- rebase internals
- detached head internals
- reset and soft reset internals

## Rebasing
You should always be rebasing and never doing merge commits because it will make
it much easier to reverse changes and also rollback errors. This is also why you
should squash commits so it is easier to rollback.

### Understanding incomming vs current branch
When I first starting working with rebase, I found myself confused at times with
what the different branches mean when I am rebasing and there are conflicts with
an incoming change. 

TLDR: When you are rebasing a branch onto master, like when you do `git rebase
origin/master`, then that means that you have the incoming as your current
branch, and then the current branch is actually the master branch. [very weird
wording...]

The way that it is like this is because how rebase actually works. What rebase
does is it will take your current branch and reset it to master. Kind of like
git reset --soft. Then, from there it will take all your commits and try to
replay that branch onto the status your current branch is on. This means what it
is doing is basically going to the status of master and then trying to play all
your changes one commit at a time.
- This means that current is now master/the new state, and then the incoming is
  the comimtts that you are replaying

After you replay all the commits then it should actually show that you are at
current because you basically advanced to that point.

## Detached Head
Reference: https://git-scm.com/docs/git-checkout#_detached_head
Most of the time when you see detached head it is the result of a rebase or
getting individually checked out to a certain commit in history. This is because
the detached head state is when you aren't technically on a branch. 
- You have to then attach a branch, because Git works in a tree structure. if
you just create a new node then there is no way to attach that 


Random links: i'll look at later
https://stackoverflow.com/questions/2530060/in-plain-english-what-does-git-reset-do
https://stackoverflow.com/questions/5473/how-can-i-undo-git-reset-hard-head1
https://stackoverflow.com/questions/2510276/how-do-i-undo-git-reset




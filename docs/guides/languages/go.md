# Tips and Docs for Go

## Dealing with Go packages and installs
Look at the replace field of the `go.mod` to get a gist of what might need to be
manually replaced. This could get in the way if you are go getting a package
version.
- go get hostname/repo/file@branch-name

*Invalid version: unknown revision*
- This situation is usually caused by the disappearance of the commit, such as when push -f is executed in the repository. 
Generally, upgrading the version is sufficient. If it cannot be upgraded, it may be due to an indirect dependency that has fixed the version number. 
- Sometimes it could actually be that Go's dependency management it's is broken.
If it is the case that the go dependency management is broken, then you need to delete or replace all dependencies on the repository in the project before go get.
- this can be done with a replace like 
`replace packace => package v1.x.x`
Once it is replaced then you can deleted that portion

#### USING MULTIPLE VERSIONS OF GO (IMPORTANT)

##### Mise
It seems like Mise is a tool that can handle and fix this workflow very easily.
You can just run `mise use go@x.x` for the version. You can specify this in the
parent directory and then you won't have to git ignore it.


##### Gvm

No point in using goenv or gvm, as they are not the supported technique from the
official go documentation. 
- Instead you should download multiple go versions like https://go.dev/doc/manage-install#installing-multiple,
Then you can set the go version in that terminal session using an alias and also
set the goroot that neovim will use. You also have to export the path in this
session. Then, neovim should be able to recognize the go alias and version. 

`$ source gvm <go-version>`
- Use this script to be able to change go version

- if this doesn't work or there are unexpected errors, then it is likely that
the gopls is too updated, you should look at the go docs and get the latest
gopls that works with that version

#### Random Go Packages

Some useful go packages, I've used. 
```
go install github.com/loov/goda@latest
```
- Goda lets you debug gomod and the different dependencies. You will need
graphviz to do some of the commands. 
    - it is kind of buggy but wtv

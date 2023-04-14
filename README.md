# GARAIO Template Repository
Act as reference for the initialization of new GARAIO source repositories.

# Usage
The script might be executed within;

## Context
- A freshly newly created directory on your local machine that will then be pushed to a git origin to start a repository.
- A already existing empty repository (or almost empty) that has been cloned locally.

## Procedure

Within the directory you want to setup (either empty or cloned working copy).

Run the [Init-Repository.ps1](/src/init-script/Init-Repository.ps1) within a PowerShell Command Prompt.

```powershell
 Invoke-Expression (Invoke-WebRequest -Uri https://raw.githubusercontent.com/garaio/garaiotemplaterepo/main/src/init-script/Init-Repository.ps1)
```

# What it will do

The scripts do the following steps

1. Check if the current repository already has `.git`-directory. If none is found `git init` is invoked
1. Create the structure according to the GARAIO-Blueprint; within each directory a `delete-me.txt` file is created.
1. Place at root of the repository
   - The [VisualStudio.gitignore](https://raw.githubusercontent.com/github/gitignore/main/VisualStudio.gitignore) file
   - A `README.md` file
1. Within the `src/web/` directory the [Node.gitignore](https://raw.githubusercontent.com/github/gitignore/main/Node.gitignore) file
1. Adds to the git index the above files and directories and initate the first commit
1. Create the `develop/` git branch

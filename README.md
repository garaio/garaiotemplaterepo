# GARAIO Template Repository
Act as reference for the initialization of new GARAIO source repositories.

# Usage
- Import the present repository into your new Azure DevOps project and clean-it-up by removing
  - all `.gitkeep` files
  - `src/init-script/` directory
- Use the [Init-Repository.ps1](/src/init-script/Init-Repository.ps1) by the following command in an empty directory.
  ```powershell
   Invoke-Expression (Invoke-WebRequest -Uri https://raw.githubusercontent.com/garaio/garaiotemplaterepo/main/src/init-script/Init-Repository.ps1)
  ```
- Once Azure DevOps supports template repositories as GitHub does - use this as a template

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

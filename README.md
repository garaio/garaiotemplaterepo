# GARAIO Template Repository
Act as reference for the initialization of new GARAIO source repositories.

# Usage
The script might be executed within;

- A freshly newly created directory on your local machine that will then be pushed to a git origin to start a repository.
- A already existing empty repository (or almost empty) that has been cloned locally.

## Requirements

Ensure you've the git's `user.name` and `user.email` set either localy or globaly prior running the script.

## Procedure

Within the directory you want to setup (either empty or cloned working copy).

Run the [Init-Repository.ps1](/src/init-script/Init-Repository.ps1) within a PowerShell Command Prompt.

### Basic Usage

```powershell
 Invoke-Expression (Invoke-WebRequest -Uri https://raw.githubusercontent.com/garaio/garaiotemplaterepo/main/src/init-script/Init-Repository.ps1)
```

### Using Feature Branch (for protected repositories)

If your repository has branch protection enabled on `main`/`master`, use the `-UseFeatureBranch` parameter to create changes in a feature branch:

```powershell
$scriptContent = Invoke-WebRequest -Uri https://raw.githubusercontent.com/garaio/garaiotemplaterepo/main/src/init-script/Init-Repository.ps1
Invoke-Expression "& { $($scriptContent.Content) } -UseFeatureBranch"
```

This creates a `feature/automated-repo-initialization` branch that can be merged via pull request.

# What it will do

The scripts do the following steps

1. Detect the default branch name (`main` or `master`) if in an existing repository
1. Check if the current repository already has `.git`-directory. If none is found `git init` is invoked
1. Create the structure according to the GARAIO-Blueprint; within each directory a `.gitkeep` file is created that can be later-on deleted once the directory receives its final content.
1. Place at root of the repository
   - The [VisualStudio.gitignore](https://raw.githubusercontent.com/github/gitignore/main/VisualStudio.gitignore) file
   - A `README.md` file
1. Within the `src/web/` directory the [Node.gitignore](https://raw.githubusercontent.com/github/gitignore/main/Node.gitignore) file
1. Adds to the git index the above files and directories and initate the first commit
1. Create branches:
   - **Default mode**: Creates the `develop` branch from the default branch
   - **Feature branch mode** (`-UseFeatureBranch`): Creates `feature/automated-repo-initialization` branch for pull request workflow

# Pushing the changes

The method to push your changes will depend whether your directory was cloned repository already linked to an existing git remote, or if you have started from an newly locally-created empty directory.

You can check if your local working copy is linked with a git remote by using

```bash
git remote -v
```
Given the repository would be already linked to a remote something like should appear;
```bash
user@host garaiotemplaterepo % git remote -v
origin  https://github.com/garaio/garaiotemplaterepo.git (fetch)
origin  https://github.com/garaio/garaiotemplaterepo.git (push)
```

#### Using an existing git remote

```bash
# Pushes all locally created branches and commits to the already defined remote
git push --all
```

#### To connect a working copy to an existing remote

_This will work easily only if the remote doesn't already have commits._

```bash
git remote add origin {url-to-origin}
```
like
```bash
git remote add origin https://github.com/garaio/garaiotemplaterepo.git
```

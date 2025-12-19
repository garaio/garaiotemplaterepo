param (
    [Switch]$UseFeatureBranch,  # Create changes in a feature branch instead of main/develop
    [Switch]$CreateDevelopBranch  # Create a develop branch (legacy workflow)
)

function New-File {
    param (
        [string]$path,
        [string]$fileName,
        [string]$content = "Remove this file once you have added your content.",
        [Switch]$Force  # Force the creation of the file if it already exists
    )
    Write-Host "Path: $path"
    Write-Host "File name: $fileName"
    $completePath = Join-Path $path $fileName
    Write-Host "Complete path: $completePath"
    if ((Test-Path $completePath -PathType Leaf) -and ($Force -eq $false)) {
        Write-Host "File $completePath already exists"
    }else{
        New-Item -ItemType File -Path $completePath -Value $content -Force:$Force
    }
}

function Get-DefaultBranch {
    $branches = git branch -a 2>$null
    if ($branches -match '\bmain\b') {
        return "main"
    }
    elseif ($branches -match '\bmaster\b') {
        return "master"
    }
    else {
        return "main"
    }
}

# Check if it is a git repository
$isExistingRepo = $false
if (Test-Path './.git') {
    Write-Host "Git repository found"
    $isExistingRepo = $true
}
else {
    Write-Host "Git repository not found"
    Write-Host "Creating a new git repository"
    git init
    Write-Host "Use git remote add orgin <url> to add a remote repository"
}

$defaultBranch = Get-DefaultBranch
Write-Host "Default branch detected: $defaultBranch"

$placeHolderFileName = '.gitkeep'

# Download the README.md file
Invoke-WebRequest https://raw.githubusercontent.com/garaio/garaiotemplaterepo/main/README.sample.devops.md -OutFile ./README.md

# Initialize the root directories
mkdir -p ./src
New-File './src/' $placeHolderFileName
mkdir -p ./src/api
New-File './src/api/' $placeHolderFileName

Invoke-WebRequest https://raw.githubusercontent.com/garaio/garaiotemplaterepo/main/src/api/.editorconfig -OutFile ./src/api/.editorconfig

mkdir -p ./src/web
New-File './src/web/' $placeHolderFileName
Invoke-WebRequest https://raw.githubusercontent.com/github/gitignore/main/Node.gitignore -OutFile ./src/web/.gitignore
mkdir -p ./src/integration-tests
New-File './src/integration-tests/' $placeHolderFileName

mkdir -p ./deploy
New-File './deploy/' $placeHolderFileName
mkdir -p ./deploy/azure-pipelines
New-File './deploy/azure-pipelines/' $placeHolderFileName
mkdir -p ./deploy/iac
New-File './deploy/iac/' $placeHolderFileName

mkdir -p ./docs
New-File './docs/' $placeHolderFileName

Invoke-WebRequest https://raw.githubusercontent.com/github/gitignore/main/VisualStudio.gitignore -OutFile ./.gitignore

# Extend the .gitignore file with the content of extensions.gitignore
Invoke-WebRequest https://raw.githubusercontent.com/garaio/garaiotemplaterepo/main/extensions.gitignore -OutFile ./extensions.gitignore
Get-Content ./extensions.gitignore | Add-Content ./.gitignore
Remove-Item ./extensions.gitignore

# git commit
git add .
git commit -m "Init script - commit initial files and directories"

# create dev container
mkdir -p .devcontainer
Invoke-WebRequest https://raw.githubusercontent.com/garaio/garaiotemplaterepo/main/.devcontainer/devcontainer.json -OutFile ./.devcontainer/devcontainer.json

git add ./.devcontainer/devcontainer.json
git commit -m "Init script - add dev container"

# create branches based on mode
if ($UseFeatureBranch -and $isExistingRepo) {
    Write-Host "Creating feature branch for repository initialization"
    git checkout -b feature/automated-repo-initialization
    Write-Host "Changes applied to feature/automated-repo-initialization branch"
    Write-Host "Create a pull request to merge these changes into $defaultBranch"
}
elseif ($CreateDevelopBranch) {
    Write-Host "Creating develop branch from $defaultBranch (legacy workflow)"
    git checkout -b develop
    git checkout $defaultBranch
}
else {
    Write-Host "Repository initialized with $defaultBranch branch only"
    Write-Host "Use tag-based release management with feature/fix branches"
}

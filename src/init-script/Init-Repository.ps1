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

# Check if it is a git repository
if (Test-Path './.git') {
    Write-Host "Git repository found"
}
else {
    <# Action when all if and elseif conditions are false #>
    Write-Host "Git repository not found"
    Write-Host "Creating a new git repository"
    git init
    Write-Host "Use git remote add orgin <url> to add a remote repository"
}

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

# create default branches
git checkout -b develop
git checkout main

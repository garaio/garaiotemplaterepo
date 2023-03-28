# garaiotemplaterepo
Act as reference to initialize repository for new GARAIO Project

See https://dev.azure.com/garaio/Architecture%20Circle/_wiki/wikis/GARAIO%20Blueprints/573/Source-Code-Governance

# Usage
- Use the Init-Repository.ps1 script
- Copy the content of the above script in a powershell command prompt
- Run the following command in your local repository
  ```powershell
   Invoke-Expression (Invoke-WebRequest -Uri https://raw.githubusercontent.com/garaio/garaiotemplaterepo/main/src/init-script/Init-Repository.ps1)
  ```
- Once Azure DevOps supports template repositories as GitHub does - use this as a template
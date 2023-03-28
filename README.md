# garaiotemplaterepo
Act as reference to initialize repository for new GARAIO Project

See https://dev.azure.com/garaio/Architecture%20Circle/_wiki/wikis/GARAIO%20Blueprints/573/Source-Code-Governance

# Usage
- Import the present repository into your new Azure DevOps project and clean-it-up by removing
  - `delete-me.txt` files
  - `src/init-script/` directory
- Use the [Init-Repository.ps1](/src/init-script/Init-Repository.ps1)
- Copy the content of the above script in a powershell command prompt
- Run the following command in your local repository
  ```powershell
   Invoke-Expression (Invoke-WebRequest -Uri https://raw.githubusercontent.com/garaio/garaiotemplaterepo/main/src/init-script/Init-Repository.ps1)
  ```
- Once Azure DevOps supports template repositories as GitHub does - use this as a template

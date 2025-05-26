# Windows Applications Installer

This PowerShell script provides a simple CLI menu to help you quickly download popular Windows applications.

## Requirements

- Windows 10/11
- PowerShell 5.1 or later
- Internet connection

## How to Use

### 1. Run Directly from the Command Line (No Download Needed)

You can run the script directly from GitHub without downloading it first.  
Open **PowerShell as Administrator** and execute:

```powershell
irm https://raw.githubusercontent.com/xirothedev/windows-applications-installer/main/install.ps1 | iex
```

- `irm` is short for `Invoke-RestMethod`, which fetches the script from the URL.
- `iex` is short for `Invoke-Expression`, which executes the fetched script.

### 2. (Optional) If You Want to Download and Run Locally

1. Download `install.ps1` to your computer.
2. Open PowerShell as Administrator.
3. Navigate to the folder containing the script:
   ```powershell
   cd "Path\To\Script\Folder"
   ```
4. (If needed) Allow script execution:
   ```powershell
   Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
   ```
5. Run the script:
   ```powershell
   .\install.ps1
   ```

## Usage Instructions

- The script will display a menu of available applications.
- Enter the numbers of the applications you want to download (comma-separated, e.g., `1,3,5`).
- Enter `A` to download all applications.
- Enter `Q` to quit.
- Confirm your selection by typing `Y` when prompted.
- After downloading, you can choose to open the folder containing the downloaded files.

## Notes

- All downloaded installers will be saved in your `Downloads` folder.
- Make sure you have a stable internet connection during the process.
- If you encounter an execution policy warning, use:
  ```powershell
  Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
  ```
- If you experience download errors, check your internet connection or try running the script again.

## Support

For suggestions, adding more applications, or reporting issues, please contact the script author.

---

**Quick Start:**  
Just copy and paste the following command into your PowerShell (run as Administrator):

```powershell
irm https://raw.githubusercontent.com/xirothedev/windows-applications-installer/main/install.ps1 | iex
```
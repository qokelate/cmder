#NoTrayIcon

Local $cmd = StringFormat('"%s\\Notepad2.exe" "%%1" %%*', @ScriptDir)
RegWrite('HKCR\*\shell\notepad2\command', '', 'REG_SZ', $cmd)

Exit


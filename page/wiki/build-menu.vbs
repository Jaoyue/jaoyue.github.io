' build-menu.vbs - double-click to rebuild wiki menu.json / menu.js
' Works on any Windows with WScript (default for .vbs double-click).

Option Explicit

Dim shell, fso, scriptDir, py, candidates, i
Dim probe, exec, cmd, exitCode, stdout, stderr

Set shell = CreateObject("WScript.Shell")
Set fso  = CreateObject("Scripting.FileSystemObject")
scriptDir = fso.GetParentFolderName(WScript.ScriptFullName)

' Python candidates checked in order:
'   1) "python" on PATH  2) managed 3.13.12  3) system 3.10.11
candidates = Array( _
  "python", _
  "C:\Users\zhaoyue.zy\.workbuddy\binaries\python\versions\3.13.12\python.exe", _
  "E:\tool\Python\python3.10.11\python.exe" _
)

py = ""
For i = 0 To UBound(candidates)
  If LCase(candidates(i)) = "python" Then
    On Error Resume Next
    shell.CurrentDirectory = scriptDir
    Set probe = shell.Exec("python -c ""print(1)""")
    If Err.Number = 0 Then
      Do While probe.Status = 0 : WScript.Sleep 30 : Loop
      If probe.ExitCode = 0 Then py = "python"
    End If
    On Error Goto 0
  Else
    If fso.FileExists(candidates(i)) Then py = candidates(i)
  End If
  If py <> "" Then Exit For
Next

If py = "" Then
  MsgBox "No Python found." & vbCrLf & vbCrLf & _
         "Please add python to PATH, or ensure one of:" & vbCrLf & _
         "  " & candidates(1) & vbCrLf & _
         "  " & candidates(2), _
         16, "Build Menu - Error"
  WScript.Quit 1
End If

shell.CurrentDirectory = scriptDir

If Not fso.FileExists(scriptDir & "\build-menu.py") Then
  MsgBox "build-menu.py not found in: " & scriptDir, _
         16, "Build Menu - Error"
  WScript.Quit 1
End If

cmd = """" & py & """ build-menu.py"

On Error Resume Next
Set exec = shell.Exec(cmd)
On Error Goto 0

If Err.Number <> 0 Or IsNull(exec) Then
  MsgBox "Failed to launch Python: " & Err.Description, _
         16, "Build Menu - Error"
  WScript.Quit 1
End If

Do While exec.Status = 0
  WScript.Sleep 80
Loop

stdout   = exec.StdOut.ReadAll
stderr   = exec.Stderr.ReadAll
exitCode = exec.ExitCode

If exitCode = 0 Then
  MsgBox "Menu rebuilt successfully." & vbCrLf & vbCrLf & _
         "Output:" & vbCrLf & stdout, _
         64, "Build Menu - Done"
Else
  MsgBox "Menu rebuild failed (exit " & exitCode & ")." & vbCrLf & vbCrLf & _
         "Stderr:" & vbCrLf & stderr & vbCrLf & _
         "Stdout:" & vbCrLf & stdout, _
         16, "Build Menu - Failed"
End If
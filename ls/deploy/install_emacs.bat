@echo off

set PATH=%cd%\..\bin;%path%

set emacs_version=24.4

if not exist ..\bin (
  md ..\bin
  move unzip.bin unzip.exe
  unzip -o bin.zip -d ..\bin\
  move unzip.exe unzip.bin
)

if not exist ..\..\emacs-%emacs_version% (
	md ..\..\emacs-%emacs_version%
	curl -J -O http://ftp.jaist.ac.jp/pub/GNU/emacs/windows/emacs-%emacs_version%-bin-i686-pc-mingw32.zip
	unzip -o emacs-%emacs_version%-bin-i686-pc-mingw32.zip -d ..\..\emacs-%emacs_version%
	unzip -o depends.zip -d ..\..\emacs-%emacs_version%\bin
)

pushd ..\..
set install_path_1=%cd%
set install_path=%install_path_1:\=\\%
popd
  
:: {{{ 设置emacs 的home目录

  >>".\emacs_home.reg" echo Windows Registry Editor Version 5.00
  >>".\emacs_home.reg" echo.
  >>".\emacs_home.reg" echo [HKEY_CURRENT_USER\Software\GNU\Emacs]
  >>".\emacs_home.reg" echo "HOME"="%install_path%"

  regedit /s ".\emacs_home.reg"
  del /F /Q ".\emacs_home.reg"

:: }}}


:: {{{ 设置emacs 的桌面快捷方式
  set se_name="Gnu Emacs"
  set se_path=%install_path_1%
  set se_exe=%se_path%\emacs-%emacs_version%\bin\runemacs.exe

  >>".\shortcut.vbs" echo Set wshShell = WSH.CreateObject("WScript.Shell")
  >>".\shortcut.vbs" echo strDir = wshShell.SpecialFolders("Desktop")
  >>".\shortcut.vbs" echo Set Shortcut = wshShell.CreateShortcut(strDir ^& "\" ^& %se_name% ^& ".lnk")
  >>".\shortcut.vbs" echo Shortcut.TargetPath = "%se_exe%"
  >>".\shortcut.vbs" echo Shortcut.Hotkey = "CTRL+ALT+E"
  >>".\shortcut.vbs" echo Shortcut.Description = "Emacs, Gnu's greate Editor!"
  >>".\shortcut.vbs" echo Shortcut.WorkingDirectory = "%se_path%"
  >>".\shortcut.vbs" echo Shortcut.Save
  >>".\shortcut.vbs" echo Set Shortcut = Nothing
  >>".\shortcut.vbs" echo Set wshShell = Nothing
  
  start /WAIT .\shortcut.vbs
  del /F /Q .\shortcut.vbs
:: }}}

copy ..\bin\ctags.exe c:\windows\

pause >nul

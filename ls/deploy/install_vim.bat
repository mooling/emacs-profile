echo off
set PATH=%cd%\..\bin;%path%

set install_path_1=%cd%
set install_path=%install_path_1:\=\\%

if not exist install (
  md install 
)
pushd install

if not exist vim73_46rt.zip (
	for %%b in (vim73_46rt.zip gvim73_46.zip vim73_46w32.zip) do (
		curl -J -O ftp://ftp.vim.org/pub/vim/pc/%%b
	)

	for %%b in (gvim74.zip vim74rt.zip vim74w32.zip) do (
		curl -J -O ftp://ftp.vim.org/pub/vim/pc/%%b
	)

	curl -J -O http://ftp.gnu.org/gnu/emacs/windows/emacs-24.3-bin-i386.zip
)

popd 

if not exist vim\vim74\vim.exe (
	unzip -o install\emacs-24.3-bin-i386.zip -d .
	unzip -o install\gvim74.zip -d .
	unzip -o install\vim74rt.zip -d .
	unzip -o install\vim74w32.zip -d .
)

:: {{{ 设置emacs 的home目录

  >>".\emacs_home.reg" echo Windows Registry Editor Version 5.00
  >>".\emacs_home.reg" echo.
  >>".\emacs_home.reg" echo [HKEY_CURRENT_USER\Software\GNU\Emacs]
  >>".\emacs_home.reg" echo "HOME"="%install_path%"

  regedit /s ".\emacs_home.reg"
  del /F /Q ".\emacs_home.reg"
:: }}}


:: {{{ 设置vim 的edit by vim 右键关联
  >>".\ebvim.reg" echo Windows Registry Editor Version 5.00
  >>".\ebvim.reg" echo.
  >>".\ebvim.reg" echo [HKEY_CLASSES_ROOT\*\Shell\Edit with vim]
  >>".\ebvim.reg" echo @="Edit by GVim "
  >>".\ebvim.reg" echo.
  >>".\ebvim.reg" echo [HKEY_CLASSES_ROOT\*\Shell\Edit with vim\command]
  >>".\ebvim.reg" echo @="\"%install_path%\\Vim\\vim74\\gvim.exe\" \"%%1\""

  regedit /s ".\ebvim.reg"
  del /F /Q ".\ebvim.reg"
:: }}}

:: {{{
  set se_name="Gnu Emacs"
  set se_path=%install_path_1%
  set se_exe=%se_path%\emacs-24.3\bin\runemacs.exe

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

:: {{{
  >>".\vim.bat" echo @echo off
  >>".\vim.bat" echo rem -- Run Vim --
  >>".\vim.bat" echo.
  >>".\vim.bat" echo set VIM_EXE_DIR=%install_path%\Vim\vim74
  >>".\vim.bat" echo if exist "%VIM%\vim74\vim.exe" set VIM_EXE_DIR=%VIM%\vim74
  >>".\vim.bat" echo if exist "%VIMRUNTIME%\vim.exe" set VIM_EXE_DIR=%VIMRUNTIME%
  >>".\vim.bat" echo.
  >>".\vim.bat" echo if exist "%VIM_EXE_DIR%\vim.exe" goto havevim
  >>".\vim.bat" echo echo "%VIM_EXE_DIR%\vim.exe" not found
  >>".\vim.bat" echo goto eof
  >>".\vim.bat" echo.
  >>".\vim.bat" echo :havevim
  >>".\vim.bat" echo rem collect the arguments in VIMARGS for Win95
  >>".\vim.bat" echo set VIMARGS=
  >>".\vim.bat" echo :loopstart
  >>".\vim.bat" echo if .%1==. goto loopend
  >>".\vim.bat" echo set VIMARGS=%VIMARGS% %1
  >>".\vim.bat" echo shift
  >>".\vim.bat" echo goto loopstart
  >>".\vim.bat" echo :loopend
  >>".\vim.bat" echo.
  >>".\vim.bat" echo if .%OS%==.Windows_NT goto ntaction
  >>".\vim.bat" echo.
  >>".\vim.bat" echo "%VIM_EXE_DIR%\vim.exe"  %VIMARGS%
  >>".\vim.bat" echo goto eof
  >>".\vim.bat" echo.
  >>".\vim.bat" echo :ntaction
  >>".\vim.bat" echo rem for WinNT we can use %*
  >>".\vim.bat" echo "%VIM_EXE_DIR%\vim.exe"  %*
  >>".\vim.bat" echo goto eof
  >>".\vim.bat" echo.
  >>".\vim.bat" echo :eof
  >>".\vim.bat" echo set VIMARGS=
  
  @xcopy vim.bat c:\windows\system32 /Y /Q
  del vim.bat
:: }}}


:: {{{
  set sv_name="GVIM"
  set sv_path=%install_path_1%
  set sv_exe=%install_path%\Vim\vim74\gvim.exe
  
  >>".\shortcut.vbs" echo Set wshShell = WSH.CreateObject("WScript.Shell")
  >>".\shortcut.vbs" echo strDir = wshShell.SpecialFolders("Desktop")
  >>".\shortcut.vbs" echo Set Shortcut = wshShell.CreateShortcut(strDir ^& "\" ^& %sv_name% ^& ".lnk")
  >>".\shortcut.vbs" echo Shortcut.TargetPath = "%sv_exe%"
  >>".\shortcut.vbs" echo Shortcut.Hotkey = "CTRL+ALT+V"
  >>".\shortcut.vbs" echo Shortcut.WorkingDirectory = "%sv_path%"
  >>".\shortcut.vbs" echo Shortcut.Save
  >>".\shortcut.vbs" echo Set Shortcut = Nothing
  >>".\shortcut.vbs" echo Set wshShell = Nothing
  
  start /WAIT .\shortcut.vbs
  del /F /Q .\shortcut.vbs
:: }}}

if not exist install\scripts\down.bat (
	FOR /f "delims=, tokens=1" %%f IN (.\new.lst) DO (
		echo "downloading package : [%%f] ..."
		curl -o tmp.htm http://www.vim.org/scripts/script.php?script_id=%%f
		grep "download_script.php?src_id=" tmp.htm > tmp.grp
		head -1 tmp.grp >> downloadlist.txt
	)

	if exist install\scripts (
	  rmdir /s/q install\scripts 
	)
	mkdir install\scripts

	sed "s/^.*href=\"/curl -J -O http:\/\/www.vim.org\/scripts\//g;s/\">.*$//g" downloadlist.txt > install\scripts\down.bat
	cd install\scripts && call down.bat && cd ..\..
	del downloadlist.txt tmp.htm tmp.grp
)


if not exist vim\vimfiles (
	for %%i in (install\scripts\*.zip) do (
	:: %%i 整个的路径文件名， %%~nxi name ext， %%~ni name， %%~xi ext
		echo unzip -o %%i -d vim\vimfiles-temp
	    unzip -o %%i -d vim\vimfiles-temp
	  )

	for %%i in (install\scripts\*.tar.gz) do (
	:: %%i 整个的路径文件名， %%~nxi name ext， %%~ni name， %%~xi ext
	  copy %%i .
	  echo gzip -d %%~nxi
	  gzip -d %%~nxi
	  echo tar xvf %%~ni -C vim\vimfiles-temp
	  tar xvf %%~ni -C vim\vimfiles-temp

	  del %%~ni
	  )

	for %%i in (install\scripts\*.vim) do (
	:: %%i 整个的路径文件名， %%~nxi name ext， %%~ni name， %%~xi ext
		echo copy %%i vim\vimfiles-temp\plugin
	    copy %%i vim\vimfiles-temp\plugin
	  )

	for %%i in (install\scripts\*.vba.gz) do (
	:: %%i 整个的路径文件名， %%~nxi name ext， %%~ni name， %%~xi ext
	  echo copy %%i .
	  copy %%i .
	  echo gzip -d %%~nxi
	  gzip -d %%~nxi
	  echo mkdir vim\vimfiles
	  mkdir vim\vimfiles
	  vim\vim74\vim -c "so %%" -c "q" %%~ni
	  del %%~ni

	  move vim\vimfiles vim\vimfiles-temp

	  )

	for %%i in (install\scripts\*.vba) do (
	:: %%i 整个的路径文件名， %%~nxi name ext， %%~ni name， %%~xi ext
	  mkdir vim\vimfiles
	  vim\vim74\vim -c "so %%" -c "q" %%i
	  move vim\vimfiles vim\vimfiles-temp
	)

	move vim\vimfiles-temp\plugin\molokai.vim vim\vimfiles-temp\colors\
	move vim\vimfiles-temp vim\vimfiles
)

copy conf\.emacs .
copy conf\_vim* vim\

copy bin\ctags.exe c:\windows\
pause >nul

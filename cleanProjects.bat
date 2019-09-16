@echo off

    :: Check Admin rights and create VBS Script to elevate
    >nul fsutil dirty query %SYSTEMDRIVE% 2>&1 || (

        :: Create VBS script
       echo  Set UAC = CreateObject^("Shell.Application"^)>"%TEMP%\elevate.vbs"
       echo  UAC.ShellExecute "cmd", "/c ""%~f0""", "", "runas", 1 >>"%TEMP%\elevate.vbs"
        if exist "%TEMP%\elevate.vbs" start /b /wait >nul cscript /nologo "%TEMP%\elevate.vbs" 2>&1

        :: Delete elevation script if exist
        if exist "%TEMP%\elevate.vbs" >nul del /f "%TEMP%\elevate.vbs" 2>&1

        exit /b
    )    


pushd "%~dp0"

@echo off
set back=%cd%

for /d %%i in (*.*) do (
	cd "%%i"

	echo Current Directory:
	cd

	IF EXIST "gradlew" (
		call gradlew clean

		) ELSE (
		echo #############################################
		echo ########### Gradlew doesnt exist ############
		echo #############################################
	)

	echo ----------------------------------------------------


	cd %back%
)
cd %back%
echo Finished
pause

popd
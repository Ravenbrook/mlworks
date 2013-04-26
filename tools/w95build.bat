@echo off
set script=%0
shift
set usage=Usage: %script% directory
if "%0"=="" goto failed
set MLWORKS_SRC_PATH=%0\src
set MLWORKS_PERVASIVE=%0\src\pervasive
rts\runtime -load images\I386\Win95\batch.img -pass a -verbose -opt-handlers on -pervasive-dir %MLWORKS_PERVASIVE% -source-path %MLWORKS_SRC_PATH% -compile-pervasive -compile %MLWORKS_SRC_PATH%\main\__batch a
rts\runtime -load images\I386\Win95\batch.img -pass a -verbose -opt-handlers off -pervasive-dir %MLWORKS_PERVASIVE% -source-path %MLWORKS_SRC_PATH% -compile %MLWORKS_SRC_PATH%\interpreter\interpreter %MLWORKS_SRC_PATH%\interpreter\xinterpreter %MLWORKS_SRC_PATH%\basis\require_all a
goto done
:failed
@echo %usage%
:done

@echo off
set script=%0
shift
set usage=Usage: %script% ^^^<directory^^^>
if "%0"=="" goto failed
set MLWORKS_SRC_PATH=%0\src
set MLWORKS_PERVASIVE=%0\src\pervasive
set CONFIG=I386/NT
shift
if "%0"=="" goto do
set CONFIG=%0
:do
rts\runtime -MLWpass MLWargs -load images\I386\NT\batch.img MLWargs -verbose -opt-handlers off -pervasive-dir %MLWORKS_PERVASIVE% -project %MLWORKS_SRC_PATH%\mlworks.mlp -mode Release -compile-pervasive -configuration %CONFIG% -target __batch.sml -target xinterpreter.sml -target interpreter.sml -target require_all.sml -build
goto done
:failed
@echo %usage%
:done

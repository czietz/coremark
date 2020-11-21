:: Test if WATCOM environment variable is set
@IF %WATCOM%.==. (
  @ECHO Enter SET WATCOM=Path-to-compiler before running %0.
  @EXIT /B
)

:: Test if wcc is already in PATH
WHERE /q wcc || SET PATH=%WATCOM%\BINNT;%PATH%
SET EDPATH=%WATCOM%\EDDAT
SET INCLUDE=%WATCOM%\H
SET LIB=%WATCOM%\LIB286\DOS;%WATCOM%\LIB286

:: 8086 instructions, small memory model, optimizations on
SET CFLAGS=-0 -ms -ox

:: Clean
del core_*.obj coremark.exe

:: Compile
wcc %CFLAGS% -I.. -dFLAGS_STR="%CFLAGS%" ..\core_main.c
wcc %CFLAGS% -I.. -dFLAGS_STR="%CFLAGS%" ..\core_list_join.c
wcc %CFLAGS% -I.. -dFLAGS_STR="%CFLAGS%" ..\core_matrix.c
wcc %CFLAGS% -I.. -dFLAGS_STR="%CFLAGS%" ..\core_state.c
wcc %CFLAGS% -I.. -dFLAGS_STR="%CFLAGS%" ..\core_util.c
wcc %CFLAGS% -I.. -dFLAGS_STR="%CFLAGS%" core_portme.c

:: Link
wlink format dos name coremark file core_main,core_list_join,core_matrix,core_state,core_util,core_portme
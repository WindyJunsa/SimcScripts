setlocal enabledelayedexpansion
cd %~dp0\..\..

set fightstyle=%~1
@if "%~1"=="" set fightstyle="1T"

REM T21
RaceSimulation.rb Monk T21_Monk_Windwalker %fightstyle% q
RaceSimulation.rb Monk T21_Monk_Brewmaster %fightstyle% q

REM T20
RaceSimulation.rb Monk T20_Monk_Windwalker %fightstyle% q

@if "%~2"=="nopause" goto finish
@pause
:finish
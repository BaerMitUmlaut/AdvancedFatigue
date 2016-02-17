@echo off
echo Information
echo -----------
echo This build requires a correctly setup P: drive (with the source files being at "P:\b\AdvancedFatigue\addons\main"). If something is wrong with your setup, this build will fail.
echo.
pause
set pathCurrent=%~dp0
set pathBuild="P:\b\AdvancedFatigue\addons\build\@AdvancedFatigue"
set pathSource="P:\b\AdvancedFatigue\addons\main"
if not exist %pathBuild% (mkdir %pathBuild%)
pboProject -P %pathSource% +Engine=Arma3 -S +Noisy +X +Clean +Mod=%pathBuild%
copy /V /Y %pathBuild%\Addons\*.pbo %pathCurrent%
pause

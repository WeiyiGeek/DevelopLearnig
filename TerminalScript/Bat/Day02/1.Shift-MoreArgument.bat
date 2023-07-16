@echo off
::MoreArgument.bat 1 2 3 4 5 6 7 8 9 a b c d e f
::shift
::echo   %1 %2 %3 %4 %5 %6 %7 %8 %9
::shift /0
::echo   %1 %2 %3 %4 %5 %6 %7 %8 %9
::shift /1
::echo   %1 %2 %3 %4 %5 %6 %7 %8 %9
shift /2
echo   %1 %2 %3 %4 %5 %6 %7 %8 %9
shift /3
echo   %1 %2 %3 %4 %5 %6 %7 %8 %9
shift /4
echo   %1 %2 %3 %4 %5 %6 %7 %8 %9
shift /5
echo   %1 %2 %3 %4 %5 %6 %7 %8 %9
shift /6
echo   %1 %2 %3 %4 %5 %6 %7 %8 %9
shift /7
echo   %1 %2 %3 %4 %5 %6 %7 %8 %9
shift /8
echo   %1 %2 %3 %4 %5 %6 %7 %8 %9
pause 1>nul

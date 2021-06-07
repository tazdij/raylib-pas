"C:\FPC\3.2.0\bin\i386-win32\fpc.exe" -Fl./libs -Fu./libs -FE./bin -FU./tmp -g -O1 %1

@REM ) ELSE (
@REM  SET debug=
@REM  SET static=false
@REM  
@REM  FOR %%a in (%*) DO (
@REM    SET cmd=--debug
@REM    CALL SET arg=%%a:%cmd%=%%
@REM    IF NOT "x%%arg%%"=="x%%a%%" (
@REM      SET debug=-g -O1
@REM    )
@REM    SET cmd=--static
@REM    CALL SET arg=%%a:%cmd%=%%
@REM   IF NOT "x%%arg%%"=="x%%a%%" (
@REM     SET static=true
@REM   )
@REM )

@REM   FOR /R ./examples %%F IN (*.pas) DO (
@REM     IF "%static%"=="true" (
@REM       REM fpc -Fl./libs -Fu./libs -FE./bin -FU./tmp %debug% %%F
@REM     )
@REM     IF "%static%"=="false" (
@REM       fpc -Fl./libs -Fu./libs -FE./bin -FU./tmp %debug% %%F
@REM     )
@REM   )
@REM )

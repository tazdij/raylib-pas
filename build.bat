SET debug=
SET static=false

FOR %%a in (%*) DO (
  SET cmd=--debug
  CALL SET arg=%%a:%cmd%=%%
  IF NOT "x%%arg%%"=="x%%a%%" (
    SET debug=-g -O1
  )
  SET cmd=--static
  CALL SET arg=%%a:%cmd%=%%
  IF NOT "x%%arg%%"=="x%%a%%" (
    SET static=true
  )
)

FOR /R ./examples %%F IN (*.pas) DO (
  if "%static%"=="true" (
    REM fpc -Fl./libs -Fu./libs -FE./bin -FU./tmp %debug% %%F
  )
  if "%static%"=="false" (
    fpc -Fl./libs -Fu./libs -FE./bin -FU./tmp %debug% %%F
  )  
)

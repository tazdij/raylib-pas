FOR /R ./examples %%F in (*.pas) do (
  fpc -Fl./libs -Fu./libs -FE./bin -FU./tmp %%F
)

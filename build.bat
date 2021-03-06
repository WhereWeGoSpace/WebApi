@echo off

rem fetch udpates
git pull origin

rem start testing http server
cd src
start cmd /k http-server -p 8080

rem execute unit testing
cd ../test
qunit-cli testGeneratePaymentInfo.js
qunit-cli testGetTravelInfo.js
cd ..

rem execute end to end testing
cd ../test
cmd /c .\node_modules\.bin\cucumber.js.cmd

echo %errorlevel%
if errorlevel 1 (
  echo 'build failed.'
  cd ..
  GOTO:EOF
)
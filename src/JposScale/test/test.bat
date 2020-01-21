@echo off

set oldcp=%classpath%
set classpath=%classpath%;jpos113.jar
set classpath=%classpath%;log4j-1.2.15.jar
set classpath=%classpath%;RXTXComm.jar
set classpath=%classpath%;xerces.jar
set classpath=%classpath%;SmScale.jar
set classpath=%classpath%;%cd%\

REM %lp% is the library path used when loading
REM java native methods

set lp=c:\windows\system32

REM ***************************************
REM *  Add Device Specific jar's here...  *
REM ***************************************

REM set classpath=%classpath%;c:\path_to_service.jar
set classpath=%classpath%;sampleld.jar
REM set lp=%lp%;c:\path_to_native_methods

java -cp %classpath% -Djava.library.path=%lp% com.shtrih.ScaleTests

set classpath=%oldcp%

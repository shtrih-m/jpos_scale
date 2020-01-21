@echo off
set oldcp=%classpath%
set classpath=%classpath%;calibutil.jar
set classpath=%classpath%;%cd%\
set lp=c:\windows\system32
set lp=%lp%;%cd%\
java.exe -cp %classpath% -Djava.library.path=%lp% com.shtrih.scalecalib.MainDialog
set classpath=%oldcp%
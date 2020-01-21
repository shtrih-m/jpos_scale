#!/bin/sh
CLASSPATH=postest.jar
CLASSPATH=$CLASSPATH:jpos113.jar
CLASSPATH=$CLASSPATH:xerces.jar
CLASSPATH=$CLASSPATH:log4j-1.2.15.jar
CLASSPATH=$CLASSPATH:nrjavaserial-3.15.0.jar
CLASSPATH=$CLASSPATH:SmScale.jar


CLASSPATH=$CLASSPATH:.

LIB_PATH=$LD_LIBRARY_PATH
########################################
#                                      #
#  Add Device Specific jar's here...   #
#                                      #
########################################

#CLASSPATH=$CLASSPATH:/path_to_service.jar
CLASSPATH=$CLASSPATH:sampleld.jar


java -cp $CLASSPATH -Djava.library.path=$LIB_PATH com.shtrih.ScaleTests

#!/bin/sh
CLASSPATH=postest.jar
CLASSPATH=$CLASSPATH:jpos110.jar
CLASSPATH=$CLASSPATH:xerces.jar
CLASSPATH=$CLASSPATH:.

LIB_PATH=$LD_LIBRARY_PATH
########################################
#                                      #
#  Add Device Specific jar's here...   #
#                                      #
########################################

#CLASSPATH=$CLASSPATH:/path_to_service.jar
CLASSPATH=$CLASSPATH:sampleld.jar


java -cp $CLASSPATH -Djava.library.path=$LIB_PATH com.jpos.POStest.POStest

#!/bin/sh

grails war
rsync -acvz --human-readable --progress --chmod=u+w,a+r -e ssh target/sam-0.1.war root@50.116.50.220:/var/lib/tomcat7/webapps/sam.war
ssh root@50.116.50.220 'service tomcat7 stop;rm -rf /var/lib/tomcat7/webapps/sam;service tomcat7 start;chmod +x /var/lib/tomcat7/webapps/sam/WEB-INF/program/XLOGP3/bin/*;chmod +x /var/lib/tomcat7/webapps/sam/WEB-INF/program/XLogS/bin/*'


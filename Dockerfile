FROM store/oracle/serverjre:8
MAINTAINER torsten.kleiber@web.de
ARG SW_FILE
ADD $SW_FILE /tmp/
RUN yum -y install xterm xauth libXtst \
&& yum -y install /tmp/$SW_FILE \
&& rm -f /tmp/$SW_FILE
ENV JAVA_HOME=/usr/java/default
CMD datamodeler

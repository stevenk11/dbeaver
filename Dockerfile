FROM debian:buster-slim

RUN sed -i -e "s/deb.debian/ftp.hk.debian/g" /etc/apt/sources.list

RUN apt-get update \
	&& mkdir -p /usr/share/man/man1 /usr/share/man/man7 \
	&& apt-get install -y --no-install-recommends \
	openjdk-11-jre-headless \
	libswt-gtk-4-jni \
	libswt-gtk-4-java

RUN apt-get install -y --no-install-recommends \
	ca-certificates wget gnupg \
	&& wget -O - https://dbeaver.io/debs/dbeaver.gpg.key | apt-key add - \
	&& echo "deb https://dbeaver.io/debs/dbeaver-ce /" >> /etc/apt/sources.list

RUN apt-get update && apt-get install -y --no-install-recommends \
	dbeaver-ce \
	&& rm -rf /var/lib/apt/lists/* \
	&& apt-get purge -y --auto-remove wget gnupg

ENTRYPOINT ["dbeaver"]

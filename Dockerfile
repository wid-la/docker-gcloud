FROM google/cloud-sdk:latest

RUN uname -r

RUN apt-get update && apt-get install -y apt-transport-https ca-certificates curl
# RUN apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
# RUN echo 'deb https://apt.dockerproject.org/repo debian-jessie main' > /etc/apt/sources.list.d/docker.list
# RUN apt-get update && apt-cache policy docker-engine
# RUN apt-get install -y docker-engine && apt-get clean
# RUN usermod -aG docker $(whoami)
# RUN service docker start

ENV DOCKER_BUCKET get.docker.com
ENV DOCKER_VERSION 1.12.3
ENV DOCKER_SHA256 6b644ecc1977c479212676757bff05664fcb655a
# 05ceec7fd937e1416e5dce12b0b6e1c655907d349d52574319a1e875077ccb79

RUN set -x \
	&& curl -fSL "https://${DOCKER_BUCKET}/builds/Linux/x86_64/docker-${DOCKER_VERSION}.tgz" -o docker.tgz \
	# && echo "${DOCKER_SHA256} *docker.tgz" | sha256sum -c - \
	&& tar -xzvf docker.tgz \
	&& mv docker/* /usr/local/bin/ \
	&& rmdir docker \
	&& rm docker.tgz \
	&& docker -v

COPY docker-entrypoint.sh /usr/local/bin/

RUN chmod +x /usr/local/bin/docker-entrypoint.sh 

ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["sh"]
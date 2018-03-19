# To create image, docker build . -t grailsapp
# Pull base image.
FROM debian

RUN apt-get update
# gpg is needed to verify package signature.
RUN apt-get install --no-install-recommends --no-install-suggests -y gpg sudo
RUN apt-get install --no-install-recommends --no-install-suggests -y curl software-properties-common monit

# Install java.
RUN \
  echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | debconf-set-selections && \
  add-apt-repository -y ppa:webupd8team/java && \
  apt-get update && \
  apt-get install --allow-unauthenticated -y oracle-java8-installer && \
  rm -rf /var/lib/apt/lists/* && \
rm -rf /var/cache/oracle-jdk8-installer

# Create specific user
RUN useradd --create-home --shell /bin/bash grails && adduser grails sudo
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
USER grails
WORKDIR /home/grails

# Define commonly used JAVA_HOME variable
ENV JAVA_HOME /usr/lib/jvm/java-8-oracle

COPY ./bin/grailsapp.sh /home/grails
COPY ./etc/monitrc /etc/monit/conf.d/example.conf
COPY --chown=grails ./build/libs/docker-example.war /home/grails

# Define default command.
CMD sudo /etc/init.d/monit start && bash


# To run:
#   docker run -i -t -p 9000:8080 grailsapp

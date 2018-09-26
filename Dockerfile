ARG MM_VERSION=5.3.1

FROM mysql:5.7

MAINTAINER Lixtec - Ludovic TERRAL

ENV MM_VERSION=${JENKINS_VERSION:-5.3.1} 
ENV MYSQL_ROOT_PASSWORD=mostest
ENV MYSQL_USER=mmuser
ENV MYSQL_PASSWORD=mostest
ENV MYSQL_DATABASE=mattermost
ENV TZ=Europ/paris

# Install ca-certificates to support TLS of Mattermost v3.5
RUN apt-get update && apt-get install -y ca-certificates curl

#
# Configure Mattermost
#
WORKDIR /mm

# Copy over files
RUN curl -k https://releases.mattermost.com/$MM_VERSION/mattermost-team-$MM_VERSION-linux-amd64.tar.gz | tar -xvz 
ADD config_docker.json ./mattermost/default/config_docker.json 
ADD docker-entry.sh .

RUN chmod +x ./docker-entry.sh
ENTRYPOINT ./docker-entry.sh

# Create default storage directory
RUN mkdir ./data
VOLUME ./data

# Ports
EXPOSE 8080

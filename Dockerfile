FROM mysql:5.7

MAINTAINER Lixtec - Ludovic TERRAL

ENV MM_VERSION=4.8.0
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
#ADD https://releases.mattermost.com/4.1.1/mattermost-team-4.1.1-linux-amd64.tar.gz .
#RUN tar -zxvf ./mattermost-team-4.1.1-linux-amd64.tar.gz
RUN curl -k https://releases.mattermost.com/$MM_VERSION/mattermost-team-$MM_VERSION-linux-amd64.tar.gz | tar -xvz 
ADD config_docker.json ./config/config_docker.json 
ADD docker-entry.sh .

RUN chmod +x ./docker-entry.sh
ENTRYPOINT ./docker-entry.sh

# Create default storage directory
RUN mkdir ./data
VOLUME ./data

# Ports
EXPOSE 80
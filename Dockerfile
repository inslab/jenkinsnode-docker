FROM ubuntu:14.04
MAINTAINER Sunchan Lee <sunchanlee@inslab.co.kr>

RUN apt-get update && apt-get install -y wget curl ssh openjdk-7-jdk supervisor

EXPOSE 22

# ENV USER_ID is needed
# ENV USER_PASSWORD is needed

# ENV SCRIPT_REPO_URL is needed
# ENV SCRIPT_FILE is needed

VOLUME /home

COPY start.sh /tmp/
RUN chmod +x /tmp/*.sh
CMD ["/bin/bash", "-e", "/tmp/start.sh"]

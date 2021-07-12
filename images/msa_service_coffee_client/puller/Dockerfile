FROM ubuntu:16.04
RUN apt-get update && apt-get install -y git
ADD ./client_contents_puller.sh /client_contents_puller.sh
RUN chmod 755 /client_contents_puller.sh
WORKDIR /
ENTRYPOINT /client_contents_puller.sh

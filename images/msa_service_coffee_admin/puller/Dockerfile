FROM ubuntu:16.04
RUN apt-get update && apt-get install -y git
ADD ./admin_contents_puller.sh /admin_contents_puller.sh
RUN chmod 755 /admin_contents_puller.sh
WORKDIR /
ENTRYPOINT /admin_contents_puller.sh

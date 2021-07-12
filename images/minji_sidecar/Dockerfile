FROM ubuntu:16.04
RUN apt-get update && apt-get install -y git
ADD ./contents-pull.sh /contents-pull.sh
RUN chmod 755 /contents-pull.sh
WORKDIR /
cmd /contents-pull.sh

FROM ubuntu:22.04
ARG DEBIAN_FRONTEND=noninteractive

WORKDIR /

RUN apt update -y && apt upgrade -y

WORKDIR /aion

CMD ["sh", "-c", "/aion/start.sh"]

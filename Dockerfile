FROM ubuntu:22.04
ARG DEBIAN_FRONTEND=noninteractive

WORKDIR /

RUN apt update -y && apt upgrade -y && apt install unrar

COPY . /aion/

WORKDIR /aion/reqs

RUN unrar x runner.part1.rar
RUN mv java /aion/java

WORKDIR /aion

RUN chmod +x ./*.sh

RUN ./build.sh

CMD ["sh", "-c", "/aion/start.sh"]

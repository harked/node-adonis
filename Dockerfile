FROM ubuntu:18.04

RUN apt-get update && apt-get install -y docker.io && \
    apt-get install -y curl && apt-get install -y wget

RUN curl -sL https://deb.nodesource.com/setup_10.x -o nodesource_setup.sh && \
    bash nodesource_setup.sh && \
    apt-get -y install nodejs && \
    npm i -g n

RUN curl -L "https://github.com/docker/compose/releases/download/1.24.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose && chmod +x /usr/local/bin/docker-compose && ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose

COPY . /ucode

RUN cd /ucode && \
    pwd && \
    ls && \
    npm i -g @adonisjs/cli && \
    npm install

ADD https://github.com/ufoscout/docker-compose-wait/releases/download/2.2.1/wait /wait

RUN chmod +x /wait

## Launch the wait tool and then your application
CMD pwd && /wait && cd /ucode && npm install && adonis key:generate && adonis test && sleep infinity
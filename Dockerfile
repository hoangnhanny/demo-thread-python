FROM ubuntu:18.04

RUN apt-get update -y

RUN apt-get install -y openjdk-8-jdk openjdk-8-jre

RUN apt-get install -y curl
# cai Embulk

RUN curl --create-dirs -o ~/.embulk/bin/embulk -L "https://dl.embulk.org/embulk-latest.jar"

RUN chmod +x ~/.embulk/bin/embulk

RUN echo 'export PATH="$HOME/.embulk/bin:$PATH"' >> ~/.bashrc

RUN /bin/bash -c "source ~/.bashrc"

RUN ln -s /root/.embulk/bin/embulk /bin/embulk

RUN embulk gem install representable -v 3.0.4

RUN embulk gem install embulk-input-mysql

RUN embulk gem install faraday -v 0.17.4

RUN embulk gem install embulk-output-bigquery

RUN apt-get install -y iputils-ping

RUN apt-get install -y software-properties-common
RUN add-apt-repository ppa:deadsnakes/ppa
# RUN apt-get update -y
RUN apt-get install -y python3.8
RUN apt-get install -y python3.8-venv

# RUN apt-get install -y python3.8-pip

ENV FLASK_ENV=development

WORKDIR /opt/Project/

# RUN mkdir opt 

COPY run.sh /opt/run.sh

COPY requirements.txt requirements.txt

RUN chmod +x /opt/run.sh
RUN sed -i -e 's/\r$//' /opt/run.sh
RUN rm /bin/sh && ln -s /bin/bash /bin/sh


ENTRYPOINT [ "/opt/run.sh" ]
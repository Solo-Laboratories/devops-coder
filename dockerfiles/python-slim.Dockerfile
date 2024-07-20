FROM codercom/code-server:4.12.0

USER root

RUN apt-get update && apt-get install python3 python3-pip nano vim curl --no-install-recommends -y && rm -rf /var/lib/apt/lists/*

USER coder
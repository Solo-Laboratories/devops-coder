FROM docker.io/sololaboratories/base:debian

RUN wget https://packages.microsoft.com/config/debian/12/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
    && dpkg -i packages-microsoft-prod.deb \
    && rm packages-microsoft-prod.deb

RUN apt update && \
    && apt install -y --no-install-recommends dotnet-sdk-8.0 aspnetcore-runtime-8.0 \
    && apt clean autoclean \
    && apt autoremove -y \
    && rm -rf /var/lib/apt/lists/* 
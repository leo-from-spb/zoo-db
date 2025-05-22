FROM mcr.microsoft.com/mssql/server:2017-CU31-OD1-ubuntu-18.04

LABEL authors="Leo"

ENV MSSQL_PID=Developer
ENV ACCEPT_EULA=Y
ENV MSSQL_SA_PASSWORD=Mini-pass

USER root

RUN apt-get update && apt-get install -y \
    curl \
    iproute2 \
    debconf-utils \
    gnupg2 \
    unixodbc-dev

RUN useradd -M -s /bin/bash -u 10001 -g 0 mssql
RUN mkdir /scripts
RUN chown -R 10001:0 /scripts
RUN chmod -R 771 /scripts

ADD ./entrypoint.sh /
RUN chmod +x /entrypoint.sh

RUN mkdir -p /.system && \
    chown mssql:root /.system && \
    chmod 775 /.system

RUN mkdir -p /var/opt/mssql && \
    chown -R mssql:root /var/opt/mssql && \
    chmod -R g+rwx /var/opt/mssql

USER mssql

EXPOSE 1433

WORKDIR /scripts

ENTRYPOINT ["/entrypoint.sh"]

FROM mcr.microsoft.com/mssql/server:2022-CU19-ubuntu-22.04

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

RUN mkdir /scripts
RUN chown -R 10001:10001 /scripts
RUN chmod -R 771 /scripts

ADD ./entrypoint.sh /
RUN chmod +x /entrypoint.sh

USER mssql

EXPOSE 1433

WORKDIR /scripts

ENTRYPOINT ["/entrypoint.sh"]

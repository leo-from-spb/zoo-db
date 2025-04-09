FROM mcr.microsoft.com/mssql/server:2019-latest

LABEL authors="Leo"

WORKDIR /var/scripts
COPY ./run.sh .
COPY ./entrypoint.sh .

RUN mkdir -p /tmp/scripts

ENV ACCEPT_EULA=Y
ENV MSSQL_SA_PASSWORD=Mini-pass

EXPOSE 1433

ENTRYPOINT /var/scripts/entrypoint.sh

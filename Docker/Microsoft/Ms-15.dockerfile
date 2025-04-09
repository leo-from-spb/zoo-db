FROM mcr.microsoft.com/mssql/server:2019-latest

LABEL authors="Leo"

ENV ACCEPT_EULA=Y
ENV MSSQL_SA_PASSWORD=Mini-pass

USER root

RUN apt-get update
RUN apt-get install -y curl mssql-tools

EXPOSE 1433


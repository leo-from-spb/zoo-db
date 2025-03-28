FROM mcr.microsoft.com/mssql/server:2022-latest

LABEL authors="Leo"

ENV ACCEPT_EULA=Y
ENV MSSQL_SA_PASSWORD=Mini-pass

EXPOSE 1433


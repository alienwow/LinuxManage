FROM mcr.microsoft.com/dotnet/core/sdk:3.0-disco

MAINTAINER Vito <wuwenhao0327@gmail.com>

RUN apt-get update -y \
    && apt-get upgrade -y \
    && apt install git

ENV container docker
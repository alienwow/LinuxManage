FROM mcr.microsoft.com/dotnet/core/sdk:2.2-bionic

MAINTAINER Vito <wuwenhao0327@gmail.com>

RUN apt-get update -y \
    && apt-get upgrade -y \
    && apt install git

ENV container docker
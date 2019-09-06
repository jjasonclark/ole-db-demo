FROM node:10
LABEL description="Ole DB demo"
LABEL author="jason@jjasonclark.com"
WORKDIR /app
ENV NODE_ENV=production
ENV CONNECTION_STRING=missing
ENV QUERY=missing

# Install dot net core prerequisites
# https://docs.microsoft.com/en-us/dotnet/core/linux-prerequisites?tabs=netcore2x
# https://github.com/dotnet/core/blob/master/Documentation/linux-prereqs.md
RUN apt-get update -q && \
    apt-get install --upgrade -yq apt-transport-https apt-utils && \
    apt-get install --upgrade -yq libglib2.0-dev libicu-dev libssl-dev python build-essential

# Install dot net core
# https://dotnet.microsoft.com/download
RUN curl -fsSL https://packages.microsoft.com/keys/microsoft.asc | apt-key add -
RUN curl -fsSL https://packages.microsoft.com/config/debian/9/prod.list > /etc/apt/sources.list.d/dotnet.list
RUN apt-get update -q && \
    apt-get install --upgrade -yq dotnet-sdk-2.2

COPY CODE-OF-CONDUCT.md package.json package-lock.json /app/
RUN npm ci
COPY src/ /app/src/

USER node
CMD node /app/src/index.js

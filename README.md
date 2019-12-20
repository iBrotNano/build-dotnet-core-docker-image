# Readme

Maintainer: <marcel@3h-co.de>

Version: 4.7.1.1

[TOC]

## What is it?

The dockerfile created a Docker image which runs a build container for .NET projects. With this container you can run command line interfaces like `dotnet`, `mono` or `nuget` to build your .NET solutions.

The image is bases on Microsoft's image mcr.microsoft.com/dotnet/core/sdk.

## How can i create the image?

You will need Docker to create the image. I will show how to setup Docker and create the image on a Ubuntu machine.

### Install Docker

First remove all old installations of Docker if there are any.

```bash
sudo apt remove docker-engine docker.io
```

The Docker package is renamed into **docker-ce**.

Then update the package cache.

```bash
sudo apt update
```

You will need some dependencies to install Docker.

```bash
sudo apt install apt-transport-https ca-certificates curl software-properties-common
```

**apt** must know the gpg key for the Docker repository.

```bash
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
```

Ensure that always the stable version will be installed.

```bash
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
```

Update the package index again and install **docker-ce**.

```bash
sudo apt update
sudo apt install docker-ce
```

You will need an additional component to compose Docker images.

```bash
# Download Docker Compose
curl -L https://github.com/docker/compose/releases/download/$docker_compose_version/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose

chmod +x /usr/local/bin/docker-compose

curl -L https://raw.githubusercontent.com/docker/compose/$docker_compose_version/contrib/completion/bash/docker-compose -o /etc/bash_completion.d/docker-compose
```

### Create and use the image

The file _app-usage.md_ describes the building and using of the image in detail.
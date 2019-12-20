# How to use the image?

## What is it?

The image is meant to build .NET project.

It depends on Microsoft's image _mcr.microsoft.com/dotnet/core/sdk_ and adds Nuget depending on Mono. The tool `dotnet` does not offer all commands `nuget` does like configuring Nuget itself to access an own Nuget repository.

## Build the image

The image can be build like any other. The official documentation of Docker should be the single point of truth if something went wrong. You can find it at https://docs.docker.com/engine/reference/commandline/build/.

Basically you only have to do those steps:

1. Navigate into the projects directory: `cd \path\to\project\`

2. Build the image: `docker build --rm -t build-dotnet-core .`. An image is build with the name **build-dotnet-core** and the tag **latest**. You can check the terminal's output to see if the building succeeded. 

   The dockerfile contains an `ARG` which defines the versions of the base image. You can change it by passing the argument to `docker build`.

   ```bash
   docker build -t build-dotnet-core:3.1.100 --build-arg base_image_version=3.1.100 .
   ```

   If you don't pass any argument the default in the dockerfile will be used, which is `latest`. That way you always will get the latest build image.

3. Check if the image is build: `docker image ls`. If there is an image with the name and tag **build-dotnet-core:latest** everything is fine.

4. Run a command to see if the image works and to get the version of  `dotnet`: `docker run build-dotnet-core dotnet --version`

5. Let's tag the version of the image with the version of  `dotnet` to have the ability to use older images later. In my case the version was 3.1.100: `docker build -rm -t build-dotnet-core:3.1.100 .`.

## Using the image

You already have seen how to run commands with `dotnet`, but there is other stuff in the image.

To run a `dotnet` command:

```bash
docker run -it --rm build-dotnet-core dotnet --version
```

To run `nuget`

```bash
docker run -it --rm build-dotnet-core mono /usr/local/bin/nuget.exe 
```

As you can see the Mono version of Nuget is used. It has some limitations which are listed at https://docs.microsoft.com/en-us/nuget/install-nuget-client-tools#feature-availability.

I added a script which encapsulated this mono call. So you are able to just use it like this:

```bash
docker run -it --rm build-dotnet-core nuget
```

## Update the image locally

To update the image just build a new one. You need to remove the latest build first.

```bash
docker image rm build-dotnet-core:latest
docker build --rm -t build-dotnet-core .
```

## Pushing the image to a registry

To push the image to a registry you will first have to authenticate at it.

```bash
docker login registry.host.tld
```

Pulling and pushing images is described under https://docs.docker.com/engine/reference/commandline/pull/ and https://docs.docker.com/engine/reference/commandline/push/.

First you will have to tag the images to mark the version and to point to the registry. After that you can push the image to the registry.

```bash
docker tag build-dotnet-core:latest registry.host.tld/build-dotnet-core:latest
docker push registry.host.tld/build-dotnet-core:latest
```

You will have to do this step for every tagged version of the image.

To pull images from the registry do this:

```bash
docker pull registry.host.tld/build-dotnet-core:tag
```

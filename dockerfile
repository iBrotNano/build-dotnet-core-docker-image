ARG base_image_version=latest
FROM mcr.microsoft.com/dotnet/core/sdk:${base_image_version}

LABEL maintainer="Marcel Melzig <marcel@3h-co.de>"
LABEL org.label-schema.schema-version="1.0.0-rc.1"
LABEL org.label-schema.name="build-dotnet-core"
LABEL org.label-schema.description="This image contains all needed to run .NET Core or .NET Standard builds through a GitLab Runner. Other CI tools should work as well."
LABEL org.label-schema.usage="/usr/doc/app-usage.md"
LABEL org.label-schema.version="${base_image_version}"

COPY app-usage.md /usr/doc/app-usage.md
COPY nuget /usr/bin/nuget

RUN apt clean \
	&& apt update -y \
	&& apt upgrade -y \
	&& apt -y install apt-transport-https dirmngr gnupg ca-certificates \
	&& apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF \
	&& echo "deb https://download.mono-project.com/repo/debian stable-buster main" | tee /etc/apt/sources.list.d/mono-official-stable.list \
	&& apt update -y \
	&& apt install mono-complete -y \
	&& apt autoremove -y \
	&& apt clean \
	&& rm -rf /var/lib/lists/* \
    && curl -o /usr/local/bin/nuget.exe https://dist.nuget.org/win-x86-commandline/latest/nuget.exe \
	&& chmod +x /usr/bin/nuget
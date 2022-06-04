FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build-env
WORKDIR /app

# Copy csproj file and retore packages
COPY *.csproj ./
RUN dotnet restore

COPY . ./
RUN dotnet publish -c Release -o /app/publish

FROM mcr.microsoft.com/dotnet/sdk:6.0
WORKDIR /app
COPY --from=build-env /app/publish .
ENTRYPOINT ["dotnet", "localapi.dll"]


# Stage 1: Build the application
FROM mcr.microsoft.com/dotnet/sdk:9.0 AS build
WORKDIR /source
COPY . .
RUN dotnet restore
RUN dotnet publish -c Release -o /app

# Stage 2: Run the application
FROM mcr.microsoft.com/dotnet/aspnet:9.0

# ADD THIS LINE: Tells Docker to run as an admin so it can save images
USER root

WORKDIR /app
COPY --from=build /app .
COPY --from=build /source/libriverse.db .

EXPOSE 8080
ENV ASPNETCORE_HTTP_PORTS=8080
ENTRYPOINT ["dotnet", "BookLibraryApp.dll"]
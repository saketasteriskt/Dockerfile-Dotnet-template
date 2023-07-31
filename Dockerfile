# First import the base image to build & run your dotnet application
# Import dotnet sdk image based on dotnet version of the code.
# Here we are pulling from the 6.0 version of dotnet sdk
FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build-env

# Set /app as current work directory
WORKDIR /app

# COPY All current project files, if there are any files that needs
# to be excluded create .dockerignore and add them there
COPY . .

# copy csproj and restore as distinct layers
RUN dotnet restore

# copy the relative folder containing the application to root and build app
COPY App.API/. /app/
WORKDIR /app/

# Select the solution file and publish
RUN dotnet publish example.sln  -c Release -o out


# final stage to build the image
FROM mcr.microsoft.com/dotnet/aspnet:6.0
WORKDIR /app
COPY --from=build-env /app/out .

# Set the ENVironment variable
# In this case we will use it to specify port
ENV ASPNETCORE_URLS http://*:8080

# Expose port
EXPOSE 8080

# Run the app
ENTRYPOINT ["dotnet", "App.API.dll"]

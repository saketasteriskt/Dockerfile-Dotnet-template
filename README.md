# Dockerfile Template for Dotnet Application

- This repository provides a Dockerfile template for building and running a .NET application using Docker. It sets up a multi-stage build process to separate the build environment from the final production image.

## Prerequisites

- Docker installed on your local machine.

## Usage

1. Copy the contents of the provided Dockerfile into a file named `Dockerfile` in the root directory of your Dotnet project.

2. Create a `.dockerignore` file in the root directory of your project if there are any files that need to be excluded from the Docker image.

3. Replace the file contents with your own project needs

## Build the Docker image:

```
   docker build -t dotnet-app:testing .
```

- This command will build the Docker image using the Dockerfile and tag it with the name given above 'dotnet-app' with 'testing' tag, if you don't specify anything after 'dotnet-app:' the image will be built with latest tag.

## Run the Docker container:

```
docker run -p 8080:8080 your-org/dotnet-app
```

- This command will start the Docker container based on the built image and expose port 8080 on your local machine.

- Access your running application by opening a web browser and navigating to http://localhost:8080.

## Dockerfile Explanation

- The Dockerfile consists of two stages: build-env and the final stage.

1. Build Stage

- The build-env stage is responsible for building the .NET application.
- It starts with the official dotnet SDK image for the specified version (in this case, 6.0).
- The working directory is set to /app.
- The entire content of the current directory is copied to the /app directory in the image, excluding any files specified in the .dockerignore file.
- The dotnet restore command is executed to restore the NuGet packages.
- The App.API folder containing the application is copied to the root of the /app directory.
- The working directory is changed to /app.
- The dotnet publish command is run to build the application, using the example.sln solution file, with the Release configuration, and the output is placed in the out directory.

2. Final Stage

- The final stage uses the mcr.microsoft.com/dotnet/aspnet:6.0 image as the base image for the production environment.

- The working directory is set to /app.

- The output from the build-env stage (located in the /app/out directory) is copied to the current working directory in the final image.

- An environment variable ASPNETCORE_URLS is set to http://\*:8080 to specify the port on which the ASP.NET Core application will listen.

- Port 8080 is exposed to allow inbound traffic to the container.

- The dotnet command is executed with App.API.dll as the entry point to start the application.

# Contributing

If you have any improvements or suggestions, feel free to contribute by creating a pull request or opening an issue in this repository.

# Use the official .NET SDK image to build the app
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src

# Clone the repo and publish the app
RUN git clone https://github.com/Azure-Samples/SQL-AI-samples.git ms-samples
WORKDIR /src/ms-samples/MssqlMcp/dotnet/MssqlMcp
RUN dotnet publish -c Release -o /app/publish

# Use the official ASP.NET runtime image for the final container
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS final
WORKDIR /app
COPY --from=build /app/publish .

# Expose the default ASP.NET Core port
EXPOSE 80

# Set the entrypoint
ENTRYPOINT ["dotnet", "MssqlMcp.dll"]
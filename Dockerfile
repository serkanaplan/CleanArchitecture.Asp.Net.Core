FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS base
USER app
WORKDIR /app
EXPOSE 8080
EXPOSE 8081

FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
ARG BUILD_CONFIGURATION=Release
WORKDIR /src
COPY ["CleanArchitecture.WebAPI/CleanArchitecture.WebAPI.csproj", "CleanArchitecture.WebAPI/"]
COPY ["CleanArchitecture.Application/CleanArchitecture.Application.csproj", "CleanArchitecture.Application/"]
Copy ["CleanArchitecture.Domain/CleanArchitecture.Domain.csproj", "CleanArchitecture.Domain/"]
Copy ["CleanArchitecture.Infrastructure/CleanArchitecture.Infrastructure.csproj", "CleanArchitecture.Infrastructure/"]
Copy ["CleanArchitecture.Persistance/CleanArchitecture.Persistance.csproj", "CleanArchitecture.Persistance/"]
Copy ["CleanArchitecture.Presentation/CleanArchitecture.Presentation.csproj", "CleanArchitecture.Presentation/"]

COPY *.sln .

RUN dotnet restore

COPY . .

RUN dotnet publish "./CleanArchitecture.WebAPI/*.csproj"  -o /publish/

FROM base AS final
WORKDIR /app
COPY --from=build /publish .
ENV ASPNETCORE_URLS="http://*:3200"
ENV ASPNETCORE_ENVIRONMENT = "Production"
ENTRYPOINT ["dotnet", "CleanArchitecture.WebAPI.dll"]
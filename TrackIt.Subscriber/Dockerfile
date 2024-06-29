FROM mcr.microsoft.com/dotnet/runtime:6.0 AS base
WORKDIR /app

FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
WORKDIR /src
COPY ["TrackIt.Subscriber/TrackIt.Subscriber.csproj", "TrackIt.Subscriber/"]
RUN dotnet restore "TrackIt.Subscriber/TrackIt.Subscriber.csproj"
COPY . .
WORKDIR "/src/TrackIt.Subscriber"
RUN dotnet build "TrackIt.Subscriber.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "TrackIt.Subscriber.csproj" -c Release -o /app/publish /p:UseAppHost=false

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "TrackIt.Subscriber.dll"]
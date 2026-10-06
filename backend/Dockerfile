# Build stage
FROM mcr.microsoft.com/dotnet/sdk:9.0 AS build
WORKDIR /src

COPY ["Movie_Ticket_Booking_Backend.csproj", "./"]
RUN dotnet restore "Movie_Ticket_Booking_Backend.csproj"

COPY . .
RUN dotnet publish "Movie_Ticket_Booking_Backend.csproj" -c Release -o /app/publish /p:UseAppHost=false

# Runtime stage
FROM mcr.microsoft.com/dotnet/aspnet:9.0 AS final
WORKDIR /app
COPY --from=build /app/publish .

ENV ASPNETCORE_URLS=http://+:8080
EXPOSE 8080

ENTRYPOINT ["dotnet", "Movie_Ticket_Booking_Backend.dll"]

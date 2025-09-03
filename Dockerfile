# Stage 1: Build the WAR file and download webapp-runner
FROM maven:3.8.6-eclipse-temurin-8 AS builder

WORKDIR /app

COPY . .

RUN mvn clean package -DskipTests

# Stage 2: Runtime image
FROM eclipse-temurin:8-jdk-alpine

WORKDIR /app

COPY --from=builder /app/target/*.war app.war
COPY --from=builder /app/target/webapp-runner.jar webapp-runner.jar

# Expose new port
EXPOSE 8076

# Run WAR using webapp-runner on port 8076
ENTRYPOINT ["java", "-jar", "webapp-runner.jar", "--port", "8076", "app.war"]


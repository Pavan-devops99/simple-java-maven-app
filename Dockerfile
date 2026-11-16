
# Stage 1: Build Java application using Maven
FROM maven:3.9-eclipse-temurin-8 AS build

WORKDIR /app

# Copy project files
COPY . .

# Build the application and generate JAR
RUN mvn clean package -DskipTests

# Stage 2: Run Java application
FROM eclipse-temurin:8-jre

WORKDIR /app

# Copy generated JAR from build stage
COPY --from=build /app/target/*.jar app.jar

# Start application
ENTRYPOINT ["java", "-jar", "app.jar"]


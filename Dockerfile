# Etapa 1: compilar con Maven (no necesitas Java ni Maven instalados)
FROM maven:3.9-eclipse-temurin-21 AS build
WORKDIR /src
COPY pom.xml .
COPY src ./src
RUN mvn -B clean package -DskipTests

# Etapa 2: imagen final, igual a la del tutorial
FROM eclipse-temurin:21-alpine
WORKDIR /opt
ENV PORT=8080
EXPOSE 8080
COPY --from=build /src/target/*.jar /opt/app.jar
ENTRYPOINT exec java $JAVA_OPTS -jar app.jar
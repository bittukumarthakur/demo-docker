# Single stage docker file
# Image size 599MB
#FROM openjdk:21-slim

#WORKDIR /app
#
#COPY . .
#
#RUN ./mvnw package
#
#COPY target/demo*.jar demo.jar
#CMD ["java", "-jar", "demo.jar"]
#
#EXPOSE 8080


# Multistage docker file
# Build stage
FROM openjdk:21-slim as build
WORKDIR /app
COPY . .
RUN ./mvnw package

# Slim runtime environment
FROM openjdk:21-slim
COPY --from=build /app/target/*.jar /app/demo.jar
WORKDIR /app
EXPOSE 8080
CMD ["java", "-jar", "demo.jar"]




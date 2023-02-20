
FROM openjdk:8-jdk-alpine AS build
WORKDIR /app
RUN apk add --no-cache maven
COPY . .
RUN ["mvn", "package"]
# Package stage
FROM openjdk:8-jre-alpine
WORKDIR /app
COPY --from=build /app/target/*.jar .
CMD ["java", "-jar", "eb-usermgmt-mysql-v1.jar"]

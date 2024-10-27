FROM maven:3.6.3-jdk-11-slim AS build

WORKDIR usr/src/app

COPY . ./

RUN mvn clean package -D skipTests

#
# Package stage
#

FROM openjdk:11-jre-slim

ARG JAR_NAME="loan"

WORKDIR /usr/src/app

COPY --from=build /usr/src/app/target/${JAR_NAME}.jar ./loan.jar

ENV PORT 8090

EXPOSE 80

CMD ["java","-jar", "./loan.jar"]
# Stage 1: Build Stage
FROM maven:3.8.4-openjdk-11 AS build
ENV COMPLAINT_URL=https://4f5ac991-f23a-4e1f-8497-65f31136e50f.mock.pstmn.io
WORKDIR /app
COPY pom.xml .
RUN mvn dependency:go-offline

COPY src src
RUN mvn package -DskipTests && \
    rm -rf /root/.m2 /app/target/*-sources.jar /app/target/*-javadoc.jar

# Stage 2: Runtime Stage
FROM adoptopenjdk:11-jre-hotspot-alpine
ENV COMPLAINT_URL=https://4f5ac991-f23a-4e1f-8497-65f31136e50f.mock.pstmn.io
WORKDIR /app
COPY --from=build /app/target/ComplaintAPI.jar .
ENTRYPOINT ["java", "-jar", "ComplaintAPI.jar"]

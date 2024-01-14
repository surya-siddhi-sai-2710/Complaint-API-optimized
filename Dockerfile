# Stage 1: Build Stage
FROM maven:3.8.4-openjdk-11 AS build
ENV COMPLAINT_URL=https://4f5ac991-f23a-4e1f-8497-65f31136e50f.mock.pstmn.io
WORKDIR /app
COPY . .
RUN mvn install



# Stage 2: Runtime Stage
FROM adoptopenjdk:11-jre-hotspot-bionic
ENV COMPLAINT_URL=https://4f5ac991-f23a-4e1f-8497-65f31136e50f.mock.pstmn.io
WORKDIR /app
COPY --from=build /app/target/ComplaintAPI.jar .
ENTRYPOINT ["java", "-jar", "ComplaintAPI.jar"]

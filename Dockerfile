# Build stage
FROM maven:3.8.4-openjdk-11 AS build
WORKDIR /app
COPY . /app
RUN mvn install

# Runtime stage
FROM openjdk:11-alpine
EXPOSE 8080
ENV COMPLAINT_URL=https://4f5ac991-f23a-4e1f-8497-65f31136e50f.mock.pstmn.io
WORKDIR /app
COPY --from=build /app/target/ComplaintAPI.jar /app/
ENTRYPOINT ["java", "-jar", "ComplaintAPI.jar"]

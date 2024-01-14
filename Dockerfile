 Build stage
FROM maven:3.8.4-openjdk-11 AS builder

WORKDIR /app
COPY . /app

RUN mvn install

# Runtime stage
FROM openjdk:11-jre-slim

WORKDIR /app
COPY --from=builder /app/target/ComplaintAPI.jar /app/

EXPOSE 8080

ENV COMPLAINT_URL=https://4f5ac991-f23a-4e1f-8497-65f31136e50f.mock.pstmn.io

ENTRYPOINT ["java", "-jar", "ComplaintAPI.jar"]

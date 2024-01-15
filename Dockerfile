# stage 1: build
FROM maven:3.8.4-openjdk-11 AS build
ENV COMPLAINT_URL=https://4f5ac991-f23a-4e1f-8497-65f31136e50f.mock.pstmn.io
WORKDIR /app
RUN git clone https://github.com/surya-siddhi-sai-2710/Complaint-API
COPY . .
RUN mvn install

# Stage 2: Runtime Stage
FROM registry.access.redhat.com/ubi8/openjdk-11
WORKDIR /app
# Copy only necessary artifacts from the build stage
COPY --from=build /app/target/ComplaintAPI.jar .
# Set environment variables if needed
ENV COMPLAINT_URL=https://4f5ac991-f23a-4e1f-8497-65f31136e50f.mock.pstmn.io
# Expose the port your application will run on
EXPOSE 8080
 
# Define the command to run your application
CMD ["java", "-jar", "ComplaintAPI.jar"]

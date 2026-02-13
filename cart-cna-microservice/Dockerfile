FROM openjdk:17-jdk-slim AS builder
WORKDIR /app
COPY . .
RUN apt-get update && apt-get install -y gradle && \
    gradle build -x test --quiet

FROM openjdk:17-jdk-slim
WORKDIR /app
COPY --from=builder /app/build/libs/*.jar app.jar
ENV JAVA_OPTS="-Xmx512m -Xms256m"
EXPOSE 8080
HEALTHCHECK --interval=30s --timeout=5s --start-period=10s --retries=3 \
  CMD java -jar /app/app.jar || exit 1
CMD ["java", "-jar", "app.jar"]

# SpringBoot Sandbox Application

A Spring Boot application with MongoDB integration

## Tech Stack

### Backend
- **Java 17**
- **Spring Boot 3.2.0**
  - Spring Web
  - Spring Data MongoDB
  - Actuator (for monitoring)
- **MongoDB 6.0** (Document database)

### Infrastructure
- **Docker** (Containerization)
- **Kubernetes** (Orchestration)
- **Prometheus** (Metrics collection)
- **Grafana** (Monitoring dashboards)

### CI/CD
- GitHub Actions
- Automated testing and deployment

## Application Purpose

This is a demonstration application showcasing:
- REST API development with Spring Boot
- MongoDB integration
- Containerized deployment
- Monitoring and observability
- CI/CD automation

Key features:
- Product CRUD operations
- Environment-specific configurations
- Health/metrics endpoints

## Environments

### Development
```bash
SPRING_PROFILES_ACTIVE=dev ./mvnw spring-boot:run
```

### Staging
```bash
SPRING_PROFILES_ACTIVE=staging ./mvnw spring-boot:run
```

### Production
```bash
SPRING_PROFILES_ACTIVE=prod ./mvnw spring-boot:run
```

## Running the Application

### Prerequisites
- Java 17 JDK
- Maven
- Docker
- Kubernetes cluster (for K8s deployment)

### Local Development
```bash
./mvnw spring-boot:run
```

### Docker
1. Build image:
```bash
docker build -t springboot-sandbox .
```

2. Run container:
```bash
docker run -p 8080:8080 springboot-sandbox
```

### Docker Compose
```bash
docker-compose up -d
```
Access at: http://localhost:8080

### Kubernetes
1. Apply base configuration:
```bash
kubectl apply -k k8s/base
```

2. Environment-specific deployments:
```bash
# Development
kubectl apply -k k8s/overlays/dev

# Staging
kubectl apply -k k8s/overlays/staging

# Production
kubectl apply -k k8s/overlays/prod
```

## Deployment

### Kubernetes
```bash
# Dev
kubectl apply -k k8s/overlays/dev

# Staging
kubectl apply -k k8s/overlays/staging

# Production
kubectl apply -k k8s/overlays/prod
```

### CI/CD Pipeline
- Tests run on every push
- Docker image built on main branch updates
- Kubernetes deployment on version tags

## Docker Configuration

### Updated Dockerfile
```dockerfile
# Build stage
FROM maven:3.9.6-eclipse-temurin-17 AS build
WORKDIR /app
COPY pom.xml .
COPY src ./src
RUN mvn clean package

# Runtime stage
FROM eclipse-temurin:17-jre-jammy
WORKDIR /app
COPY --from=build /app/target/*.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]
```

### Key Improvements
- Uses verified Eclipse Temurin images
- Multi-stage build for smaller final image
- Proper port exposure (8080)
- Health check endpoints included

## Monitoring Setup

### Included Dashboards
1. **Spring Boot Metrics**
   - JVM memory/CPU usage
   - HTTP request rates/latency
   - Thread pool metrics

2. **MongoDB Dashboard**
   - Query operations
   - Connection stats
   - Document CRUD rates

### Access Metrics
```bash
# Prometheus
http://localhost:9090

# Grafana
http://localhost:3000 (admin/admin)
```

## Monitoring

The application comes with built-in monitoring:

### Access Dashboards
```bash
# Prometheus (metrics)
minikube service prometheus -n monitoring

# Grafana (dashboards)
minikube service grafana -n monitoring
```

### Metrics Endpoints
- `/actuator/health` - Application health
- `/actuator/prometheus` - Prometheus metrics

## CI/CD Pipeline

The GitHub Actions workflow provides:
1. Automated testing on every push
2. Docker image building on main branch updates
3. Staging deployment on tag creation
4. Production deployment (manual approval)

## Configuration

Environment-specific configs in:
- `application-dev.yaml`
- `application-staging.yaml`
- `application-prod.yaml`

All configurations use YAML format for consistency.

## Troubleshooting

### Common Issues
1. **Port conflicts**: Check if ports 8080/27017 are free
2. **MongoDB connection**: Wait for MongoDB to initialize
3. **Build failures**: Clean build with `docker system prune`

### Useful Commands
```bash
# View logs
docker-compose logs -f

# Restart services
docker-compose restart

# Clean up
docker system prune

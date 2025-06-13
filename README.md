# SpringBoot Sandbox

A Spring Boot application with MongoDB integration

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

## Configuration
- All configurations in YAML
- Environment-specific files:
  - `application-dev.yaml`
  - `application-staging.yaml`
  - `application-prod.yaml`

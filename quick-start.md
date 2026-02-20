# 🚀 Quick Start Guide

This guide will help you get the Scalable E-Commerce Microservices platform up and running quickly on your local machine using two primary methods: **Docker Compose** for a simple local development setup, and **Kubernetes with Kind** for simulating a production-like environment.

---

## 📋 Prerequisites

Before you begin, ensure you have the following tools installed on your system:

### **For Docker Compose Setup**

-   **Git**: For cloning the repository.
-   **Docker Desktop** (or Docker Engine + Docker Compose):
    -   Docker version 24.0+
    -   Docker Compose version 2.20+
    -   [Install Docker Desktop](https://docs.docker.com/get-docker/)

### **For Kubernetes with Kind Setup**

-   All prerequisites for Docker Compose setup.
-   **kubectl**: Kubernetes command-line tool.
    -   Version 1.28+
    -   [Install kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/)
-   **Helm**: Kubernetes package manager.
    -   Version 3.12+
    -   [Install Helm](https://helm.sh/docs/intro/install/)
-   **Istioctl**: Istio command-line tool.
    -   Version 1.20+
    -   [Install Istioctl](https://istio.io/latest/docs/setup/getting-started/install-istio/#download-and-install)
-   **Kind**: Kubernetes in Docker for local clusters.
    -   [Install Kind](https://kind.sigs.k8s.io/docs/user/quick-start/#installation)

---

## 🔥 **Getting Started (Choose Your Option)**

### **Option A: Docker Compose (Local Development - Recommended for Simplicity)**

This option uses Docker Compose to spin up all services and their dependencies locally. It's the fastest way to start developing and testing the application.

1.  **Clone the Repository**:
    ```bash
    git clone https://github.com/Rishikesh-991/scalable-ecommerce-microservices.git
    cd scalable-ecommerce-microservices
    ```

2.  **Create Environment File**:
    Copy the example environment variables to `.env` in the root directory. You might need to adjust some values later, especially for sensitive data.
    ```bash
    cp .env.production .env
    # You can open .env in your editor to review or modify values
    # nano .env
    ```

3.  **Start All Services**:
    Build the Docker images for all microservices and start them along with their databases (PostgreSQL, MongoDB, Redis, Elasticsearch) and monitoring tools (Prometheus, Grafana).
    ```bash
    docker-compose up -d --build
    ```
    *The `--build` flag ensures that the latest code changes are built into the images.*

4.  **Verify Service Health**:
    Run the provided script to check if all core databases are running and accessible.
    ```bash
    chmod +x DATABASE_VERIFICATION.sh
    ./DATABASE_VERIFICATION.sh
    ```
    Also, check the status of all Docker containers:
    ```bash
    docker-compose ps
    ```

5.  **Access the Application**:
    Once all services are up and healthy, you can access the application components:
    *   **Frontend**: [http://localhost:3000](http://localhost:3000)
    *   **Products Service**: [http://localhost:5000/health](http://localhost:5000/health)
    *   **Cart Service**: [http://localhost:8080/actuator/health](http://localhost:8080/actuator/health)
    *   **Users Service**: [http://localhost:9090/health](http://localhost:9090/health)
    *   **Search Service**: [http://localhost:4000/health](http://localhost:4000/health)
    *   **Grafana Dashboard**: [http://localhost:3030](http://localhost:3030) (Default credentials: `admin` / `admin`)
    *   **Prometheus**: [http://localhost:9090](http://localhost:9090)

---

### **Option B: Kubernetes with Kind (Local Kubernetes Cluster - Simulating Production)**

This option sets up a local Kubernetes cluster using Kind, installs Istio as a service mesh, and then deploys the microservices using Helm charts. This is ideal for testing Kubernetes-specific features, Istio configurations, and a production-like environment.

1.  **Clone the Repository**:
    ```bash
    git clone https://github.com/Rishikesh-991/scalable-ecommerce-microservices.git
    cd scalable-ecommerce-microservices
    ```

2.  **Create Local Kubernetes Cluster (Kind)**:
    This script will create a Kind cluster named `ecommerce-cluster`.
    ```bash
    cd k8s/scripts
    chmod +x setup-kind-cluster.sh
    ./setup-kind-cluster.sh
    ```

3.  **Install Istio Service Mesh**:
    Deploy the Istio control plane and related components to your Kind cluster.
    ```bash
    chmod +x install-istio.sh
    ./install-istio.sh
    ```

4.  **Deploy All Microservices**:
    Deploy all the e-commerce microservices, databases, and monitoring components using their respective Helm charts. This script uses `values-dev.yaml` for development configurations.
    ```bash
    chmod +x deploy-dev.sh
    ./deploy-dev.sh
    ```

5.  **Verify Deployment**:
    Check the status of all pods and services in the `ecommerce` namespace.
    ```bash
    kubectl get all -n ecommerce
    kubectl get gateway,virtualservice -n ecommerce
    ```
    Wait until all pods show `Running` or `Completed` status. You can watch the deployment progress:
    ```bash
    kubectl get pods -n ecommerce -w
    ```

6.  **Access the Application**:
    Since services are deployed in Kubernetes, you need to use `kubectl port-forward` to access them from your local machine.

    *   **Frontend**:
        ```bash
        kubectl port-forward svc/frontend 3000:80 -n ecommerce
        # Access: http://localhost:3000
        ```
    *   **Istio Ingress Gateway**: (For accessing services via Istio)
        ```bash
        kubectl port-forward svc/istio-ingressgateway 8080:80 -n istio-system
        # Access: http://localhost:8080 (then navigate to API paths, e.g., http://localhost:8080/api/products)
        ```
    *   **Grafana Dashboard**:
        ```bash
        chmod +x port-forward-monitoring.sh
        ./port-forward-monitoring.sh # This script will port-forward Grafana and Prometheus
        # Access Grafana: http://localhost:3030 (Default credentials: admin/admin)
        # Access Prometheus: http://localhost:9090
        ```

    *(Note: You'll need to keep the `kubectl port-forward` commands running in separate terminal tabs to maintain access.)*

---

## 🛠️ Troubleshooting

Here are common issues and their solutions:

<details>
<summary>❌ **Port already in use**</summary>

If you see errors like `Error: listen EADDRINUSE: address already in use :::3000`, another process is using the required port.

**Solution:**
1.  **Find the process:**
    ```bash
    # For port 3000 (replace with the conflicting port)
    sudo lsof -i :3000
    ```
2.  **Kill the process (use with caution):**
    ```bash
    # Replace <PID> with the Process ID from the lsof output
    kill -9 <PID>
    ```
3.  **Alternatively, change the port:**
    Modify the `ports` mapping in `docker-compose.yml` or the `Service` definition in Kubernetes Helm charts if you need to use a different port.
</details>

<details>
<summary>❌ **Database connection errors**</summary>

If services fail to connect to their databases (PostgreSQL, MongoDB, Redis, Elasticsearch):

**Solution (Docker Compose):**
1.  **Check container status:** Ensure database containers are running and healthy.
    ```bash
    docker-compose ps
    ```
2.  **View database logs:** Look for error messages during startup.
    ```bash
    docker-compose logs postgres  # Or mongodb, redis, elasticsearch
    ```
3.  **Reset databases (⚠️ This will delete all data):**
    ```bash
    docker-compose down -v --rmi all
    docker-compose up -d --build
    ```
4.  **Verify environment variables:** Double-check that `DB_HOST`, `REDIS_HOST`, etc., in your service's `.env` or `docker-compose.yml` point to the correct service names (e.g., `postgres`, `redis`).

**Solution (Kubernetes Kind):**
1.  **Check pod status:**
    ```bash
    kubectl get pods -n ecommerce
    ```
2.  **View pod logs:**
    ```bash
    kubectl logs -f <database-pod-name> -n ecommerce
    ```
3.  **Check ConfigMaps and Secrets:** Ensure database credentials are correctly passed to your service pods.
    ```bash
    kubectl get configmap <your-configmap-name> -o yaml -n ecommerce
    kubectl get secret <your-secret-name> -o yaml -n ecommerce
    ```
</details>

<details>
<summary>❌ **Microservice containers/pods are crashing or not starting**</summary>

**Solution (Docker Compose):**
1.  **Check logs:** The most common first step.
    ```bash
    docker-compose logs -f <service-name>
    ```
2.  **Check build errors:** If `--build` was used, there might be errors during image creation.
    ```bash
    docker-compose build <service-name>
    ```
3.  **Dependency issues:** Ensure all `npm install` (Node.js), `pip install` (Python), `gradle build` (Java) commands completed successfully during the Docker build.

**Solution (Kubernetes Kind):**
1.  **Check pod status:** Look for `CrashLoopBackOff` or `Pending` states.
    ```bash
    kubectl get pods -n ecommerce
    ```
2.  **View pod logs:**
    ```bash
    kubectl logs -f <pod-name> -n ecommerce
    ```
3.  **Describe pod:** This provides detailed events and configuration.
    ```bash
    kubectl describe pod <pod-name> -n ecommerce
    ```
    Look for:
    *   **Events**: Common issues include image pull errors, failed probes, OOMKilled.
    *   **Environment Variables**: Ensure `ConfigMap` and `Secret` values are correctly mounted.
    *   **Resource Limits**: Pods might be requesting more resources than available on your Kind cluster.
4.  **Check `kubectl get events -n ecommerce`**: Provides a timeline of events in the namespace.
</details>

<details>
<summary>❌ **Frontend cannot connect to backend services**</summary>

**Solution (Docker Compose):**
1.  Ensure all backend services are running (`docker-compose ps`).
2.  Verify `REACT_APP_USERS_API`, `REACT_APP_PRODUCTS_API`, etc. in `store-ui/.env.development.local` point to the correct Docker service names or `localhost` if running outside Docker. The `docker-compose.yml` should handle inter-service communication via service names.

**Solution (Kubernetes Kind):**
1.  Ensure the Istio Ingress Gateway is correctly configured and port-forwarded.
2.  Check the `VirtualService` definitions in `k8s/istio/virtual-services.yaml` to ensure they correctly route traffic to your backend services.
3.  Verify the `nginx.conf` in `store-ui` (if used for API proxying) correctly points to the Istio Gateway's internal service name.
</details>

---

## ▶️ Next Steps

Once you have the application running, explore these resources:

*   **API Reference**: See the [API Reference](/README.md#api-reference) section in the main README for detailed endpoint documentation.
*   **Monitoring**: Dive into [Grafana Dashboards](/README.md#grafana-dashboards) and [Prometheus Metrics](/README.md#prometheus-metrics) to observe the system's health and performance.
*   **Development**: Learn how to contribute and develop new features in the [Development Guide](./development-guide.md).
*   **Architecture**: Understand the system's design principles in the [Architecture Overview](./architecture/overview.md) and [Diagrams](./architecture/diagrams.md).

---
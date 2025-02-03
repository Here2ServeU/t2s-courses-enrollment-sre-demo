# T2S Course Enrollment SRE Demo

This repository demonstrates **Site Reliability Engineering (SRE) best practices** for deploying a **T2S Course Enrollment Website** using:

- **Terraform (IaC)**
- **Kubernetes (ECS, EKS)**
- **CI/CD (GitHub Actions, ArgoCD)**
- **Monitoring & Observability (Prometheus, Grafana, ELK)**
- **Incident Management (PagerDuty)**
- **Security (Trivy, AWS WAF)**
- **Chaos Engineering (Gremlin)**
- **Performance Testing (k6)**

---
This project helps with the following:

- **Multi-Region Hosting**: S3 + CloudFront CDN ensures content delivery worldwide.
- **Multi-Tenancy Support**: Each instructor gets a separate database schema on RDS.
- **Observability at Scale**: Prometheus & OpenTelemetry Tracing ensure smooth operation.
- **Security Compliance**: Trivy Security Scans + AWS Shield protect against threats.

---
## Use Cases: 

| Use Cases                            | Features Used                               |
| -----------------------------------  | ------------------------------------------- |
| **Scalable Online Learning**         | ECS, S3 + CloudFront, Gremlin, k6           |
| **Automated CI/CD Deployments**      | GitHub Actions, ArgoCD, Terraform, ELK      |
| **Secure Payment & Enrollment**      | IAM Roles, RDS, Grafana Dashboards          |
| **University Course Management**     | ELK Stack, OpenTelemetry                    |
| **Corporate IT Training**            | SSO with Cognito, CloudWatch Metrics, ALB   |
| **Government Certification Portal**  | Compliance, Auditing, Auto-scaling          |
| **Global EdTech Startup**            | Multi-Region S3, OpenTelemetry, AWS Shield  |

---

## Deployment Instructions

1. **Initialize Terraform & Deploy Infrastructure**

   ```sh
   cd terraform/environments/dev/
   terraform init
   terraform apply -auto-approve
   ```

2. **Deploy Application on Kubernetes**

   ```sh
   kubectl apply -f kubernetes/deployments/
   kubectl apply -f kubernetes/services/
   ```

3. **Configure CI/CD (GitHub Actions + ArgoCD)**

   ```sh
   kubectl apply -f ci-cd/argocd/argocd-app.yaml
   ```

4. **Enable Monitoring & Logging**

   ```sh
   kubectl apply -f monitoring/prometheus/prometheus-config.yaml
   docker-compose -f logging/elk/elk-docker-compose.yml up -d
   ```

5. **Configure Incident Management (PagerDuty)**

   ```sh
   sh incident-management/pagerduty/cloudwatch-pagerduty-setup.sh
   ```

6. **Run Security & Compliance Checks**

   ```sh
   sh security/trivy/trivy-scan.sh
   sh security/aws-waf/waf-setup.sh
   ```

7. **Execute Chaos Engineering Tests**

   ```sh
   sh chaos-engineering/gremlin/gremlin-cpu-attack.sh
   ```

8. **Perform Performance Testing**
   ```sh
   k6 run performance-testing/k6/load-test.js
   ```

## Summary of Tools Used

| SRE Domain        | Tool Used                       |
| ----------------- | ------------------------------- |
| **IaC**           | Terraform                       |
| **CI/CD**         | GitHub Actions, ArgoCD          |
| **Monitoring**    | Prometheus, Grafana, CloudWatch |
| **Logging**       | ELK Stack, OpenTelemetry        |
| **Incident Mgmt** | PagerDuty                       |
| **Security**      | AWS WAF, Trivy                  |
| **Chaos**         | Gremlin                         |
| **Performance**   | k6                              |

---

**Next Step:** Upload this repository to GitHub and start deploying!

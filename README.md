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
## Prerequisites 

- Docker installed. 
- Kubernetes installed. 

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
   minikube start # To start Kubernetes
   cd ../../..
   kubectl apply -f kubernetes/deployments/
   kubectl apply -f kubernetes/services/
   ```

3. **Configure CI/CD (GitHub Actions + ArgoCD)**

   ```sh
   # Create a Namespace and name it argocd
   kubectl create namespace argocd
   
   # Install ArgoCD and CRDs
   kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
   kubectl apply -f ci-cd/argocd/argocd-app.yaml
   ```

4. **Enable Monitoring & Logging**

   ```sh
   kubectl create namespace monitoring  # To create a namespace "monitoring"
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


---
## Clean Up

- Cleanup Instructions for T2S Course Enrollment SRE Demo

- If you want to tear down all the resources created during the deployment, follow these steps in order:

### Destroy Infrastructure (Terraform)

- Run the following command to remove all AWS resources provisioned by Terraform:
```bash
cd terraform/environments/dev/
terraform destroy -auto-approve
```

- Repeat the above command for stage and prod environments if they were deployed:
```bash
cd terraform/environments/stage/
terraform destroy -auto-approve

cd terraform/environments/prod/
terraform destroy -auto-approve
```

- This will delete all AWS infrastructure, including EC2, RDS, S3, CloudFront, IAM roles, and VPC.

### Remove Kubernetes Resources

- To delete all Kubernetes Deployments, Services, and Configurations, run:
```bash
kubectl delete -f kubernetes/deployments/
kubectl delete -f kubernetes/services/
kubectl delete namespace monitoring
kubectl delete namespace argocd
kubectl delete namespace chaos-testing
```

- This removes all Pods, Deployments, Services, and Namespaces used in the project.

### Uninstall ArgoCD

- If you installed ArgoCD, uninstall it with:
```bash
kubectl delete -n argocd -f ci-cd/argocd/argocd-app.yaml
kubectl delete namespace argocd
```

- This removes ArgoCD applications and namespace.

### Stop Monitoring & Logging Services

- To stop Prometheus, Grafana, and ELK Stack, run:
```bash
kubectl delete -f monitoring/prometheus/prometheus-config.yaml
docker-compose -f logging/elk/elk-docker-compose.yml down
```
- This will shutdown all logging & monitoring services.

### Remove Incident Management Configuration (PagerDuty)

- If you integrated PagerDuty, remove the AWS SNS subscription:
```bash
aws sns delete-topic --topic-arn arn:aws:sns:us-east-1:730335276920:PagerDutyAlerts
```
- This removes SNS integration with PagerDuty.

### Delete Security & Compliance Configurations

- Remove Trivy Security Scans and AWS WAF rules:
```bash
sh security/trivy/trivy-cleanup.sh
sh security/aws-waf/waf-delete.sh
```

- This removes all security scanning configurations.

### Stop Chaos Engineering & Performance Testing

- Clean up Gremlin Chaos Tests:
```bash
sh chaos-engineering/gremlin/gremlin-stop-all.sh
```

### Stop k6 performance tests:
```bash
pkill k6
```
- This ensures no chaos or performance tests are running.

### Remove Docker Containers (If Used)

- If you used Docker for local testing, clean up all containers, volumes, and networks:
```bash
docker-compose -f logging/elk/elk-docker-compose.yml down --volumes --remove-orphans
docker system prune -af
```
- This cleans up all Docker resources.

### Verify All Resources Are Deleted

- Run the following checks to ensure nothing is left:
```bash
kubectl get all --all-namespaces
terraform state list  # Ensure all resources are removed
aws ec2 describe-instances --filters "Name=tag:Project,Values=T2S-SRE-Demo"
aws s3 ls | grep t2s-course  # Check for any remaining S3 buckets
aws rds describe-db-instances
```

- If anything remains, manually delete those resources.

### Final Cleanup

If you want to completely remove everything, including local Terraform and Kubernetes files, run:
```bash
rm -rf terraform/.terraform
rm -rf terraform/environments/dev/.terraform*
rm -rf terraform/environments/stage/.terraform*
rm -rf terraform/environments/prod/.terraform*
rm -rf ~/.kube/config
```
At this point, all resources should be fully cleaned up.

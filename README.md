# Docker and Automation with Jenkins

![Docker](https://img.shields.io/badge/Docker-Containerized-blue)
![CI/CD](https://img.shields.io/badge/CI%2FCD-Jenkins-success)
![AWS](https://img.shields.io/badge/AWS-S3-orange)
![MySQL](https://img.shields.io/badge/Database-MySQL-blue)
![Nginx](https://img.shields.io/badge/Web-Nginx-green)

A production-ready **Docker-based DevOps project** that demonstrates container orchestration, CI/CD automation, MySQL backups to AWS S3, traffic monitoring, and service health checks.

---

## 📌 Project Overview

This project provides a **complete DevOps environment** using Docker to run a PHP web application backed by MySQL and served via Nginx.  
It integrates **Jenkins CI/CD**, **automated MySQL backups to Amazon S3**, and **Bash scripts** for monitoring and maintenance.

The goal of this assignment is to showcase **real-world DevOps practices** rather than just containerization.

---

## 🏗️ Architecture

```

Client
|
v
Nginx (Web Server)
|
v
PHP Application
|
v
MySQL Database
|
v
Automated Backup Script
|
v
AWS S3 Bucket

````

---

## 🚀 Key Features

- **Multi-Container Docker Setup**
  - Nginx, PHP, MySQL, phpMyAdmin
- **CI/CD Pipeline**
  - Jenkins automation for build and deployment
- **Database Backup Automation**
  - MySQL backups with compression
  - Uploads securely to AWS S3
- **Traffic Monitoring**
  - Access log analysis using Bash scripts
- **Health Checks**
  - PHP-based health verification endpoints
- **Environment Agnostic**
  - Works on Linux, macOS, and Windows (Git Bash)

---



## 📋 Prerequisites

Ensure the following are installed:

- Docker & Docker Compose
- Bash Shell
- AWS CLI (configured)
- Git

Verify installations:

```bash
docker --version
aws --version
````

---

## 📦 Installation

### 1️⃣ Clone the Repository

```bash
git clone https://github.com/Rajpootss001/devops-docker-assignment.git
cd devops-docker-assignment
```

---

### 2️⃣ Build and Start Containers

```bash
docker compose up -d
```

---

### 3️⃣ Verify Running Containers

```bash
docker ps
```

---

## ▶️ Usage

| Service         | URL                                            |
| --------------- | ---------------------------------------------- |
| Jenkins         | [http://localhost:8080](http://localhost:8080) |
| phpMyAdmin      | [http://localhost:8081](http://localhost:8081) |
| Nginx           | [http://localhost:80](http://localhost:80) |

---

## 🗄️ MySQL Backup to AWS S3

A Bash script automates:

1. Database validation
2. MySQL dump creation
3. Gzip compression
4. Upload to AWS S3

### Run Backup Script

```bash
chmod +x mysql_backup_s3.sh
./mysql_backup_s3.sh
```

### Backup Naming Format

```
testdb_YYYY-MM-DD_HH-MM-SS.sql.gz
```

---

## ⏱️ Cron Automation (Optional)

Schedule daily backups:

```bash
0 2 * * * /path/mysql_backup_s3.sh >> backup.log 2>&1
```

---

## 🧪 Testing

Basic tests ensure container health and service availability.

```bash
./tests/run_tests.sh
```

---


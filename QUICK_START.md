Guide READMEs in a clean format:

# Scalable E-Commerce Microservices

---

## 1️⃣ Developer Quickstart

### Prerequisites
- Docker >= 20.x
- Docker Compose >= 2.x
- Node.js >= 18.x
- npm >= 9.x
- Python >= 3.11
- Java >= 17

### Clone & Setup
```bash
git clone https://github.com/Rishikesh-991/scalable-ecommerce-microservices.git
cd scalable-ecommerce-microservices
cp .env.production.example .env.production
export $(cat .env.production | xargs)

Start Services (Docker)
docker-compose up -d
docker-compose ps

Start Microservices

Products Service:

cd products-cna-microservice && npm install && npm start


Cart Service:

cd cart-cna-microservice && gradle bootRun


Users Service:

cd users-cna-microservice && pipenv install && pipenv shell && python app.py


Frontend:

cd store-ui && npm install && npm start

Verify
curl http://localhost:5000/
curl http://localhost:8080/
curl http://localhost:9090/docs


Frontend Access: http://localhost:3000

Useful Commands

Stop all services:

docker-compose down


View logs:

docker-compose logs -f <service_name>


Rebuild Docker images:

docker-compose build --no-cache


✅ 1-page, developer-focused, fast for onboarding engineers.

2️⃣ User Guide
Overview

This is a web-based e-commerce platform with:

Browse products

Add to cart

Checkout via Stripe (test mode)

User management (signup/login)

Access

Frontend URL: http://localhost:3000

API Docs (Users Service): http://localhost:9090/docs

Quick Start

Open Frontend
Navigate to http://localhost:3000

Create Account / Login
Signup with email/password

Browse Products
View product catalog and use search if needed

Add to Cart
Select quantity and add items

Checkout
Use Stripe test cards:

4242 4242 4242 4242 → success

4000 0000 0000 0002 → declined

View Orders
Check order status on dashboard

Notes

Platform runs in local test mode

No real payments will be processed

User data is stored in PostgreSQL (local Docker)

Support

Contact: rishikeshkourav991@gmail.com

Repository: GitHub

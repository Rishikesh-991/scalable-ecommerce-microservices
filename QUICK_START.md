1️⃣ Developer Quickstart README
# Scalable E-Commerce Microservices - Quickstart

## Prerequisites
- Docker >= 20.x
- Docker Compose >= 2.x
- Node.js >= 18.x
- npm >= 9.x
- Python >= 3.11
- Java >= 17

## Clone & Setup
```bash
git clone https://github.com/Rishikesh-991/scalable-ecommerce-microservices.git
cd scalable-ecommerce-microservices
cp .env.production.example .env.production
export $(cat .env.production | xargs)

Start Services (Docker)
docker-compose up -d
docker-compose ps

Start Microservices

Products Service: cd products-cna-microservice && npm install && npm start

Cart Service: cd cart-cna-microservice && gradle bootRun

Users Service: cd users-cna-microservice && pipenv install && pipenv shell && python app.py

Frontend: cd store-ui && npm install && npm start

Verify
curl http://localhost:5000/
curl http://localhost:8080/
curl http://localhost:9090/docs


Frontend: http://localhost:3000

Useful Commands

Stop all services: docker-compose down

Logs: docker-compose logs -f <service_name>

Rebuild Docker images: docker-compose build --no-cache


✅ This is **1-page, developer-focused**, fast for onboarding engineers.  

---

# 2️⃣ User Guide README

```markdown
# Scalable E-Commerce Platform - User Guide

## Overview
This is a web-based e-commerce platform with:
- Browse products
- Add to cart
- Checkout via Stripe (test)
- User management (signup/login)

## Access
- Frontend URL: http://localhost:3000
- API Docs (Users Service): http://localhost:9090/docs

## Quick Start
1. **Open Frontend**
   - Navigate to [http://localhost:3000](http://localhost:3000)
2. **Create Account / Login**
   - Signup with email/password
3. **Browse Products**
   - View product catalog
   - Use search if needed
4. **Add to Cart**
   - Select quantity and add items
5. **Checkout**
   - Use Stripe test cards:
     - `4242 4242 4242 4242` → success
     - `4000 0000 0000 0002` → declined
6. **View Orders**
   - Check order status on dashboard

## Notes
- Platform is running in **local test mode**
- No real payments will be processed
- User data is stored in PostgreSQL (local Docker)

## Support
- Contact: `rishikesh@example.com`
- Repo: [GitHub](https://github.com/Rishikesh-991/scalable-ecommerce-microservices)


✅ This is user-friendly, minimal, and avoids technical setup details.

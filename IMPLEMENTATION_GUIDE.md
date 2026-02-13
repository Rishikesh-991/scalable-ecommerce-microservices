# E-Commerce Microservices - Implementation Guide

**Date:** February 13, 2026  
**Current Status:** Development Phase with Infrastructure Setup  
**Production Readiness:** In Progress (Target: 8-12 weeks)

---

## TABLE OF CONTENTS
1. [System Overview](#system-overview)
2. [Changes Implemented](#changes-implemented)
3. [Infrastructure Setup](#infrastructure-setup)
4. [Running Services Locally](#running-services-locally)
5. [AWS EC2 Deployment & Port Forwarding](#aws-ec2-deployment--port-forwarding)
6. [API Documentation](#api-documentation)
7. [Event-Driven Architecture](#event-driven-architecture)
8. [Payment Integration](#payment-integration)
9. [Testing & Validation](#testing--validation)
10. [Troubleshooting](#troubleshooting)

---

## SYSTEM OVERVIEW

### Architecture
```
┌─────────────────────────────────────────┐
│    Frontend (React App - Port 3000)     │
│    Material-UI, TypeScript              │
└────────────────┬────────────────────────┘
                 │
    ┌────────────┼────────────┐
    │            │            │
┌───▼──────┐ ┌──▼──────┐ ┌──▼──────┐
│  Products│ │  Cart   │ │  Search │
│ (5000)   │ │ (8080)  │ │ (4000)  │
└───┬──────┘ └──┬──────┘ └──┬──────┘
    │           │           │
┌───▼──────┐ ┌──▼──────┐ ┌──▼──────┐
│ MongoDB  │ │  Redis  │ │Elastic  │
│          │ │         │ │Search   │
└──────────┘ └─────────┘ └─────────┘

    ┌─────────────────────┐
    │  Users (9090)       │
    │  FastAPI/Python     │
    └────────┬────────────┘
             │
        ┌────▼────────┐
        │ PostgreSQL  │
        └─────────────┘

    ┌──────────────────────────┐
    │  Auth Service (8081)     │
    │  JWT Token Management    │
    └──────────────────────────┘

    ┌──────────────────────────┐
    │  Payment Service (8082)  │
    │  Stripe Integration      │
    └──────────────────────────┘

    ┌──────────────────────────┐
    │  RabbitMQ (5672)         │
    │  Event-Driven Bus        │
    └──────────────────────────┘
```

### Services
| Service | Type | Port | Tech | DB | Status |
|---------|------|------|------|-------|---------|
| Products | Node.js/Express | 5000 | Express | MongoDB | ✅ Running |
| Cart | Java/Spring Boot | 8080 | Spring Webflux | Redis | ✅ Running |
| Search | Node.js Proxy | 4000 | Express | Elasticsearch | ⏳ Setup needed |
| Users | Python/FastAPI | 9090 | FastAPI | PostgreSQL | ✅ Running |
| Auth | Spring Boot | 8081 | Spring Security + JWT | - | 🆕 New |
| Payments | Node.js | 8082 | Express + Stripe | - | 🆕 New |
| Frontend | React | 3000 | React/TypeScript | - | ✅ Ready |

---

## CHANGES IMPLEMENTED

### 1. Infrastructure Improvements ✅

#### Docker Compose Setup
- ✅ Created `docker-compose.yml` with all services
- ✅ MongoDB 5.0 with authentication
- ✅ Redis 7 with password protection
- ✅ PostgreSQL 15 configured
- ✅ RabbitMQ 3.12 with management UI
- ✅ Health checks for all services
- ✅ Named volumes for data persistence
- ✅ Network isolation

**Start Databases:**
\`\`\`bash
cd /home/ubuntu/scalable-ecommerce-microservices
docker-compose up -d
docker-compose ps
\`\`\`

**Connection Strings:**
- MongoDB: \`mongodb://admin:admin123@localhost:27017/ecommerce?authSource=admin\`
- Redis: \`redis://:redis123@localhost:6379\`
- PostgreSQL: \`postgresql://admin:admin123@localhost:5432/ecommerce\`
- RabbitMQ: \`amqp://admin:admin123@localhost:5672\`
- RabbitMQ UI: http://localhost:15672 (admin/admin123)

### 2. Environment Configuration ✅
- ✅ Created `.env.production` with all service configurations
- ✅ Centralized environment variables
- ✅ JWT & Security settings
- ✅ Stripe test keys (testing payment)
- ✅ CORS configuration

### 3. Security Improvements 🚧

#### Authentication Service (To be deployed)
New Spring Boot service for JWT-based auth:
- User login/registration
- JWT token generation & validation
- Refresh token handling
- Multi-factor authentication (Phase 2)

**Endpoints:**
\`\`\`
POST   /auth/register
POST   /auth/login
POST   /auth/refresh
POST   /auth/logout
GET    /auth/verify
\`\`\`

#### Input Validation (To be added)
- Spring Validation for Java services
- Express-validator for Node.js services
- Pydantic for Python services
- React client-side validation

### 4. Payment Integration 🆕

#### Stripe Testing Setup
- ✅ Test API keys configured in `.env.production`
- ✅ Payment Service placeholder (Port 8082)
- ✅ Test card: 4242-4242-4242-4242 (exp: 12/25, CVC: 123)

**Payment Flow:**
\`\`\`
1. User adds items to cart
2. Navigates to checkout
3. Frontend calls POST /payments/create-intent
4. Backend creates Stripe PaymentIntent
5. Frontend uses Stripe.js to complete payment
6. Webhook confirms payment
7. Order created in database
\`\`\`

### 5. Event-Driven Architecture 🆕

#### RabbitMQ Integration
Event topics/queues:
- \`order.created\` - New order placed
- \`order.confirmed\` - Payment confirmed
- \`inventory.updated\` - Stock level changed
- \`user.registered\` - New user signed up
- \`payment.completed\` - Payment successful

**Services Subscribe To:**
- Products Service → \`inventory.updated\`
- Notifications Service → \`order.created\`, \`order.confirmed\`
- Users Service → \`user.registered\`

---

## INFRASTRUCTURE SETUP

### Prerequisites
\`\`\`bash
- Docker (28.2.2+)
- Docker-compose (1.29.2+)
- Java 17 (for Cart service)
- Node.js 18+ (for Products, Search, Payment services)
- Python 3.10+ (for Users service)
- Git
\`\`\`

### Step 1: Clone Repository
\`\`\`bash
cd /home/ubuntu
git clone <repo-url> scalable-ecommerce-microservices
cd scalable-ecommerce-microservices
\`\`\`

### Step 2: Start Databases
\`\`\`bash
# Start all containers
docker-compose up -d

# Verify all services are running
docker-compose ps

# Expected output:
# ✅ ecommerce_mongodb    Up (healthy)
# ✅ ecommerce_redis      Up (healthy)
# ✅ ecommerce_postgres   Up (healthy)
# ✅ ecommerce_rabbitmq   Up (healthy)
# ⏳ ecommerce_elasticsearch (optional - resource constraint)
\`\`\`

### Step 3: Load Environment Variables
\`\`\`bash
# For development
export $(cat .env.production | xargs)

# Or in each service directory:
cd products-cna-microservice
export $(cat .env | xargs)
\`\`\`

### Step 4: Verify Database Connections
\`\`\`bash
# MongoDB
mongosh "mongodb://admin:admin123@localhost:27017/ecommerce?authSource=admin"
> show databases
> use ecommerce
> db.createCollection("test")
> db.test.drop()

# Redis
redis-cli -h localhost -p 6379 -a redis123
> ping
> CONFIG GET "*"

# PostgreSQL
psql -h localhost -U admin -d ecommerce
> SELECT version();
> \\l (list databases)

# RabbitMQ Web UI
# Visit: http://localhost:15672
# Login: admin / admin123
\`\`\`

---

## RUNNING SERVICES LOCALLY

### Option A: Run Individual Services

#### 1. Products Service (Node.js - Port 5000)
\`\`\`bash
cd products-cna-microservice

# Install dependencies
npm install

# Set environment variables
export MONGO_URI="mongodb://admin:admin123@localhost:27017/ecommerce?authSource=admin"
export DATABASE="ecommerce"
export PORT=5000

# Run
npm start
# OR with auto-reload
npm run dev  # (if available)
\`\`\`

#### 2. Cart Service (Spring Boot - Port 8080)
\`\`\`bash
cd cart-cna-microservice

# Set environment variables
export SPRING_REDIS_HOST=localhost
export SPRING_REDIS_PORT=6379
export SPRING_REDIS_PASSWORD=redis123

# Build
gradle build

# Run
gradle bootRun
# OR
java -jar build/libs/cart-1.0.0.jar
\`\`\`

#### 3. Users Service (Python - Port 9090)
\`\`\`bash
cd users-cna-microservice

# Install pipenv
pip install pipenv

# Install dependencies
pipenv install

# Run shell to activate venv
pipenv shell

# Set environment variables
export DATABASE_URL="postgresql://admin:admin123@localhost:5432/ecommerce"
export PYTHONUNBUFFERED=1

# Run
python app.py
# OR with auto-reload
uvicorn app:app --reload --host 0.0.0.0 --port 9090
\`\`\`

#### 4. Search Service (Proxy - Port 4000)
\`\`\`bash
cd search-cna-microservice

npm install
export ELASTIC_URL="http://localhost:9200"
export PORT=4000

npm start
\`\`\`

#### 5. Frontend (React - Port 3000)
\`\`\`bash
cd store-ui

npm install

# Create .env.local
cat > .env.local << EOF
REACT_APP_PRODCUTS_URL_BASE=http://localhost:5000/
REACT_APP_CART_URL_BASE=http://localhost:8080/
REACT_APP_USERS_URL_BASE=http://localhost:9090/
REACT_APP_SEARCH_URL_BASE=http://localhost:4000/
EOF

npm start
# Opens http://localhost:3000
\`\`\`

### Option B: Run All Services with Docker Compose (Recommended)

Create `docker-compose.services.yml`:

\`\`\`bash
# Add to docker-compose.yml after databases section
# TODO: Services configuration in progress
\`\`\`

---

## AWS EC2 DEPLOYMENT & PORT FORWARDING

### Important for EC2 Users ⚠️

When running on EC2, you need to handle port forwarding if accessing from local machine:

### Method 1: SSH Port Forwarding

\`\`\`bash
# On your LOCAL machine:
# Forward EC2 ports to localhost

# Products
ssh -i your-key.pem -L 5000:localhost:5000 ubuntu@EC2_IP_ADDRESS

# In separate terminals:
ssh -i your-key.pem -L 27017:localhost:27017 ubuntu@EC2_IP_ADDRESS  # MongoDB
ssh -i your-key.pem -L 6379:localhost:6379 ubuntu@EC2_IP_ADDRESS   # Redis
ssh -i your-key.pem -L 5432:localhost:5432 ubuntu@EC2_IP_ADDRESS   # PostgreSQL
ssh -i your-key.pem -L 3000:localhost:3000 ubuntu@EC2_IP_ADDRESS   # Frontend
\`\`\`

### Method 2: EC2 Security Group Rules

In AWS Console:

1. Go to EC2 → Security Groups
2. Edit inbound rules
3. Add these rules:

| Type | Protocol | Port | Source |
|------|----------|------|--------|
| Custom TCP | TCP | 5000 | Your IP/0.0.0.0 |
| Custom TCP | TCP | 8080 | Your IP/0.0.0.0 |
| Custom TCP | TCP | 9090 | Your IP/0.0.0.0 |
| Custom TCP | TCP | 4000 | Your IP/0.0.0.0 |
| Custom TCP | TCP | 3000 | Your IP/0.0.0.0 |
| Custom TCP | TCP | 27017 | Your IP/0.0.0.0 |
| Custom TCP | TCP | 6379 | Your IP/0.0.0.0 |
| Custom TCP | TCP | 5432 | Your IP/0.0.0.0 |

\`\`\`
⚠️ For production, restrict Source to specific IPs
\`\`\`

### Method 3: Run Frontend on EC2 Directly

If running React on EC2:

\`\`\`bash
# Create .env with EC2 internal IPs
cat > .env.local << EOF
REACT_APP_PRODCUTS_URL_BASE=http://EC2_PRIVATE_IP:5000/
REACT_APP_CART_URL_BASE=http://EC2_PRIVATE_IP:8080/
REACT_APP_USERS_URL_BASE=http://EC2_PRIVATE_IP:9090/
REACT_APP_SEARCH_URL_BASE=http://EC2_PRIVATE_IP:4000/
EOF
\`\`\`

---

## API DOCUMENTATION

### Base URLs (Development)
\`\`\`
Products:  http://localhost:5000
Cart:      http://localhost:8080
Users:     http://localhost:9090
Search:    http://localhost:4000
Auth:      http://localhost:8081
Payments:  http://localhost:8082
\`\`\`

### Key Endpoints

#### Products Service
\`\`\`
GET    /deals                    # Get featured deals
GET    /products/sku/:sku       # Get product by SKU
GET    /products/:id            # Get product details
POST   /products                # Create product (admin)
PUT    /products/:id            # Update product (admin)
\`\`\`

#### Cart Service
\`\`\`
GET    /cart                    # List all carts
GET    /cart/:customerId        # Get customer's cart
POST   /cart                    # Add to cart
PUT    /cart/:customerId        # Update cart
DELETE /cart/:customerId        # Clear cart
POST   /cart/:customerId/checkout  # Place order
\`\`\`

Example Cart Add:
\`\`\`bash
curl -X POST http://localhost:8080/cart \\
  -H "Content-Type: application/json" \\
  -H "Authorization: Bearer {JWT_TOKEN}" \\
  -d '{
    "customerId": "john@example.com",
    "items": [
      {
        "productId": "301671",
        "sku": "sku2441",
        "title": "Evening Platform Pumps",
        "quantity": 1,
        "price": 145.99,
        "currency": "USD"
      }
    ]
  }'
\`\`\`

#### Users Service
\`\`\`
GET    /users                   # List all users
POST   /users                   # Create user
GET    /users/{id}              # Get user details
PUT    /users/{id}              # Update user
DELETE /users/{id}              # Delete user
\`\`\`

#### Auth Service (New)
\`\`\`
POST   /auth/register           # Register new user
POST   /auth/login              # Login user
POST   /auth/refresh            # Refresh JWT token
POST   /auth/logout             # Logout user
GET    /auth/verify             # Verify token
\`\`\`

#### Payment Service (New)
\`\`\`
POST   /payments/intent         # Create Stripe PaymentIntent
GET    /payments/status/:id     # Check payment status
POST   /payments/webhook        # Stripe webhook
\`\`\`

---

## EVENT-DRIVEN ARCHITECTURE

### RabbitMQ Topics & Consumers

#### 1. Order Events
\`\`\`
Topic: order.exchange
Queues:
  - order.created.queue       → Notifications Service
  - order.created.queue       → Inventory Service
  - order.confirmed.queue     → Notifications Service
\`\`\`

#### 2. Payment Events
\`\`\`
Topic: payment.exchange
Queues:
  - payment.completed.queue   → Order Service
  - payment.failed.queue      → Notifications Service
\`\`\`

#### 3. User Events
\`\`\`
Topic: user.exchange
Queues:
  - user.registered.queue     → Notifications Service
  - user.registered.queue     → Analytics Service
\`\`\`

#### 4. Inventory Events
\`\`\`
Topic: inventory.exchange
Queues:
  - inventory.updated.queue   → Search Service (update index)
  - inventory.low.queue       → Notifications Service
\`\`\`

### Event Message Format
\`\`\`json
{
  "eventId": "evt_12345",
  "eventType": "order.created",
  "timestamp": "2024-02-13T10:30:00Z",
  "source": "order-service",
  "data": {
    "orderId": "ORD-123",
    "customerId": "user-456",
    "items": [...],
    "totalAmount": 299.99,
    "currency": "USD"
  },
  "metadata": {
    "correlationId": "corr_789",
    "userId": "user-456"
  }
}
\`\`\`

### Consumer Implementation Example (Node.js)
\`\`\`javascript
const amqp = require('amqplib');

async function setupEventConsumer() {
  const connection = await amqp.connect(process.env.RABBITMQ_URL);
  const channel = await connection.createChannel();
  
  // Declare exchange
  await channel.assertExchange('order.exchange', 'topic', { durable: true });
  
  // Declare queue
  await channel.assertQueue('order.created.queue', { durable: true });
  
  // Bind queue to exchange
  await channel.bindQueue('order.created.queue', 'order.exchange', 'order.created');
  
  // Consume messages
  channel.consume('order.created.queue', async (msg) => {
    const event = JSON.parse(msg.content.toString());
    console.log('Order created event:', event);
    
    // Process event (e.g., send email)
    await handleOrderCreated(event.data);
    
    // Acknowledge message
    channel.ack(msg);
  });
}
\`\`\`

---

## PAYMENT INTEGRATION

### Stripe Testing

#### Test Credentials
\`\`\`
STRIPE_SECRET_KEY: sk_test_51234567890abcdefghijklmn
STRIPE_PUBLIC_KEY: pk_test_ABCDEFGHIJKLMNOPQRSTUVWxyz
\`\`\`

#### Test Cards
\`\`\`
Success:      4242-4242-4242-4242
Decline:      4000-0000-0000-0002
CVC Error:    4000-0000-0000-0069
Exp Date:     12/25
CVC:          Any 3 digits
\`\`\`

#### Payment Flow
\`\`\`
1. Frontend adds items to cart
2. Customer clicks "Checkout"
3. POST /payments/intent {cartId, email, amount}
4. Backend creates Stripe PaymentIntent
5. Returns client_secret to frontend
6. Frontend uses Stripe.js for Card Element
7. Frontend confirms payment with client_secret
8. Stripe processes payment
9. Webhook (POST /payments/webhook) triggered
10. Backend creates Order record
11. Publisher sends order.confirmed event to RabbitMQ
12. Notification service sends confirmation email
\`\`\`

#### Backend Implementation (Express)
\`\`\`javascript
const stripe = require('stripe')(process.env.STRIPE_SECRET_KEY);
const express = require('express');
const router = express.Router();

// Create payment intent
router.post('/intent', async (req, res) => {
  try {
    const { cartId, email, amount, metadata } = req.body;
    
    const intent = await stripe.paymentIntents.create({
      amount: Math.round(amount * 100), // Amount in cents
      currency: 'usd',
      metadata: { cartId, ...metadata }
    });
    
    res.json({ clientSecret: intent.client_secret });
  } catch (err) {
    res.status(400).json({ error: err.message });
  }
});

// Webhook handler
router.post('/webhook', express.raw({type: 'application/json'}), async (req, res) => {
  const sig = req.headers['stripe-signature'];
  const endpointSecret = process.env.STRIPE_WEBHOOK_SECRET;
  
  try {
    const event = stripe.webhooks.constructEvent(req.body, sig, endpointSecret);
    
    if (event.type === 'payment_intent.succeeded') {
      const paymentIntent = event.data.object;
      // Create order
      await createOrder(paymentIntent.metadata);
      // Publish event
      await publishEvent('payment.completed', paymentIntent);
    }
    
    res.json({received: true});
  } catch (err) {
    res.status(400).send('Webhook Error: ' + err.message);
  }
});
\`\`\`

---

## TESTING & VALIDATION

### 1. Database Connection Tests
\`\`\`bash
# Test MongoDB
docker exec ecommerce_mongodb mongosh "mongodb://admin:admin123@localhost:27017/ecommerce?authSource=admin" --eval "db.adminCommand('ping')"

# Test Redis
docker exec ecommerce_redis redis-cli -a redis123 ping

# Test PostgreSQL
docker exec ecommerce_postgres psql -U admin -d ecommerce -c "SELECT version();"

# Test RabbitMQ
docker exec ecommerce_rabbitmq rabbitmq-diagnostics -q ping
\`\`\`

### 2. Service Health Checks
\`\`\`bash
# Products
curl http://localhost:5000/

# Cart
curl http://localhost:8080/

# Users
curl http://localhost:9090/docs

# Check auth header requirement
curl -H "Authorization: Bearer invalid_token" http://localhost:8080/cart
\`\`\`

### 3. Manual Testing Flow
\`\`\`bash
# 1. Register user
curl -X POST http://localhost:8081/auth/register \\
  -H "Content-Type: application/json" \\
  -d '{
    "email": "test@example.com",
    "password": "SecurePass123!",
    "name": "Test User"
  }'

# 2. Login
TOKEN=$(curl -X POST http://localhost:8081/auth/login \\
  -H "Content-Type: application/json" \\
  -d '{
    "email": "test@example.com",
    "password": "SecurePass123!"
  }' | jq -r '.token')

# 3. Get deals
curl http://localhost:5000/deals

# 4. Get product details
curl http://localhost:5000/products/sku/sku2441

# 5. Add to cart (with auth header)
curl -X POST http://localhost:8080/cart \\
  -H "Content-Type: application/json" \\
  -H "Authorization: Bearer ${TOKEN}" \\
  -d '{ ... cart payload ... }'

# 6. Create payment intent
curl -X POST http://localhost:8082/payments/intent \\
  -H "Content-Type: application/json" \\
  -H "Authorization: Bearer ${TOKEN}" \\
  -d '{
    "amount": 299.99,
    "currency": "USD",
    "email": "test@example.com"
  }'
\`\`\`

---

## TROUBLESHOOTING

### Common Issues & Solutions

#### 1. Container Startup Issues
\`\`\`bash
# View logs
docker-compose logs -f <service_name>

# Restart container
docker-compose restart <service_name>

# Rebuild from scratch
docker-compose down -v
docker-compose up --build
\`\`\`

#### 2. Database Connection Refused
\`\`\`bash
# Check if container is running
docker-compose ps

# Check database logs
docker-compose logs mongodb

# Verify network connectivity
docker exec <container> ping <other_container>
\`\`\`

#### 3. Port Already in Use
\`\`\`bash
# Find process using port
lsof -i :<port_number>

# Kill process
kill -9 <PID>

# Or change port in .env
\`\`\`

#### 4. Java/Spring Boot Issues
\`\`\`bash
# Memory issues
export JAVA_OPTS="-Xmx1024m -Xms512m"

# Check logs
tail -f nohup.out

# Debugging
gradle bootRun --debug-jvm
\`\`\`

#### 5. Python Virtual Environment Issues
\`\`\`bash
# Reset pipenv
rm -rf Pipfile.lock .venv
pipenv install

# Or use system Python
python3 -m venv venv
source venv/bin/activate
pip install -r requirements.txt
\`\`\`

#### 6. CORS Errors
\`\`\`bash
# Check CORS headers
curl -i -X OPTIONS http://localhost:8080/cart

# Add Origin header
curl -H "Origin: http://localhost:3000" http://localhost:8080/cart
\`\`\`

### Debug Endpoints
\`\`\`bash
# Check service health
curl http://localhost:{port}/health

# View logs with trace ID
docker-compose logs -f --tail=100

# Test event publishing
curl -X POST http://localhost:5672 -d '{"event": "test"}'
\`\`\`

---

## NEXT STEPS (Priority Order)

### Week 1: Critical Security
- [ ] Implement JWT authentication service  
- [ ] Add input validation to all endpoints
- [ ] Set up HTTPS with SSL certificates
- [ ] Implement rate limiting

### Week 2: Payment & Events
- [ ] Complete Stripe integration
- [ ] Set up RabbitMQ consumers
- [ ] Implement order service
- [ ] Add email notifications

### Week 3: Deployment
- [ ] Set up CI/CD pipeline (GitHub Actions)
- [ ] Configure Kubernetes manifests
- [ ] Set up monitoring (Prometheus/Grafana)
- [ ] Configure logging (ELK stack)

### Week 4: Production Ready
- [ ] Load testing
- [ ] Security audit
- [ ] Documentation finalization
- [ ] Staging deployment

---

## Support & References

- **Docker Docs:** https://docs.docker.com/
- **Spring Boot:** https://spring.io/
- **Express.js:** https://expressjs.com/
- **FastAPI:** https://fastapi.tiangolo.com/
- **RabbitMQ:** https://www.rabbitmq.com/
- **Stripe:** https://stripe.com/docs
- **AWS EC2:** https://docs.aws.amazon.com/ec2/

---

**Last Updated:** February 13, 2026  
**Next Review:** February 20, 2026


# 🚀 QUICK START GUIDE

Get the entire microservices application running in 15 minutes!

## Prerequisites
- Docker & Docker-compose installed
- Java 17+ (for Cart service)
- Node.js 18+ (for Products/Search/Payments)
- Python 3.10+ (for Users service)
- Git

## Step 1: Start Infrastructure (2 minutes)

```bash
cd /home/ubuntu/scalable-ecommerce-microservices

# Start all databases & message queue
docker-compose up -d

# Wait for services to be healthy
docker-compose ps

# Expected: All containers showing "Up (healthy)" or "Up"
```

## Step 2: Environment Setup

```bash
# Load environment variables
export $(cat .env.production | xargs)

# Verify
echo $MONGO_URI
echo $REDIS_URL
```

## Step 3: Start Services (Choose One)

### Option A: Run Each Service Separately (Recommended for Development)

**Terminal 1 - Products Service (Port 5000)**
```bash
cd products-cna-microservice
npm install
export MONGO_URI="mongodb://admin:admin123@localhost:27017/ecommerce?authSource=admin"
npm start
```

**Terminal 2 - Cart Service (Port 8080)**
```bash
cd cart-cna-microservice
export SPRING_REDIS_HOST=localhost
export SPRING_REDIS_PORT=6379
export SPRING_REDIS_PASSWORD=redis123
gradle bootRun
```

**Terminal 3 - Users Service (Port 9090)**
```bash
cd users-cna-microservice
pip install pipenv
pipenv install
pipenv shell
python app.py
```

**Terminal 4 - Frontend (Port 3000)**
```bash
cd store-ui

# Create .env.local
cat > .env.local << EOF
REACT_APP_PRODCUTS_URL_BASE=http://localhost:5000/
REACT_APP_CART_URL_BASE=http://localhost:8080/
REACT_APP_USERS_URL_BASE=http://localhost:9090/
EOF

npm install
npm start
```

### Option B: Run All Services in Background

```bash
# Start all services with nohup
nohup npm start > /tmp/products.log 2>&1 &  # Port 5000
nohup gradle bootRun > /tmp/cart.log 2>&1 &  # Port 8080
nohup python app.py > /tmp/users.log 2>&1 &  # Port 9090
nohup npm start > /tmp/frontend.log 2>&1 &   # Port 3000

# View logs if needed
tail -f /tmp/products.log
```

## Step 4: Verify Services

```bash
# Check Products
curl http://localhost:5000/

# Check Cart
curl http://localhost:8080/

# Check Users
curl http://localhost:9090/docs

# Check Frontend
open http://localhost:3000
```

## Step 5: Test Full Flow

### 1. View Products
```bash
curl http://localhost:5000/deals
```

### 2. Get Product Details
```bash
curl http://localhost:5000/products/sku/sku2441
```

### 3. Add to Cart
```bash
curl -X POST http://localhost:8080/cart \
  -H "Content-Type: application/json" \
  -d '{
    "customerId": "john@example.com",
    "items": [{
      "productId": "301671",
      "sku": "sku2441",
      "title": "Evening Platform Pumps",
      "quantity": 1,
      "price": 145.99,
      "currency": "USD"
    }]
  }'
```

### 4. View Cart
```bash
curl http://localhost:8080/cart/john@example.com
```

### 5. In Browser
- Visit http://localhost:3000
- Browse products
- Add to cart
- View cart

## Service Ports Reference

| Service | Port | Health Check |
|---------|------|--------------|
| Frontend | 3000 | http://localhost:3000 |
| Products | 5000 | http://localhost:5000/ |
| Cart | 8080 | http://localhost:8080/ |
| Users | 9090 | http://localhost:9090/docs |
| Search | 4000 | http://localhost:4000/ |
| Auth | 8081 | Coming Soon |
| Payments | 8082 | Coming Soon |

## Database Access

### MongoDB
```bash
mongosh "mongodb://admin:admin123@localhost:27017/ecommerce?authSource=admin"
> use ecommerce
> db.products.find().pretty()
```

### Redis
```bash
redis-cli -h localhost -p 6379 -a redis123
> ping
> KEYS *
```

### PostgreSQL
```bash
psql -h localhost -U admin -d ecommerce
> \dt
> SELECT * FROM "user";
```

### RabbitMQ Management
- URL: http://localhost:15672
- Username: admin
- Password: admin123

## Troubleshooting

### Port Already in Use
```bash
lsof -i :3000  # Find what's using port 3000
kill -9 <PID>
```

### Database Connection Issues
```bash
# Check Docker is running
docker ps

# Check logs
docker-compose logs -f mongodb

# Restart containers
docker-compose restart
```

### Service Won't Start
```bash
# Check logs
tail -f /tmp/products.log

# Kill any background processes
pkill -f "npm start"
pkill -f "gradle bootRun"
pkill -f "python app.py"

# Start fresh
npm install && npm start
```

## Next Steps

1. **Read Full Documentation**: See [IMPLEMENTATION_GUIDE.md](IMPLEMENTATION_GUIDE.md)
2. **Review Changes**: See [CHANGES_SUMMARY.md](CHANGES_SUMMARY.md)  
3. **Understand Architecture**: See [Architecture Diagrams](#architecture)
4. **Deploy to AWS**: See port forwarding guide in IMPLEMENTATION_GUIDE
5. **Add Authentication**: Implement JWT auth (in progress)
6. **Add Payment**: Integrate Stripe (in progress)

## Common Curl Commands

```bash
# Get all deals
curl http://localhost:5000/deals

# Get product by SKU
curl http://localhost:5000/products/sku/sku2441

# Create user
curl -X POST http://localhost:9090/users \
  -H "Content-Type: application/x-www-form-urlencoded" \
  -d "name=John&email=john@example.com&mobile=9876543210"

# List users
curl http://localhost:9090/users

# Add to cart
curl -X POST http://localhost:8080/cart \
  -H "Content-Type: application/json" \
  -d '{"customerId":"test","items":[]}'

# Get cart
curl http://localhost:8080/cart/test
```

---

**Happy Coding! 🎉**

For issues and questions, check the [IMPLEMENTATION_GUIDE.md](IMPLEMENTATION_GUIDE.md#troubleshooting) troubleshooting section.


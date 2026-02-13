#!/bin/bash

# ============================================================================
# DATABASE VERIFICATION SCRIPT
# Verify all databases are working correctly
# ============================================================================

echo "=========================================="
echo "  DATABASE VERIFICATION SCRIPT" 
echo "=========================================="
echo ""

# Colors
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Function to check service
check_service() {
    local name=$1
    local host=$2
    local port=$3
    echo -n "Testing $name... "
    
    if nc -z $host $port 2>/dev/null; then
        echo -e "${GREEN}✓ Running on $host:$port${NC}"
        return 0
    else
        echo -e "${RED}✗ Not responding${NC}"
        return 1
    fi
}

echo "1. CHECKING DOCKER CONTAINERS"
echo "================================"
docker-compose ps 2>/dev/null | grep -E "ecommerce_|CONTAINER|UP|Exit"
echo ""

echo "2. CHECKING SERVICE CONNECTIVITY"
echo "=================================="
check_service "MongoDB" "localhost" 27017
check_service "Redis" "localhost" 6379
check_service "PostgreSQL" "localhost" 5432
check_service "RabbitMQ" "localhost" 5672
echo ""

echo "3. TESTING MONGODB"
echo "=================="
echo "Command: mongosh \"mongodb://admin:admin123@localhost:27017/ecommerce?authSource=admin\""
echo ""
mongosh "mongodb://admin:admin123@localhost:27017/ecommerce?authSource=admin" --eval "
  try {
    db.adminCommand('ping');
    console.log('✓ MongoDB Connected');
    db.createCollection('test_collection');
    db.test_collection.insertOne({test: 'data', timestamp: new Date()});
    console.log('✓ Can write to MongoDB');
    db.test_collection.drop();
    console.log('✓ Can delete from MongoDB');
  } catch(e) {
    console.log('✗ MongoDB Error: ' + e.message);
  }
" 2>/dev/null || echo -e "${YELLOW}MongoDB test skipped (check manually)${NC}"
echo ""

echo "4. TESTING REDIS"
echo "================"
echo "Command: redis-cli -h localhost -p 6379 -a redis123 ping"
echo ""
redis-cli -h localhost -p 6379 -a redis123 ping 2>/dev/null && \
  echo -e "${GREEN}✓ Redis Connected${NC}" || \
  echo -e "${RED}✗ Redis Connection Failed${NC}"

redis-cli -h localhost -p 6379 -a redis123 SET test_key "test_value" 2>/dev/null && \
  echo -e "${GREEN}✓ Can write to Redis${NC}" || \
  echo -e "${YELLOW}Redis write test skipped${NC}"

redis-cli -h localhost -p 6379 -a redis123 DEL test_key 2>/dev/null && \
  echo -e "${GREEN}✓ Can delete from Redis${NC}" || \
  echo -e "${YELLOW}Redis delete test skipped${NC}"
echo ""

echo "5. TESTING POSTGRESQL"
echo "====================="
echo "Command: psql -h localhost -U admin -d ecommerce -c \"SELECT version();\""
echo ""
psql -h localhost -U admin -d ecommerce -c "SELECT version();" 2>/dev/null && \
  echo -e "${GREEN}✓ PostgreSQL Connected${NC}" || \
  echo -e "${RED}✗ PostgreSQL Connection Failed${NC}"
echo ""

echo "6. TESTING RABBITMQ"
echo "==================="
echo "Command: Open http://localhost:15672"
echo ""
curl -s -u admin:admin123 http://localhost:15672/api/whoami | grep -q '"name"' && \
  echo -e "${GREEN}✓ RabbitMQ Connected${NC}" || \
  echo -e "${YELLOW}RabbitMQ test skipped (check http://localhost:15672)${NC}"
echo ""

echo "7. TESTING MICROSERVICES"
echo "======================="
echo ""
echo "Testing Products Service (Port 5000):"
curl -s http://localhost:5000/ >/dev/null && \
  echo -e "${GREEN}✓ Products Service Running${NC}" || \
  echo -e "${YELLOW}⏳ Products Service not started yet${NC}"

echo ""
echo "Testing Cart Service (Port 8080):"
curl -s http://localhost:8080/ >/dev/null && \
  echo -e "${GREEN}✓ Cart Service Running${NC}" || \
  echo -e "${YELLOW}⏳ Cart Service not started yet${NC}"

echo ""
echo "Testing Users Service (Port 9090):"
curl -s http://localhost:9090/docs >/dev/null && \
  echo -e "${GREEN}✓ Users Service Running${NC}" || \
  echo -e "${YELLOW}⏳ Users Service not started yet${NC}"

echo ""
echo "=========================================="
echo "  VERIFICATION COMPLETE"
echo "=========================================="
echo ""
echo "NEXT STEPS:"
echo "1. Start microservices: See QUICK_START.md"
echo "2. Test full flow: See IMPLEMENTATION_GUIDE.md"
echo "3. Questions: Check documentation in repo root"
echo ""

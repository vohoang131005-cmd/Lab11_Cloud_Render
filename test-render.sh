#!/bin/bash
GW="${1:-https://your-api-gateway.onrender.com}"
curl -s "$GW/" | jq .
curl -s "$GW/health" | jq .
curl -s "$GW/users" | jq .
curl -s -X POST "$GW/users" -H "Content-Type: application/json" -d '{"name":"Test","email":"t@r.com"}' | jq .
curl -s "$GW/products" | jq .
curl -s -X POST "$GW/orders" -H "Content-Type: application/json" -d '{"userId":1,"productId":1,"quantity":2}' | jq .
curl -s "$GW/orders" | jq .
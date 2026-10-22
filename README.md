# Lab11 Cloud - Microservices tren Render

## Cau truc
- user-service: Node.js + Express + PostgreSQL
- product-service: Node.js + Express (in-memory)
- order-service: Node.js + Express + Axios
- api-gateway: http-proxy-middleware

## Chay local
Moi service: cd vao thu muc, npm install, npm start

## Deploy Render
1. Push len GitHub
2. Tao PostgreSQL (Free - luu y DB xoa sau 30 ngay)
3. Tao 4 Web Service, Root Directory tuong ung
4. Set env vars: DATABASE_URL (user), USER_SERVICE_URL + PRODUCT_SERVICE_URL (order), + ORDER_SERVICE_URL (gateway)
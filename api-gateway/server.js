const express = require('express');
const { createProxyMiddleware } = require('http-proxy-middleware');
const cors = require('cors');

const app = express();
app.set('trust proxy', 1);
app.use(cors());
// KHONG dung express.json() o gateway - se an body POST truoc khi proxy forward

const USER_SERVICE_URL = process.env.USER_SERVICE_URL || 'http://localhost:3001';
const PRODUCT_SERVICE_URL = process.env.PRODUCT_SERVICE_URL || 'http://localhost:3002';
const ORDER_SERVICE_URL = process.env.ORDER_SERVICE_URL || 'http://localhost:3003';

app.get('/health', (req, res) => {
  res.json({
    gateway: { status: 'healthy' },
    services: {
      userService: USER_SERVICE_URL,
      productService: PRODUCT_SERVICE_URL,
      orderService: ORDER_SERVICE_URL
    }
  });
});

const proxy = (ctx, target) => createProxyMiddleware(ctx, {
  target,
  changeOrigin: true,
  timeout: 30000,
  proxyTimeout: 30000,
  onError: (err, req, res) => {
    console.error(`Proxy error ${req.method} ${req.url} -> ${target}:`, err.message);
    if (!res.headersSent) {
      res.status(503).json({ error: 'Service unavailable', service: target, detail: err.message });
    }
  }
});

app.use(proxy('/users', USER_SERVICE_URL));
app.use(proxy('/products', PRODUCT_SERVICE_URL));
app.use(proxy('/orders', ORDER_SERVICE_URL));

app.get('/', (req, res) => {
  res.json({
    message: 'API Gateway',
    services: { user: USER_SERVICE_URL, product: PRODUCT_SERVICE_URL, order: ORDER_SERVICE_URL }
  });
});

const PORT = process.env.PORT || 3000;
app.listen(PORT, '0.0.0.0', () => console.log(`API Gateway on ${PORT}`));
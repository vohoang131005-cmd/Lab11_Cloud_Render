param([string]$GatewayUrl = "https://your-api-gateway.onrender.com")

Write-Host "GET /" -ForegroundColor Cyan
Invoke-RestMethod "$GatewayUrl/" | ConvertTo-Json -Depth 10

Write-Host "`nGET /health" -ForegroundColor Cyan
Invoke-RestMethod "$GatewayUrl/health" | ConvertTo-Json -Depth 10

Write-Host "`nGET /users" -ForegroundColor Cyan
Invoke-RestMethod "$GatewayUrl/users" | ConvertTo-Json -Depth 10

Write-Host "`nPOST /users" -ForegroundColor Cyan
Invoke-RestMethod -Method Post -Uri "$GatewayUrl/users" `
  -ContentType "application/json" `
  -Body '{"name":"Test User","email":"test@render.com"}' | ConvertTo-Json

Write-Host "`nGET /products" -ForegroundColor Cyan
Invoke-RestMethod "$GatewayUrl/products" | ConvertTo-Json -Depth 10

Write-Host "`nPOST /orders" -ForegroundColor Cyan
Invoke-RestMethod -Method Post -Uri "$GatewayUrl/orders" `
  -ContentType "application/json" `
  -Body '{"userId":1,"productId":1,"quantity":2}' | ConvertTo-Json

Write-Host "`nGET /orders" -ForegroundColor Cyan
Invoke-RestMethod "$GatewayUrl/orders" | ConvertTo-Json -Depth 10
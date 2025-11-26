@echo off
REM 购物车接口测试脚本 (Windows版本)
REM 使用方法：双击运行或在命令行执行

set BASE_URL=http://localhost:8080
set USER_ID=1

echo ==========================================
echo 购物车接口测试脚本
echo ==========================================
echo.

REM 1. 清空购物车
echo [步骤 1] 清空购物车
curl -X DELETE "%BASE_URL%/api/cart/clear?userId=%USER_ID%"
echo.
echo.

REM 2. 添加商品1
echo [步骤 2] 添加商品1到购物车
curl -X POST "%BASE_URL%/api/cart/add" -H "Content-Type: application/json" -d "{\"userId\":1,\"productId\":1,\"quantity\":2}"
echo.
echo.

REM 3. 添加商品2
echo [步骤 3] 添加商品2到购物车
curl -X POST "%BASE_URL%/api/cart/add" -H "Content-Type: application/json" -d "{\"userId\":1,\"productId\":2,\"quantity\":1}"
echo.
echo.

REM 4. 获取购物车列表
echo [步骤 4] 获取购物车列表
curl -X GET "%BASE_URL%/api/cart/list?userId=%USER_ID%"
echo.
echo.

REM 5. 获取购物车数量
echo [步骤 5] 获取购物车数量
curl -X GET "%BASE_URL%/api/cart/count?userId=%USER_ID%"
echo.
echo.

REM 6. 更新商品数量
echo [步骤 6] 更新购物车商品数量
curl -X PUT "%BASE_URL%/api/cart/update" -H "Content-Type: application/json" -d "{\"cartId\":1,\"quantity\":5}"
echo.
echo.

REM 7. 再次获取购物车列表
echo [步骤 7] 再次获取购物车列表
curl -X GET "%BASE_URL%/api/cart/list?userId=%USER_ID%"
echo.
echo.

REM 8. 删除商品
echo [步骤 8] 删除购物车商品
curl -X DELETE "%BASE_URL%/api/cart/delete/1"
echo.
echo.

REM 9. 最终购物车列表
echo [步骤 9] 最终购物车列表
curl -X GET "%BASE_URL%/api/cart/list?userId=%USER_ID%"
echo.
echo.

echo ==========================================
echo 测试完成！
echo ==========================================
pause



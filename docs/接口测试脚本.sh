#!/bin/bash

# 购物车接口测试脚本
# 使用方法：bash 接口测试脚本.sh

BASE_URL="http://localhost:8080"
USER_ID=1

echo "=========================================="
echo "购物车接口测试脚本"
echo "=========================================="
echo ""

# 颜色定义
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# 测试函数
test_api() {
    local name=$1
    local method=$2
    local url=$3
    local data=$4
    
    echo -e "${YELLOW}测试: ${name}${NC}"
    echo "请求: ${method} ${url}"
    if [ -n "$data" ]; then
        echo "数据: ${data}"
        response=$(curl -s -X ${method} "${BASE_URL}${url}" \
            -H "Content-Type: application/json" \
            -d "${data}")
    else
        response=$(curl -s -X ${method} "${BASE_URL}${url}")
    fi
    
    echo "响应: ${response}"
    echo ""
}

# 1. 清空购物车
echo -e "${GREEN}步骤 1: 清空购物车${NC}"
test_api "清空购物车" "DELETE" "/api/cart/clear?userId=${USER_ID}"

# 2. 添加商品1
echo -e "${GREEN}步骤 2: 添加商品1到购物车${NC}"
test_api "添加商品" "POST" "/api/cart/add" '{"userId":1,"productId":1,"quantity":2}'

# 3. 添加商品2
echo -e "${GREEN}步骤 3: 添加商品2到购物车${NC}"
test_api "添加商品" "POST" "/api/cart/add" '{"userId":1,"productId":2,"quantity":1}'

# 4. 获取购物车列表
echo -e "${GREEN}步骤 4: 获取购物车列表${NC}"
test_api "获取购物车列表" "GET" "/api/cart/list?userId=${USER_ID}"

# 5. 获取购物车数量
echo -e "${GREEN}步骤 5: 获取购物车数量${NC}"
test_api "获取购物车数量" "GET" "/api/cart/count?userId=${USER_ID}"

# 6. 更新商品数量（需要先获取cartId，这里假设是1）
echo -e "${GREEN}步骤 6: 更新购物车商品数量${NC}"
test_api "更新商品数量" "PUT" "/api/cart/update" '{"cartId":1,"quantity":5}'

# 7. 再次获取购物车列表
echo -e "${GREEN}步骤 7: 再次获取购物车列表${NC}"
test_api "获取购物车列表" "GET" "/api/cart/list?userId=${USER_ID}"

# 8. 删除商品（假设cartId是1）
echo -e "${GREEN}步骤 8: 删除购物车商品${NC}"
test_api "删除商品" "DELETE" "/api/cart/delete/1"

# 9. 最终购物车列表
echo -e "${GREEN}步骤 9: 最终购物车列表${NC}"
test_api "获取购物车列表" "GET" "/api/cart/list?userId=${USER_ID}"

echo "=========================================="
echo "测试完成！"
echo "=========================================="



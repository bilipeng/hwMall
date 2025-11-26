package com.peng.hwmallservicedemo.service.search;

import java.util.List;
import java.util.Map;

public interface SearchService {
    /**
     * 搜索商品
     * @param keyword 搜索关键词
     * @param page 页码（从1开始）
     * @param pageSize 每页数量
     * @return 搜索结果，包含商品列表和总数
     */
    Map<String, Object> searchProducts(String keyword, int page, int pageSize);
}


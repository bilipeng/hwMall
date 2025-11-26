package com.peng.hwmallservicedemo.service.search;

import com.peng.hwmallservicedemo.repository.product.ProductRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class SearchServiceImpl implements SearchService {

    @Autowired
    private ProductRepository productRepository;

    @Override
    public Map<String, Object> searchProducts(String keyword, int page, int pageSize) {
        // 参数验证
        if (keyword == null || keyword.trim().isEmpty()) {
            throw new RuntimeException("搜索关键词不能为空");
        }

        // 计算偏移量
        int offset = (page - 1) * pageSize;

        // 查询商品列表
        List<Map<String, Object>> productList = productRepository.searchByKeywordWithPage(
            keyword.trim(), offset, pageSize
        );

        // 查询总数
        int total = productRepository.countByKeyword(keyword.trim());

        // 构建返回结果
        Map<String, Object> result = new HashMap<>();
        result.put("total", total);
        result.put("keyword", keyword.trim());
        result.put("list", productList);
        result.put("page", page);
        result.put("pageSize", pageSize);

        return result;
    }
}


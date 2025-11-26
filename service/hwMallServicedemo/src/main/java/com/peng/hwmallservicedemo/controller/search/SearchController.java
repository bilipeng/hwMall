package com.peng.hwmallservicedemo.controller.search;

import com.peng.hwmallservicedemo.service.search.SearchService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.Map;

@RestController
@RequestMapping("/api/search")
public class SearchController {

    @Autowired
    private SearchService searchService;

    /**
     * 搜索商品
     */
    @GetMapping
    public Map<String, Object> search(@RequestParam String keyword,
                                       @RequestParam(defaultValue = "1") int page,
                                       @RequestParam(defaultValue = "10") int pageSize) {
        Map<String, Object> result = new HashMap<>();
        try {
            // 参数验证
            if (keyword == null || keyword.trim().isEmpty()) {
                result.put("code", 400);
                result.put("message", "搜索关键词不能为空");
                result.put("data", null);
                return result;
            }

            // 限制关键词长度
            if (keyword.length() > 50) {
                result.put("code", 400);
                result.put("message", "搜索关键词长度不能超过50个字符");
                result.put("data", null);
                return result;
            }

            // 执行搜索
            Map<String, Object> searchResult = searchService.searchProducts(keyword, page, pageSize);

            result.put("code", 200);
            result.put("message", "success");
            result.put("data", searchResult);
        } catch (Exception e) {
            result.put("code", 500);
            result.put("message", e.getMessage());
            result.put("data", null);
        }
        return result;
    }
}


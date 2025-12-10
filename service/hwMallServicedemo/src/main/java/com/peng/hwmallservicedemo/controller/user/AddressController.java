package com.peng.hwmallservicedemo.controller.user;

import com.peng.hwmallservicedemo.model.user.Address;
import com.peng.hwmallservicedemo.service.user.AddressService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

@RestController
@RequestMapping("/api/addresses")
public class AddressController {

    @Autowired
    private AddressService addressService;

    /**
     * 获取用户的所有地址
     * GET /api/addresses/user/:user_id
     */
    @GetMapping("/user/{user_id}")
    public Map<String, Object> getAddressesByUserId(@PathVariable("user_id") int userId) {
        return addressService.getAddressesByUserId(userId);
    }

    /**
     * 根据ID获取地址
     * GET /api/addresses/:address_id
     */
    @GetMapping("/{address_id}")
    public Map<String, Object> getAddressById(@PathVariable("address_id") int addressId) {
        return addressService.getAddressById(addressId);
    }

    /**
     * 添加地址
     * POST /api/addresses
     */
    @PostMapping
    public Map<String, Object> addAddress(@RequestBody Map<String, Object> request) {
        Address address = new Address();
        
        // 安全获取userId，避免ClassCastException
        Object userIdObj = request.get("userId");
        if (userIdObj != null) {
            if (userIdObj instanceof Integer) {
                address.setUserId((Integer) userIdObj);
            } else if (userIdObj instanceof String) {
                try {
                    address.setUserId(Integer.parseInt((String) userIdObj));
                } catch (NumberFormatException e) {
                    // 忽略无效的字符串转换
                }
            }
        }
        
        address.setName((String) request.get("name"));
        address.setTel((String) request.get("tel"));
        address.setAddress((String) request.get("address"));

        return addressService.addAddress(address);
    }

    /**
     * 更新地址
     * PUT /api/addresses/:address_id
     */
    @PutMapping("/{address_id}")
    public Map<String, Object> updateAddress(
            @PathVariable("address_id") int addressId,
            @RequestBody Map<String, Object> request) {
        Address address = new Address();
        address.setId(addressId);
        address.setName((String) request.get("name"));
        address.setTel((String) request.get("tel"));
        address.setAddress((String) request.get("address"));

        return addressService.updateAddress(address);
    }

    /**
     * 删除地址
     * DELETE /api/addresses/:address_id
     */
    @DeleteMapping("/{address_id}")
    public Map<String, Object> deleteAddress(@PathVariable("address_id") int addressId) {
        return addressService.deleteAddress(addressId);
    }
}



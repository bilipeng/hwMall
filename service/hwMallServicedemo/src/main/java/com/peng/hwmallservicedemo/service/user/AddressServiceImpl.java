package com.peng.hwmallservicedemo.service.user;

import com.peng.hwmallservicedemo.model.user.Address;
import com.peng.hwmallservicedemo.repository.user.AddressRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class AddressServiceImpl implements AddressService {

    @Autowired
    private AddressRepository addressRepository;

    @Override
    public Map<String, Object> getAddressesByUserId(int userId) {
        Map<String, Object> result = new HashMap<>();

        try {
            List<Address> addresses = addressRepository.findByUserId(userId);
            result.put("code", 200);
            result.put("message", "获取成功");
            result.put("data", addresses);
        } catch (Exception e) {
            result.put("code", 500);
            result.put("message", "获取地址列表失败：" + e.getMessage());
            result.put("data", null);
        }

        return result;
    }

    @Override
    public Map<String, Object> getAddressById(int id) {
        Map<String, Object> result = new HashMap<>();

        try {
            Address address = addressRepository.findById(id);
            if (address == null) {
                result.put("code", 404);
                result.put("message", "地址不存在");
                result.put("data", null);
            } else {
                result.put("code", 200);
                result.put("message", "获取成功");
                result.put("data", address);
            }
        } catch (Exception e) {
            result.put("code", 500);
            result.put("message", "获取地址失败：" + e.getMessage());
            result.put("data", null);
        }

        return result;
    }

    @Override
    public Map<String, Object> addAddress(Address address) {
        Map<String, Object> result = new HashMap<>();

        try {
            // 验证必填字段
            if (address.getName() == null || address.getName().trim().isEmpty()) {
                result.put("code", 400);
                result.put("message", "收货人姓名不能为空");
                result.put("data", null);
                return result;
            }

            if (address.getTel() == null || address.getTel().trim().isEmpty()) {
                result.put("code", 400);
                result.put("message", "收货人电话不能为空");
                result.put("data", null);
                return result;
            }

            if (address.getAddress() == null || address.getAddress().trim().isEmpty()) {
                result.put("code", 400);
                result.put("message", "地址不能为空");
                result.put("data", null);
                return result;
            }

            int rows = addressRepository.save(address);
            if (rows > 0) {
                result.put("code", 200);
                result.put("message", "地址添加成功");
                result.put("data", address);
            } else {
                result.put("code", 400);
                result.put("message", "地址添加失败");
                result.put("data", null);
            }
        } catch (Exception e) {
            result.put("code", 500);
            result.put("message", "地址添加失败：" + e.getMessage());
            result.put("data", null);
        }

        return result;
    }

    @Override
    public Map<String, Object> updateAddress(Address address) {
        Map<String, Object> result = new HashMap<>();

        try {
            // 检查地址是否存在
            Address existingAddress = addressRepository.findById(address.getId());
            if (existingAddress == null) {
                result.put("code", 404);
                result.put("message", "地址不存在");
                result.put("data", null);
                return result;
            }

            // 验证必填字段
            if (address.getName() == null || address.getName().trim().isEmpty()) {
                result.put("code", 400);
                result.put("message", "收货人姓名不能为空");
                result.put("data", null);
                return result;
            }

            if (address.getTel() == null || address.getTel().trim().isEmpty()) {
                result.put("code", 400);
                result.put("message", "收货人电话不能为空");
                result.put("data", null);
                return result;
            }

            if (address.getAddress() == null || address.getAddress().trim().isEmpty()) {
                result.put("code", 400);
                result.put("message", "地址不能为空");
                result.put("data", null);
                return result;
            }

            // 保持用户ID不变
            address.setUserId(existingAddress.getUserId());

            int rows = addressRepository.update(address);
            if (rows > 0) {
                result.put("code", 200);
                result.put("message", "地址更新成功");
                result.put("data", address);
            } else {
                result.put("code", 400);
                result.put("message", "地址更新失败");
                result.put("data", null);
            }
        } catch (Exception e) {
            result.put("code", 500);
            result.put("message", "地址更新失败：" + e.getMessage());
            result.put("data", null);
        }

        return result;
    }

    @Override
    public Map<String, Object> deleteAddress(int id) {
        Map<String, Object> result = new HashMap<>();

        try {
            // 检查地址是否存在
            Address address = addressRepository.findById(id);
            if (address == null) {
                result.put("code", 404);
                result.put("message", "地址不存在");
                result.put("data", null);
                return result;
            }

            int rows = addressRepository.deleteById(id);
            if (rows > 0) {
                result.put("code", 200);
                result.put("message", "地址删除成功");
                result.put("data", null);
            } else {
                result.put("code", 400);
                result.put("message", "地址删除失败");
                result.put("data", null);
            }
        } catch (Exception e) {
            result.put("code", 500);
            result.put("message", "地址删除失败：" + e.getMessage());
            result.put("data", null);
        }

        return result;
    }
}



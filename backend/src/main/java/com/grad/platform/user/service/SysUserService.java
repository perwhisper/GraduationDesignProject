package com.grad.platform.user.service;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.grad.platform.user.entity.SysUser;
import com.grad.platform.user.mapper.SysUserMapper;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

@Service
public class SysUserService extends ServiceImpl<SysUserMapper, SysUser> {

    private final PasswordEncoder passwordEncoder;

    public SysUserService(PasswordEncoder passwordEncoder) {
        this.passwordEncoder = passwordEncoder;
    }

    public SysUser register(SysUser user) {
        user.setPassword(passwordEncoder.encode(user.getPassword()));
        save(user);
        return user;
    }

    public SysUser findByUsername(String username) {
        return lambdaQuery().eq(SysUser::getUsername, username).one();
    }
}

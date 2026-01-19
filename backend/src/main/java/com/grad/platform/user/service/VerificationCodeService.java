package com.grad.platform.user.service;

import lombok.RequiredArgsConstructor;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.stereotype.Service;

import java.time.Duration;
import java.util.Random;
import java.util.concurrent.TimeUnit;

@Service
@RequiredArgsConstructor
public class VerificationCodeService {

    private final StringRedisTemplate redisTemplate;
    private static final String KEY_PREFIX = "verify_code:";
    private static final String RATE_LIMIT_PREFIX = "verify_rate_limit:";

    public String generateCode(String target) {
        // Rate limiting: 1 request per minute
        String rateLimitKey = RATE_LIMIT_PREFIX + target;
        if (Boolean.TRUE.equals(redisTemplate.hasKey(rateLimitKey))) {
            throw new RuntimeException("Please wait 1 minute before requesting another code.");
        }

        // Generate 6 digit code
        String code = String.valueOf(new Random().nextInt(900000) + 100000);
        
        // Store in Redis with 5 minutes expiration
        String key = KEY_PREFIX + target;
        redisTemplate.opsForValue().set(key, code, Duration.ofMinutes(5));
        
        // Set rate limit for 1 minute
        redisTemplate.opsForValue().set(rateLimitKey, "1", Duration.ofMinutes(1));

        return code;
    }

    public boolean validateCode(String target, String code) {
        String key = KEY_PREFIX + target;
        String storedCode = redisTemplate.opsForValue().get(key);
        
        if (storedCode != null && storedCode.equals(code)) {
            // Optional: delete code after successful validation to prevent reuse
            redisTemplate.delete(key);
            return true;
        }
        return false;
    }
}

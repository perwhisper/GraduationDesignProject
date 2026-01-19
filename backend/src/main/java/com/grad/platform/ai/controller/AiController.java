package com.grad.platform.ai.controller;

import com.grad.platform.ai.service.AiService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

@RestController
@RequestMapping("/api/ai")
@RequiredArgsConstructor
public class AiController {

    private final AiService aiService;

    @PostMapping("/recommend-topic")
    public ResponseEntity<?> recommendTopic(@RequestBody Map<String, String> request) {
        String direction = request.get("direction");
        return ResponseEntity.ok(Map.of("result", aiService.recommendTopic(direction)));
    }

    @PostMapping("/review")
    public ResponseEntity<?> review(@RequestBody Map<String, String> request) {
        String content = request.get("content");
        return ResponseEntity.ok(Map.of("result", aiService.reviewDocument(content)));
    }
    
    @PostMapping("/write-assist")
    public ResponseEntity<?> writeAssist(@RequestBody Map<String, String> request) {
        String topic = request.get("topic");
        return ResponseEntity.ok(Map.of("result", aiService.assistWriting(topic)));
    }
}

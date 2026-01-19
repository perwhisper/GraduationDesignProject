package com.grad.platform.ai.service;

public interface AiService {
    String recommendTopic(String direction);
    String reviewDocument(String content);
    String assistWriting(String topic);
}

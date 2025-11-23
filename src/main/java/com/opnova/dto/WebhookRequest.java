package com.opnova.dto;

import com.fasterxml.jackson.annotation.JsonProperty;
import java.util.List;

public record WebhookRequest(
    List<Input> inputs,
    String worker
) {
    public record Input(String name, String value) {}
}

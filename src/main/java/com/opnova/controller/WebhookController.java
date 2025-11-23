package com.opnova.controller;

import com.opnova.dto.WebhookRequest;
import io.micronaut.http.HttpRequest;
import io.micronaut.http.HttpResponse;
import io.micronaut.http.annotation.*;
import io.micronaut.http.client.HttpClient;
import io.micronaut.http.client.annotation.Client;
import io.micronaut.scheduling.TaskExecutors;
import io.micronaut.scheduling.annotation.ExecuteOn;
import jakarta.inject.Inject;

@Controller("/webhook")
public class WebhookController {

    @Inject
    @Client("https://${opnova.hostname}")
    HttpClient httpClient;

    @Post("/{organizationSlug}/{taskId}/{webhookId}")
    @ExecuteOn(TaskExecutors.BLOCKING)
    public HttpResponse<String> triggerWebhook(
            @PathVariable String organizationSlug,
            @PathVariable String taskId,
            @PathVariable String webhookId,
            @Header("Authorization") String authorization,
            @Body WebhookRequest request) {

        HttpRequest<?> httpRequest = HttpRequest.POST(
                String.format("/api/organizations/%s/tasks/%s/webhooks/%s", 
                        organizationSlug, taskId, webhookId), request)
                .header("Authorization", authorization)
                .header("Content-Type", "application/json");

        return httpClient.toBlocking().exchange(httpRequest, String.class);
    }
}

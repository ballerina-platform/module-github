import ballerina/websub;
import ballerina/http;
import ballerina/log;

# The WebSub Hub URL for GitHub.
public const string HUB = "https://api.github.com/hub";

# GitHub REST API base url
public const string GITHUB_REST_API_BASE_URL = "https://api.github.com";

# Listener for GitHub connector
# 
@display {label: "GitHub Listener"}
public class Listener {
    private websub:Listener subscriberListener;
    private websub:SubscriberService? subscriberService;
    private string? accessToken;


    # Initializes GitHub connector listener.
    #
    # + listenTo - Port number or `http:Listener`
    # + config - Configurations for configure the underlying HTTP listener of the WebSub listener.
    # + return - An error on failure of initialization or else `()`
    public isolated function init(int|http:Listener listenTo, websub:ListenerConfiguration? config = ()) returns error? {
        websub:ListenerConfiguration subscriberListenerConfig = {};
        if (config is  websub:ListenerConfiguration) {
            subscriberListenerConfig = config;
        }
        self.subscriberListener = check new(listenTo, subscriberListenerConfig);
        self.subscriberService = ();
        self.accessToken = ();
    }

    public isolated function attach(SimpleWebhookService s, string[]|string? name = ()) returns error? {
        var configuration = retrieveSubscriberServiceAnnotations(s);
        if (configuration is websub:SubscriberServiceConfiguration) {
            websub:SubscriberServiceConfiguration config = <websub:SubscriberServiceConfiguration> configuration;
            if (config?.httpConfig is http:ClientConfiguration) {
                http:ClientConfiguration clientConfig = <http:ClientConfiguration> config?.httpConfig;
                if (clientConfig.auth is http:ClientAuthConfig) {
                    http:ClientAuthConfig auth = <http:ClientAuthConfig> clientConfig.auth;
                    self.accessToken = auth?.token;
                }
            }
            self.subscriberService = new WebSubService(s);
            check self.subscriberListener.attachWithConfig(<websub:SubscriberService>self.subscriberService, configuration, name);
        } else {
            return error ListenerError("Could not find the required service-configurations");
        }
    }

    public isolated function detach(SimpleWebhookService s) returns error? {
        check self.subscriberListener.detach(<WebSubService>self.subscriberService);
    }

    public isolated  function 'start() returns error? {
        check self.subscriberListener.'start();
    }

    public isolated function gracefulStop() returns error? {
        check self.deleteWebhook();
        return self.subscriberListener.gracefulStop();
    }

    public isolated function immediateStop() returns error? {
        check self.deleteWebhook();
        return self.subscriberListener.immediateStop();
    }

    private isolated function deleteWebhook() returns error? {
        if (self.subscriberService is WebSubService) {
            WebSubService websubService = <WebSubService>self.subscriberService;
            string? endpoint = websubService.deleteWebhookEndpoint;
            if(endpoint is string){
                http:Request request = new;
                if(self.accessToken is string) {
                    request.setHeader("Authorization", "token " + <string>self.accessToken);
                    http:Client httpClient = check new (GITHUB_REST_API_BASE_URL, {});
                    http:Response result = check httpClient->delete(endpoint, request);
                    if (result.statusCode == 204) {
                        log:printInfo("Webhook deleted!");
                    }else {
                        log:printError("Webhook deletion failed : "+ check result.getTextPayload());
                    }
                }
            }
        }
    }
}

isolated function retrieveSubscriberServiceAnnotations(SimpleWebhookService serviceType) returns websub:SubscriberServiceConfiguration? {
    typedesc<any> serviceTypedesc = typeof serviceType;
    return serviceTypedesc.@websub:SubscriberServiceConfig;
}

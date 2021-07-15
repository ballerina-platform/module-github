
## Overview

The GitHub Listener module allows you to listen to following events occur in GitHub. 
- `Ping`, `Fork`, `Push`, `Create`, `Watch`
- `Release`, `Issue`, `Label`, `Milestone`
- `Pull Request`, `Pull Request Review`, `Pull Request Review Comment`


## Configuring connector
### Prerequisites
- GitHub account

### Obtaining tokens

Follow the [steps](https://docs.github.com/en/github/authenticating-to-github/keeping-your-account-and-data-secure/creating-a-personal-access-token)  to obtain a Personal Access Token in order to access the API.

## Quickstart

### Step 1: Import the GitHub Webhook Ballerina library.
First, import the `ballerinax/github.webhook` module and `ballerina/websub` module into a ballerina project.
```ballerina
    import ballerina/websub;
    import ballerinax/github.webhook as github;
```

### Step 2: Initialize the GitHub Webhook Listener.
Initialize the Webhook Listener by providing the port number.

```ballerina
    listener github:Listener webhookListener = new (9090);
```

### Step 3: Annotate the service with websub:SubscriberServiceConfig.
Annotate the service with `websub:SubscriberServiceConfig` providing necessary properties.

```ballerina
@websub:SubscriberServiceConfig {
    target: [github:HUB, githubTopic],
    secret: githubSecret,
    callback: githubCallback,
    httpConfig: {
        auth: {
            token: accessToken
        }
    }
}
service /subscriber on webhookListener {
   
}
```

### Step 4: Provide remote functions corresponding to the events which you are interested on.

```ballerina
    remote function onPush(github:PushEvent event) returns github:Acknowledgement? {
        log:printInfo("Received push-event-message ", eventPayload = event);
    }
```

## Snippets
Snippets of some operations.

- Trigger on create issue
    ```ballerina
    remote function onIssuesOpened(github:IssuesEvent event) returns github:Acknowledgement? {
        log:printInfo("Issue opened", notificationMsg = event);
    }
    ```

- Trigger on issue comment create
    ``` ballerina
    remote function onIssueCommentCreated(github:IssuesCommentEvent event) returns github:Acknowledgement? {
        log:printInfo("Issue comment created", notificationMsg = event);
    }
    ```

- Trigger on pull request open
    ```ballerina
    remote function onPullRequestOpened(github:PullRequestEvent event) returns github:Acknowledgement? {
        log:printInfo("Pull request opened", notificationMsg = event);
    }
    ```

- Trigger on issue assigned
    ```ballerina
    remote function onIssuesAssigned(github:IssuesEvent event) returns github:Acknowledgement? {
        log:printInfo("Issue assigned", notificationMsg = event);
    }
    ```

- Trigger on milestone closed
    ```ballerina
    remote function onMilestoneClosed(github:MilestoneEvent event) returns github:Acknowledgement? {
        log:printInfo("Milestone closed", notificationMsg = event);
    }
    ```

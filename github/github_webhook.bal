// Copyright (c) 2018, WSO2 Inc. (http://www.wso2.org) All Rights Reserved.
//
// WSO2 Inc. licenses this file to you under the Apache License,
// Version 2.0 (the "License"); you may not use this file except
// in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing,
// software distributed under the License is distributed on an
// "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
// KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations
// under the License.
import ballerina/http;
import ballerina/websub;

documentation {
    The WebSub Hub URL for GitHub.
}
@final public string HUB = "https://api.github.com/hub";

@final string TOPIC_HEADER = "X-GitHub-Event";

//////////////////////////////////////////////////////////
/// GitHub Webhook Service (WebSub Subscriber Service) ///
//////////////////////////////////////////////////////////
documentation {
    The object representing the GitHub Webhook Service.
}
public type WebhookService object {

    public function getEndpoint() returns (WebhookListener) {
        WebhookListener ep = new;
        return ep;
    }

};

////////////////////////////////////////////////////////////////////
/// GitHub Webhook Endpoint (WebSub Subscriber Service Endpoint) ///
////////////////////////////////////////////////////////////////////
documentation {
    Object representing the GitHub Webhook (WebSub Subscriber Service) Endpoint.

    E{{}}
    F{{webhookListenerConfig}}  The configuration for the endpoint
}
public type WebhookListener object {

    public WebhookListenerConfiguration webhookListenerConfig;

    private websub:Listener websubListener;

    public new() {
        websubListener = new;
    }

    documentation {
        Gets called when the endpoint is being initialized during package init.

        P{{config}} The SubscriberServiceEndpointConfiguration of the endpoint
    }
    public function init(WebhookListenerConfiguration config);

    documentation {
        Gets called whenever a service attaches itself to this endpoint and during package init.

        P{{serviceType}}    The service attached
    }
    public function register(typedesc serviceType);

    documentation {
        Starts the registered service.
    }
    public function start();

    documentation {
        Returns the connector that client code uses.

        R{{}}   The connector that client code uses
    }
    public function getCallerActions() returns http:Connection;

    documentation {
        Stops the endpoint.
    }
    public function stop();

};

documentation {
    Object representing the configuration for the GitHub Webhook Listener.

    F{{host}}   The host name/IP of the endpoint
    F{{port}}   The port to which the endpoint should bind to
}
public type WebhookListenerConfiguration record {
    string host,
    int port,
};

function WebhookListener::init(WebhookListenerConfiguration config) {
    self.webhookListenerConfig = config;
    websub:ExtensionConfig extensionConfig = {
        topicIdentifier: websub:TOPIC_ID_HEADER_AND_PAYLOAD,
        topicHeader: TOPIC_HEADER,
        headerResourceMap: GITHUB_TOPIC_HEADER_RESOURCE_MAP,
        headerAndPayloadKeyResourceMap: GITHUB_TOPIC_HEADER_AND_PAYLOAD_KEY_RESOURCE_MAP
    };
    websub:SubscriberServiceEndpointConfiguration sseConfig = { host: config.host, port: config.port,
                                                                extensionConfig: extensionConfig };
    self.websubListener.init(sseConfig);
}

function WebhookListener::register(typedesc serviceType) {
    self.websubListener.register(serviceType);
}

function WebhookListener::start() {
    self.websubListener.start();
}

function WebhookListener::getCallerActions() returns http:Connection {
    return self.websubListener.getCallerActions();
}

function WebhookListener::stop () {
    self.websubListener.stop();
}


@final map<(string, typedesc)> GITHUB_TOPIC_HEADER_RESOURCE_MAP = {
    "ping" : ("onPing", PingEvent),
    "commit_comment" : ("onCommitComment", CommitCommentEvent),
    "fork" : ("onFork", ForkEvent),
    "github_app_authorization" : ("onGitHubAppAuthorization", GitHubAppAuthorizationEvent),
    "gollum" : ("onGollum", GollumEvent),
    "push" : ("onPush", PushEvent),
    "release" : ("onRelease", ReleaseEvent),
    "team_add" : ("onTeamAdd", TeamAddEvent),
    "watch" : ("onWatch", WatchEvent)
};

@final map<map<map<(string, typedesc)>>> GITHUB_TOPIC_HEADER_AND_PAYLOAD_KEY_RESOURCE_MAP = {
    "create" : {
        "ref_type" : {
            "repository" : ("onCreateRepository", CreateEvent),
            "branch" : ("onCreateBranch", CreateEvent),
            "tag" : ("onCreateTag", CreateEvent)
        }
    },
    "delete" : {
        "ref_type" : {
            "branch" : ("onDeleteBranch", DeleteEvent),
            "tag" : ("onDeleteTag", DeleteEvent)
        }
    },
    "installation" : {
        "action" : {
            "created" : ("onInstallationCreated", DeleteEvent),
            "deleted" : ("onInstallationDeleted", DeleteEvent)
        }
    },
    "issue_comment" : {
        "action" : {
            "created" : ("onIssueCommentCreated", IssueCommentEvent),
            "edited" : ("onIssueCommentEdited", IssueCommentEvent),
            "deleted" : ("onIssueCommentDeleted", IssueCommentEvent)
        }
    },
    "issues" : {
        "action" : {
            "assigned" : ("onIssuesAssigned", IssuesEvent),
            "unassigned" : ("onIssuesUnassigned", IssuesEvent),
            "labeled" : ("onIssuesLabeled", IssuesEvent),
            "unlabeled" : ("onIssuesUnlabeled", IssuesEvent),
            "opened" : ("onIssuesOpened", IssuesEvent),
            "edited" : ("onIssuesEdited", IssuesEvent),
            "milestoned" : ("onIssuesMilestoned", IssuesEvent),
            "demilestoned" : ("onIssuesDemilestoned", IssuesEvent),
            "closed" : ("onIssuesClosed", IssuesEvent),
            "reopened" : ("onIssuesReopened", IssuesEvent)
        }
    },
    "label" : {
        "action" : {
            "created" : ("onLabelCreated", LabelEvent),
            "edited" : ("onLabelEdited", LabelEvent),
            "deleted" : ("onLabelDeleted", LabelEvent)
        }
    },
    "member" : {
        "action" : {
            "created" : ("onMemberCreated", MemberEvent),
            "edited" : ("onMemberEdited", MemberEvent),
            "deleted" : ("onMemberDeleted", MemberEvent)
        }
    },
    "membership" : {
        "action" : {
            "added" : ("onMembershipAdded", MembershipEvent),
            "removed" : ("onMembershipRemoved", MembershipEvent)
        }
    },
    "milestone" : {
        "action" : {
            "created" : ("onMilestoneCreated", MilestoneEvent),
            "closed" : ("onMilestoneClosed", MilestoneEvent),
            "opened" : ("onMilestoneOpened", MilestoneEvent),
            "edited" : ("onMilestoneEdited", MilestoneEvent),
            "deleted" : ("onMilestoneDeleted", MilestoneEvent)
        }
    },
    "organization" : {
        "action" : {
            "member_added" : ("onOrganizationMemberAdded", OrganizationEvent),
            "member_removed" : ("onOrganizationMemberRemoved", OrganizationEvent),
            "member_invited" : ("onOrganizationMemberInvited", OrganizationEvent)
        }
    },
    "project_card" : {
        "action" : {
            "created" : ("onProjectCardCreated", ProjectCardEvent),
            "edited" : ("onProjectCardEdited", ProjectCardEvent),
            "converted" : ("onProjectCardConverted", ProjectCardEvent),
            "moved" : ("onProjectCardMoved", ProjectCardEvent),
            "deleted" : ("onProjectCardDeleted", ProjectCardEvent)
        }
    },
    "project_column" : {
        "action" : {
            "created" : ("onProjectColumnCreated", ProjectColumnEvent),
            "edited" : ("onProjectColumnEdited", ProjectColumnEvent),
            "moved" : ("onProjectColumnMoved", ProjectColumnEvent),
            "deleted" : ("onProjectColumnDeleted", ProjectColumnEvent)
        }
    },
    "project" : {
        "action" : {
            "created" : ("onProjectCreated", ProjectEvent),
            "edited" : ("onProjectEdited", ProjectEvent),
            "closed" : ("onProjectClosed", ProjectEvent),
            "reopened" : ("onProjectReopened", ProjectEvent),
            "deleted" : ("onProjectDeleted", ProjectEvent)
        }
    },
    "pull_request" : {
        "action" : {
            "assigned" : ("onPullRequestAssigned", PullRequestEvent),
            "unassigned" : ("onPullRequestUnassigned", PullRequestEvent),
            "review_requested" : ("onPullRequestReviewRequested", PullRequestEvent),
            "review_request_removed" : ("onPullRequestReviewRequestRemoved", PullRequestEvent),
            "labeled" : ("onPullRequestLabeled", PullRequestEvent),
            "unlabeled" : ("onPullRequestUnlabeled", PullRequestEvent),
            "opened" : ("onPullRequestOpened", PullRequestEvent),
            "edited" : ("onPullRequestEdited", PullRequestEvent),
            "closed" : ("onPullRequestClosed", PullRequestEvent),
            "reopened" : ("onPullRequestReopened", PullRequestEvent)
        }
    },
    "pull_request_review" : {
        "action" : {
            "submitted" : ("onPullRequestReviewSubmitted", PullRequestReviewEvent),
            "edited" : ("onPullRequestReviewEdited", PullRequestReviewEvent),
            "dismissed" : ("onPullRequestReviewDismissed", PullRequestReviewEvent)
        }
    },
    "pull_request_review_comment" : {
        "action" : {
            "created" : ("onPullRequestReviewCommentCreated", PullRequestReviewCommentEvent),
            "edited" : ("onPullRequestReviewCommentEdited", PullRequestReviewCommentEvent),
            "deleted" : ("onPullRequestReviewCommentDeleted", PullRequestReviewCommentEvent)
        }
    },
    "repository" : {
        "action" : {
            "created" : ("onRepositoryCreated", RepositoryEvent),
            "deleted" : ("onRepositoryDeleted", RepositoryEvent),
            "archived" : ("onRepositoryArchived", RepositoryEvent),
            "unarchived" : ("onRepositoryUnarchived", RepositoryEvent),
            "publicized" : ("onRepositoryPublicized", RepositoryEvent),
            "privatized" : ("onRepositoryPrivatized", RepositoryEvent)
        }
    },
    "repository_vulnerability_alert" : {
        "action" : {
            "create" : ("onRepositoryVulnerabilityAlertCreated", RepositoryVulnerabilityAlertEvent),
            "dismiss" : ("onRepositoryVulnerabilityAlertDismissed", RepositoryVulnerabilityAlertEvent),
            "resolve" : ("onRepositoryVulnerabilityAlertResolved", RepositoryVulnerabilityAlertEvent)
        }
    }
};
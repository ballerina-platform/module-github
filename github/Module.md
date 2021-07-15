
## Overview

Ballerina connector for GitHub is connecting the GitHub GraphQL API via Ballerina language easily. It provides capability to perform operations on major resource types such as `Repositories`, `Issues`, `Pull Requests`, `Projects` etc.

This module supports [GitHub API](https://docs.github.com/en/graphql) v4 version and only allows to perform functions behalf of the currently logged in user.


## Configuring connector
### Prerequisites
- GitHub account

### Obtaining tokens

Follow the [steps](https://docs.github.com/en/github/authenticating-to-github/keeping-your-account-and-data-secure/creating-a-personal-access-token)  to obtain a Personal Access Token in order to access the API.

## Quickstart

#### Step 1: Import GitHub module
First, import the ballerinax/github module into the Ballerina project.
```ballerina
import ballerinax/github;
```
#### Step 2: Configure the connection credentials.
You can now make the connection configuration using the OAuth2 refresh token grant config.
```ballerina

    github:Configuration config = {
        token: accessToken
    };

    github:Client githubClient = new (config);

```

## Snippets
Snippets of some operations.

- Get Authenticated User Repositories
    ```ballerina
    github:RepositoryList response = check githubClient->getUserRepositoryList(<GitHub_Username>, <Per_Page_Count>);
    ```

- Create An Issue
    ``` ballerina
    github:CreateIssueInput createIssueInput = {
        title: <Issue_Title>,
        body: <Issue_Body>,
        labelNames: ["<Label_Name>"],
        assigneeNames: [<Assignee_GitHub_Username>],
        projectIds: [<ProjectId>],
        milestoneId: <MilestoneId>
    };

    github:Issue createdIssue = check githubClient->createIssue(createIssueInput, <GitHub_Username>, <GitHub_Repository_Name>);
    ```

- Get Issues With A Label
    ```ballerina
    github:IssueList response = check githubClient->getIssuesWithLabel(<GitHub_Username>, <GitHub_Repository_Name>, <Label_Name>, <Per_Page_Count>);
    ```

- Add Comment To An Issue
    ```ballerina
    github:AddIssueCommentInput addIssueCommentInput = {
        repositoryOwnerName: <GitHub_Username>,
        repositoryName: <GitHub_Repository_Name>,
        issueNumber: <Issue_Number>,
        body: <Comment_Message>
    };
    github:IssueComment response = check githubClient->addComment(addIssueCommentInput);
    ```

- Get All Open Pull Requests In A Repository
    ```ballerina
    github:PullRequestList response = check githubClient->getRepositoryPullRequestList(<GitHub_Username>, <GitHub_Repository_Name>, github:PULL_REQUEST_OPEN, <Per_Page_Count>);
    ```

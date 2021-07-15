// Copyright (c) 2021, WSO2 Inc. (http://www.wso2.org) All Rights Reserved.
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

# GitHub Client.
# + accessToken - The access token of the github account
# + githubGraphQlClient - HTTP client endpoint
# + headers - Request Header map
@display { label: "GitHub Client",iconPath:"GithubLogo.png" }
public client class Client {
    string accessToken;
    http:Client githubGraphQlClient;
    map<string> headers;

    # Client initialization.
    #
    # + config - Configurations required to initialize the `Client`
    # + return -  Error at failure of client initialization
    public isolated function init(Configuration config) returns error? {
        self.accessToken = config.accessToken;
        self.githubGraphQlClient = check new(GIT_GRAPHQL_API_URL, config.clientConfig);
        self.headers = {
           AUTHORIZATION_HEADER: TOKEN + self.accessToken
        };
    }

    # Get authenticated user
    #
    # + return - `User` record if successful else `error`
    @display { label: "Get Authenticated User" }
    remote isolated function getAuthenticatedUser()  returns @display {label: "Authenticated User"} 
                                                  @tainted User|error {

        string stringQuery = getFormulatedStringQueryForGetAuthenticatedUser();
        http:Request request = new;
        setHeader(request, self.accessToken);
        json convertedQuery = check stringToJson(stringQuery);
        //Set headers and payload to the request
        constructRequest(request, <@untainted> convertedQuery);

        http:Response response = check self.githubGraphQlClient->post(EMPTY_STRING, request);

        //Check for empty payloads and errors
        json validatedResponse = check getValidatedResponse(response);

        if (validatedResponse is map<json>) {
            var gitData = validatedResponse[GIT_DATA];
            if (gitData is map<json>) {
                var viewer = gitData[GIT_VIEWER];
                if (viewer is map<json>) {
                    User user = check viewer.cloneWithType(User);
                    return user;
                }
            }
        }
        error err = error(GITHUB_ERROR_CODE, message = "Error parsing git user response");
        return err;
    }

    # Get User Id
    # 
    # + userName - GitHub username
    # 
    # + return - User Id
    @display { label: "Get User Id" }
    remote isolated function getUserId(@display {label: "User name"} string userName) 
                                       returns @display {label: "User Id"} @tainted string|error {
        return getUserId(userName, self.accessToken, self.githubGraphQlClient);
    }

    # Get user repository
    # 
    # + username - GitHub repository owner name
    # + repositoryName - GitHub repository name
    # 
    # + return - `Repository` record if successful else `error`
    @display { label: "Get Repository" }
    remote isolated function getUserRepository(@display {label: "Repository Owner Name"} string username, 
                                               @display {label: "Repository Name"} string repositoryName) 
                                               returns @display {label: "Repository"} @tainted Repository|error {
        return getUserRepository(username, repositoryName, self.accessToken, self.githubGraphQlClient);
    }


    // Repositories

    # Get authenticated user repository list
    # 
    # + perPageCount - Per page record count
    # + nextPageCursor - Next page token
    # 
    # + return - `RepositoryList` record if successful else `error`
    @display { label: "Get Repositories" }
    remote isolated function getAuthenticatedUserRepositoryList(@display {label: "Per Page Count"} int perPageCount, 
                                                                @display {label: "Next Page Cursor"} 
                                                                string? nextPageCursor=()) 
                                                                returns @display {label: "Repository List"} 
                                                                @tainted RepositoryList|error {
        return getAuthenticatedUserRepositoryList(perPageCount, self.accessToken, self.githubGraphQlClient, 
                                                  nextPageCursor);

    }

    # Get user repository list
    # 
    # + username - Repository owner name
    # + perPageCount - Per page record count
    # + nextPageCursor - Next page token
    # 
    # + return - `RepositoryList` record if successful else `error`
    @display { label: "Get User Repositories" }
    remote isolated function getUserRepositoryList(@display {label: "Repository Owner Name"} string username, 
                                                   @display {label: "Per Page Count"} int perPageCount, 
                                                   @display {label: "Next Page Cursor"} string? nextPageCursor = ())
                                                   returns @display {label: "Repository List"} @tainted 
                                                   RepositoryList|error {
        return getUserRepositoryList(username, perPageCount, self.accessToken, self.githubGraphQlClient, 
                                     nextPageCursor);
    }

    # Get organization repository list
    # 
    # + organizationName - Organization GitHub username
    # + perPageCount - Per page record count
    # + nextPageCursor - Next page token
    # 
    # + return - `RepositoryList` record if successful else `error`
    @display { label: "Get Organization Repositories" }
    remote isolated function getOrganizationRepositoryList(@display {label: "Organization Name"} 
                                                           string organizationName, 
                                                           @display {label: "Per Page Count"} int perPageCount,
                                                           @display {label: "Next Page Cursor"} 
                                                           string? nextPageCursor = ()) 
                                                           returns @display {label: "Repository List"} 
                                                           @tainted RepositoryList|error {
        return getOrganizationRepositoryList(organizationName, perPageCount, self.accessToken, 
                                             self.githubGraphQlClient, nextPageCursor);
    }

    # Get repository collaborator list
    # 
    # + ownerName - Repository owner username
    # + repositoryName - Repository name
    # + perPageCount - Per page record count
    # + nextPageCursor - Next page token
    # 
    # + return - `CollaboratorList` record if successful else `error`
    @display { label: "Get Collaborators" }
    remote isolated function getRepositoryCollobaratorList(@display {label: "Repository Owner Name"} string ownerName,
                                                           @display {label: "Repository Name"} string repositoryName,
                                                           @display {label: "Per Page Count"} int perPageCount, 
                                                           @display {label: "Next Page Cursor"} 
                                                           string? nextPageCursor = ()) 
                                                           returns @display {label: "Collaborator List"} @tainted 
                                                           CollaboratorList|error {
        return getRepositoryCollobaratorList(ownerName, repositoryName, perPageCount, self.accessToken, 
                                             self.githubGraphQlClient, nextPageCursor);

    }

    # Get repository branch list
    # 
    # + ownerName - Repository owner name
    # + repositoryName - Repository name
    # + perPageCount - Per page record count
    # + nextPageCursor - Next page token
    # 
    # + return - `BranchList` record if success else `error`
    @display { label: "Get Branch List" }
    remote isolated function getRepositoryBranchList(@display {label: "Repository Owner Name"} string ownerName,
                                                     @display {label: "Repository Name"} string repositoryName, 
                                                     @display {label: "Per Page Count"} int perPageCount, 
                                                     @display {label: "Next Page Cursor"} string? nextPageCursor = ())
                                                     returns @display {label: "Branch List"} 
                                                     @tainted BranchList|error {
        return getRepositoryBranchList(ownerName, repositoryName, perPageCount, self.accessToken, 
                                       self.githubGraphQlClient, nextPageCursor);
    }

    # Create repository
    # 
    # + createRepositoryInput - Create repository input
    # 
    # + return - `error` if not successful
    @display { label: "Create Repository" }
    remote isolated function createRepository(@display {label: "Create Repository Input"} 
                                              @tainted CreateRepositoryInput createRepositoryInput)
                                              returns @tainted error? {
        return createRepository(createRepositoryInput, self.accessToken, 
                                 self.githubGraphQlClient);
    }

    # Update repository
    # 
    # + updateRepositoryInput - Update repository input
    # + repositoryOwnerName - Repository owner name
    # + repositoryName - Repository name
    # 
    # + return - `error` if not successful
    @display { label: "Update Repository" }
    remote isolated function updateRepository(@display {label: "Update Repository Input"} 
                                              @tainted UpdateRepositoryInput updateRepositoryInput, 
                                              @display {label: "Repository Owner Name"} string repositoryOwnerName,
                                              @display {label: "Repository Name"} string repositoryName) 
                                              returns @tainted error? {
        return  updateRepository(updateRepositoryInput, repositoryOwnerName, repositoryName, self.accessToken, 
                                 self.githubGraphQlClient);
    }


    // Issues

    # Get repository issue list assigned to user
    # 
    # + repositoryOwnerName - Repository owner name
    # + repositoryName - Repository name
    # + assignee - Issue assignee username
    # + perPageCount - Per page record count
    # + nextPageCursor - Next page token
    # 
    # + return - `IssueList` record if successful else `error`
    @display { label: "Get Issues Assigned To User" }
    remote isolated function getRepositoryIssueListAssignedToUser(@display {label: "Repository Owner Name"} 
                                                                  string repositoryOwnerName, 
                                                                  @display {label: "Repository Name"} 
                                                                  string repositoryName, 
                                                                  @display {label: "Assignee User Name"} 
                                                                  string assignee, 
                                                                  @display {label: "Per Page Count"} int perPageCount,
                                                                  @display {label: "Next Page Cursor"} 
                                                                  string? nextPageCursor = ()) 
                                                                  returns @display {label: "Issue List"} 
                                                                  @tainted IssueList|error {
        return getRepositoryIssueListAssignedToUser(repositoryOwnerName, repositoryName, assignee, perPageCount, 
                                                    self.accessToken, self.githubGraphQlClient, nextPageCursor);

    }

    # Get repository issue list
    # 
    # + repositoryOwnerName - Repository owner name
    # + repositoryName - Repository name
    # + states - Array of issue states
    # + perPageCount - Per page record count
    # + nextPageCursor - Next page token
    # 
    # + return - `IssueList` record if successful else `error`
    @display { label: "Get Issues" }
    remote isolated function getRepositoryIssueList(@display {label: "Repository Owner Name"} 
                                                    string repositoryOwnerName, 
                                                    @display {label: "Repository Name"} string repositoryName, 
                                                    @display {label: "Issue States"} IssueState[] states, 
                                                    @display {label: "Per Page Count"} int perPageCount, 
                                                    @display {label: "Next Page Cursor"} string? nextPageCursor = ())
                                                    returns @display {label: "Issue List"} @tainted IssueList|error {
        return getRepositoryIssueList(repositoryOwnerName, repositoryName, states, perPageCount, self.accessToken, 
                                      self.githubGraphQlClient, nextPageCursor);
    }

    # Create issue
    # 
    # + createIssueInput - `CreateIssueInput` record
    # + repositoryOwnerName - Repository owner name
    # + repositoryName - Repository name
    # 
    # + return - `Issue` record if successful else `error`
    @display { label: "Create Issue" }
    remote isolated function createIssue(@display {label: "Create Issue Input"} @tainted 
                                         CreateIssueInput createIssueInput, 
                                         @display {label: "Repository Owner Name"} string repositoryOwnerName, 
                                         @display {label: "Repository Name"} string repositoryName) 
                                         returns @display {label: "Issue"} @tainted Issue|error {
        return createIssue(createIssueInput, repositoryOwnerName, repositoryName, self.accessToken, 
                           self.githubGraphQlClient);
    }

    # Update issue
    # 
    # + updateIssueInput - `UpdateIssueInput` record
    # + repositoryOwnerName - Repository owner name
    # + repositoryName - Repository name
    # + issueNumber - Issue number of the issue to be updated
    # 
    # + return - `Issue` record if successful else `error`
    @display { label: "Update Issue" }
    remote isolated function updateIssue(@display {label: "Update Issue Input"} @tainted 
                                         UpdateIssueInput updateIssueInput,
                                         @display {label: "Repository Owner Name"} string repositoryOwnerName, 
                                         @display {label: "Repository Name"} string repositoryName, 
                                         @display {label: "Issue Number"} int issueNumber) 
                                         returns @display {label: "Issue"} @tainted Issue|error {
        return  updateIssue(updateIssueInput, repositoryOwnerName, repositoryName, issueNumber, self.accessToken, 
                            self.githubGraphQlClient);
    }

    # Get repository issue
    # 
    # + repositoryOwnerName - Repository owner name
    # + repositoryName - repositoryName
    # + issueNumber - Issue number
    # 
    # + return - `Issue` record if successful else `error`
    @display { label: "Get Issue" }
    remote isolated function getRepositoryIssue(@display {label: "Repository Owner Name"} string repositoryOwnerName,
                                                @display {label: "Repository Name"} string repositoryName, 
                                                @display {label: "Issue Number"} int issueNumber) 
                                                returns @display {label: "Issue"} @tainted Issue|error {
        return getRepositoryIssue(repositoryOwnerName, repositoryName, issueNumber, self.accessToken, 
                                  self.githubGraphQlClient);
    }

    # Get repository issue comment list
    # 
    # + repositoryOwnerName - Repository owner name
    # + repositoryName - Repository name
    # + issueNumber - Issue number
    # + perPageCount - Per page record count
    # + nextPageCursor - Next page token
    # 
    # + return - `IssueCommentList` if successful else `error`
    @display { label: "Get Issue Comments" }
    remote isolated function getRepositoryIssueCommentList(@display {label: "Repository Owner Name"} 
                                                           string repositoryOwnerName, 
                                                           @display {label: "Repository Name"} string repositoryName, 
                                                           @display {label: "Issue Number"} int issueNumber, 
                                                           @display {label: "Per Page Count"}int perPageCount, 
                                                           @display {label: "Next Page Cursor"} 
                                                           string? nextPageCursor=()) 
                                                           returns @display {label: "Issue Comment List"} 
                                                           @tainted IssueCommentList|error {
        return getRepositoryIssueCommentList(repositoryOwnerName, repositoryName, issueNumber, perPageCount, 
                                             self.accessToken, self.githubGraphQlClient, nextPageCursor);
    }

    # Get issue with label
    # 
    # + repositoryOwnerName - Repository owner name
    # + repositoryName - Repository name
    # + labelName - Label name
    # + perPageCount - Per page record count
    # + nextPageCursor - Next page token
    # 
    # + return - `IssueList` record if successful else `error`
    @display { label: "Get Issues With Label" }
    remote isolated function getIssuesWithLabel(@display {label: "Repository Owner Name"} string repositoryOwnerName,
                                                @display {label: "Repository Name"} string repositoryName, 
                                                @display {label: "Label Name"} string labelName, 
                                                @display {label: "Per Page Count"} int perPageCount, 
                                                @display {label: "Next Page Cursor"} string? nextPageCursor=()) 
                                                returns @display {label: "Issue List"} @tainted IssueList|error {
        return getIssuesWithLabel(repositoryOwnerName, repositoryName, labelName, perPageCount, self.accessToken, 
                                  self.githubGraphQlClient, nextPageCursor);
    }


    // Comments

    # Add issue comment
    # 
    # + addIssueCommentInput - `AddIssueCommentInput` record
    # 
    # + return - `IssueComment` if successful else `error`
    @display { label: "Add Issue Comment" }
    remote isolated function addComment(@display {label: "Add Comment Input"} AddIssueCommentInput addIssueCommentInput)
                                        returns @display {label: "Issue Comment"} @tainted IssueComment|error {
        return addComment(addIssueCommentInput, self.accessToken, self.githubGraphQlClient);
    }

    # Update issue comment
    # 
    # + updateCommentInput - `UpdateIssueCommentInput` record
    # 
    # + return - `error` if un-successful
    @display { label: "Update Issue Comment" }
    remote isolated function updateComment(@display {label: "Update Comment Input"} 
                                           UpdateIssueCommentInput updateCommentInput) returns @tainted error? {
        return updateComment(updateCommentInput, self.accessToken, self.githubGraphQlClient);
    }

    # Delete issue comment
    # 
    # + deleteCommentInput - `DeleteCommentInput` record
    # 
    # + return - `error` if un-successful
    @display { label: "Delete Issue Comment" }
    remote isolated function deleteComment(@display {label: "Delete Comment Input"} 
                                           DeleteIssueCommentInput deleteCommentInput) returns @tainted error? {
        return deleteComment(deleteCommentInput, self.accessToken, self.githubGraphQlClient);
    }


    //Labels

    // mutation is in preview state
    // remote isolated function createLabel(CreateLabelInput createLabelInput) returns error? {
    //     return createLabel(createLabelInput, self.accessToken, self.githubGraphQlClient);
    // }

    # Get repository label
    # 
    # + repositoryOwnerName - Repository owner name
    # + repositoryName - Repository name
    # + labelName - Label name
    # 
    # + return - `Label` record if successful else `error`
    @display { label: "Get Label" }
    remote isolated function getRepositoryLabel(@display {label: "Repository Owner Name"} string repositoryOwnerName,
                                                @display {label: "Repository Name"} string repositoryName, 
                                                @display {label: "Label Name"} string labelName) 
                                                returns @display {label: "Label"} @tainted Label|error {
        return getRepositoryLabel(repositoryOwnerName, repositoryName, labelName, self.accessToken, 
                                  self.githubGraphQlClient);
    }

    # Get labels in an issue
    # 
    # + repositoryOwnerName - Repository owner name
    # + repositoryName - Repository name
    # + issueNumber - Issue number
    # + perPageCount - Per page record count
    # + nextPageCursor - Next page token
    # 
    # + return - `LabelList` record if successful else `error`
    @display { label: "Get Labels In Issue" }
    remote isolated function getLabelsInIssue(@display {label: "Repository Owner Name"} string repositoryOwnerName,
                                             @display {label: "Repository Name"} string repositoryName, 
                                             @display {label: "Issue Number"} int issueNumber, 
                                             @display {label: "Per Page Count"} int perPageCount, 
                                             @display {label: "Next Page Cursor"} string? nextPageCursor=()) 
                                             returns @display {label: "Label List"} @tainted LabelList|error {
        return getLabelsInIssue(repositoryOwnerName, repositoryName, issueNumber, perPageCount, self.accessToken, 
                                self.githubGraphQlClient, nextPageCursor);
    }

    # Add labels to an issue
    # 
    # + addIssueLabelsInput - `AddIssueLabelInput` record
    # 
    # + return - `LabelList` record if successful else `error`
    @display { label: "Add Labels To Issue" }
    remote isolated function addIssueLabels(@display {label: "Add Issue Labels Input"} 
                                                  AddIssueLabelsInput addIssueLabelsInput) 
                                                  returns @display {label: "Label List"} @tainted LabelList|error {
        return addIssueLabels(addIssueLabelsInput, self.accessToken, self.githubGraphQlClient);
    }

    # Remove issue labeles
    # 
    # + removeIssueLabelInput - `RemoveIssueLabelInput` record
    # 
    # + return - `error` if failed
    @display { label: "Remove Issue Labels" }
    remote isolated function removeLabelFromLabelable(@display {label: "Remove Issue Label Input"} 
                                                      RemoveIssueLabelInput removeIssueLabelInput) 
                                                      returns @tainted error? {
        return removeLabelFromLabelable(removeIssueLabelInput, self.accessToken, self.githubGraphQlClient);
    }


    // Milestones

    # Get repository milestone list
    # 
    # + repositoryOwnerName - Repository owner name
    # + repositoryName - Repository name
    # + perPageCount - Per page record count
    # + nextPageCursor - Next page token
    # 
    # + return - `MilestoneList` record if successful else `error`
    @display { label: "Get Milestones" }
    remote isolated function getRepositoryMilestoneList(@display {label: "Repository Owner Name"} 
                                                        string repositoryOwnerName, @display {label: "Repository Name"}
                                                        string repositoryName, 
                                                        @display {label: "Per Page Count"} int perPageCount, 
                                                        @display {label: "Next Page Cursor"} string? nextPageCursor=())
                                                        returns @display {label: "Milestone List"} @tainted 
                                                        MilestoneList|error {
        return getRepositoryMilestoneList(repositoryOwnerName, repositoryName, perPageCount, self.accessToken, 
                                          self.githubGraphQlClient, nextPageCursor);
    }

    # Get repository milestone
    # 
    # + repositoryOwnerName - Repository owner name
    # + repositoryName - Repository name
    # + milestoneNumber - Milestone number
    # 
    # + return - `Milestone` record if successful elese `error`
    @display { label: "Get Milestone" }
    remote isolated function getRepositoryMilestone(@display {label: "Repository Owner Name"} 
                                                    string repositoryOwnerName, 
                                                    @display {label: "Repository Name"} string repositoryName, 
                                                    @display {label: "Milestone Number"} int milestoneNumber) 
                                                    returns @display {label: "Milestone"} @tainted Milestone|error {
        return getRepositoryMilestone(repositoryOwnerName, repositoryName, milestoneNumber, self.accessToken, 
                                      self.githubGraphQlClient);
    }


    //Pul Requests

    # Get pull requests 
    # 
    # + repositoryOwnerName - Repository owner name
    # + repositoryName - Repository name
    # + pullRequestNumber - Pull request number
    # 
    # + return - `PullRequest` record if successful else `error`
    @display { label: "Get Pull Request" }
    remote isolated function getPullRequest(@display {label: "Repository Owner Name"} string repositoryOwnerName, 
                                            @display {label: "Repository Name"} string repositoryName, 
                                            @display {label: "Pull Request Number"} int pullRequestNumber) 
                                            returns @display {label: "Pull Request"} @tainted PullRequest|error {
        return getPullRequest(repositoryOwnerName, repositoryName, pullRequestNumber, self.accessToken, 
                              self.githubGraphQlClient);
    }

    # Get repository pull request list
    # 
    # + repositoryOwnerName - Repository owner name
    # + repositoryName - Repository name
    # + state - `Pull request state`
    # + perPageCount - Per page record count
    # + nextPageCursor - Next page token
    # 
    # + return - `PullRequestList` record if successful else `error`
    @display { label: "Get Pull Requests" }
    remote isolated function getRepositoryPullRequestList(@display {label: "Repository Owner Name"} 
                                                          string repositoryOwnerName, 
                                                          @display {label: "Repository Name"} string repositoryName, 
                                                          @display {label: "Pull Request State"} 
                                                          PullRequestState state, 
                                                          @display {label: "Per Page Count"} int perPageCount, 
                                                          @display {label: "Next Page Cursor"} 
                                                          string? nextPageCursor=()) 
                                                          returns @display {label: "Pull Request List"} @tainted 
                                                          PullRequestList|error {
        return getRepositoryPullRequestList(repositoryOwnerName, repositoryName, state, perPageCount, 
                                            self.accessToken, self.githubGraphQlClient, nextPageCursor);
    }

    # Create pull request
    # 
    # + createPullRequestInput - `CreatePullRequestInput` record
    # + repositoryOwnerName - Repository owner name
    # + repositoryName - Repository name
    # 
    # + return - `PullRequest` record if success or else `error`
    @display { label: "Create Pull Request" }
    remote isolated function createPullRequest(@display {label: "Create Pull Request Input"} 
                                               @tainted CreatePullRequestInput createPullRequestInput, 
                                               @display {label: "Repository Owner Name"} string repositoryOwnerName, 
                                               @display {label: "Repository Name"} string repositoryName) 
                                               returns @display {label: "Pull Request"} @tainted PullRequest|error {
        return createPullRequest(createPullRequestInput, repositoryOwnerName, repositoryName, self.accessToken, 
                                 self.githubGraphQlClient);
    }

    # Update pull request
    # 
    # + updatePullRequestInput - `UpdatePullRequestInput` record if successful else `error`
    # + repositoryOwnerName - Repository owner name
    # + repositoryName - Repository name
    # + pullRequestNumber - Pull request number
    # 
    # + return - `PullRequest` record if successful else `error`
    @display { label: "Update Pull Request" }
    remote isolated function updatePullRequest(@display {label: "Update Pull Request Input"} @tainted 
                                               UpdatePullRequestInput updatePullRequestInput, 
                                               @display {label: "Repository Owner Name"} string repositoryOwnerName, 
                                               @display {label: "Repository Name"} string repositoryName, 
                                               @display {label: "Pull Request Number"} int pullRequestNumber) 
                                               returns @display {label: "Pull Request"} @tainted PullRequest|error {
        return updatePullRequest(updatePullRequestInput, repositoryOwnerName, repositoryName, pullRequestNumber, 
                                 self.accessToken, self.githubGraphQlClient);
    }

    # Get pull request review comment list
    # 
    # + repositoryOwnerName - Repository owner name
    # + repositoryName - Repository name
    # + pullRequestNumber - Pull request number
    # + perPageCount - Per page record count
    # + nextPageCursor - Next page token
    # 
    # + return - `PullRequestReviewList` record if successful or else `error`
    @display { label: "Get Pull Request Review Comments" }
    remote isolated function getPullRequestReviewCommentList(@display {label: "Repository Owner Name"} 
                                                             string repositoryOwnerName, 
                                                             @display {label: "Repository Name"} string repositoryName, 
                                                             @display {label: "Pull Request Number"} 
                                                             int pullRequestNumber, 
                                                             @display {label: "Per Page Count"} int perPageCount, 
                                                             @display {label: "Next Page Cursor"} 
                                                             string? nextPageCursor=()) 
                                                             returns @display {label: "Pull Request Review List"}
                                                             @tainted PullRequestReviewList|error {
        return getPullRequestReviewCommentList(repositoryOwnerName, repositoryName, pullRequestNumber, perPageCount, 
                                               self.accessToken, self.githubGraphQlClient, nextPageCursor);

    }

    # Create pull request review 
    # 
    # + addPullRequestReviewInput - `AddPullRequestReviewInput` record
    # + repositoryOwnerName - Repository owner name
    # + repositoryName - Repository name
    # + pullRequestNumber - Pull request number
    # 
    # + return - `PullRequestReview` record
    @display {label: "Create Pull Request Review"}
    remote isolated function createPullRequestReview(@display {label: "Add Pull Request Review Input"} @tainted 
                                                     AddPullRequestReviewInput addPullRequestReviewInput, 
                                                     @display {label: "Repository Owner Name"} 
                                                     string repositoryOwnerName, 
                                                     @display {label: "Repository Name"} string repositoryName,  
                                                     @display {label: "Pull Request Number"} int pullRequestNumber) 
                                                     returns @display {label: "Pull Request Review"} @tainted 
                                                     PullRequestReview|error {
         return createPullRequestReview(addPullRequestReviewInput, repositoryOwnerName, repositoryName, 
                                        pullRequestNumber, self.accessToken, self.githubGraphQlClient);
    }

    # Update pull request review
    # 
    # + updatePullRequestReviewInput - `UpdatePullRequestReviewInput` record
    # 
    # + return - `error` if failed.
    @display {label: "Update Pull Request Review"}
    remote isolated function updatePullRequestReview(@display {label: "Update Pull Request Review"} 
                                                     UpdatePullRequestReviewInput updatePullRequestReviewInput) 
                                                     returns @tainted error? {
        return updatePullRequestReview(updatePullRequestReviewInput, self.accessToken, self.githubGraphQlClient);
    }

    # Delete pending pull request review
    # 
    # + deletePullRequestReview - `DeletePullRequestReviewInput` record
    # 
    # + return - `error` if failed
    @display {label: "Delete Pull Request Review"}
    remote isolated function deletePendingPullRequestReview(@display {label: "Delete Pull Request Review Input"}
                                                            DeletePullRequestReviewInput deletePullRequestReview) 
                                                            returns @tainted error? {
        return deletePendingPullRequestReview(deletePullRequestReview, self.accessToken, self.githubGraphQlClient);
    }


    // Projects

    # Get organization project list
    # 
    # + organizationName - Organization name
    # + state - Project state
    # + perPageCount - Per page record count
    # + nextPageCursor - Next page token
    # 
    # + return - `ProjectList` record if successful 
    @display { label: "Get Organization Projects" }
    remote isolated function getOrganizationProjectList(@display {label: "Organization Name"} string organizationName, 
                                                        @display {label: "Project State"} ProjectState state, 
                                                        @display {label: "Per Page Count"} int perPageCount, 
                                                        @display {label: "Next Page Cursor"} string? nextPageCursor=()) 
                                                        returns @display {label: "Project List"} @tainted 
                                                        ProjectList|error {
        return getOrganizationProjectList(organizationName, state, perPageCount, self.accessToken, 
                                          self.githubGraphQlClient, nextPageCursor);
    }

    # Create project
    # 
    # + createRepositoryProjectInput - `CreateRepositoryProjectInput` record
    # 
    # + return - `Project` record if successful else `error`
    @display { label: "Create Project" }
    remote isolated function createProject(@display {label: "Create Project Input"} 
                                           CreateRepositoryProjectInput createRepositoryProjectInput) 
                                           returns @display {label: "Project"} @tainted Project|error {
        return createProject(createRepositoryProjectInput, self.accessToken, self.githubGraphQlClient);
    }

    # Get user project
    # 
    # + username - Project owner name
    # + projectNumber - Project number
    # 
    # + return - `Project`
    @display { label: "Get Project" }
    remote isolated function getUserProject(@display {label: "Project Owner Name"} string username, 
                                            @display {label: "Project Number"} int projectNumber) 
                                            returns @display {label: "Project"} @tainted Project|error {
        return getUserProject(username, projectNumber, self.accessToken, self.githubGraphQlClient);
    }

    # Update project
    # 
    # + updateProjectInput - `UpdateProjectInput`
    # 
    # + return - `Project` record if successful or else `error`
    @display { label: "Update Project" }
    remote isolated function updateProject(@display {label: "Update Project Input"} 
                                           UpdateProjectInput updateProjectInput) 
                                           returns @display {label: "Project"} @tainted Project|error {
        return updateProject(updateProjectInput, self.accessToken, self.githubGraphQlClient);
    }

    # Delete project
    # 
    # + deleteProjectInput - `DeleteProjectInput` record
    # 
    # + return - `error` if failed
    @display { label: "Delete Project" }
    remote isolated function deleteProject(@display {label: "Delete Project Input"} 
                                           DeleteProjectInput deleteProjectInput) returns @tainted error? {
        return deleteProject(deleteProjectInput, self.accessToken, self.githubGraphQlClient);
    }

    # Get Repository project list
    # 
    # + repositoryOwner - Repository owner name
    # + repositoryName - Repository name
    # + state - Project state
    # + perPageCount - Per page record count
    # + nextPageCursor - Next page token
    # 
    # + return - `ProjectList` record if successful or else `error`
    @display { label: "Get Repository Projects" }
    remote isolated function getRepositoryProjectList(@display {label: "Repository Owner Name"} string repositoryOwner, 
                                                      @display {label: "Repository Name"} string repositoryName, 
                                                      @display {label: "Project State"} ProjectState state, 
                                                      @display {label: "Per Page Count"} int perPageCount, 
                                                      @display {label: "Next Page Cursor"} string? nextPageCursor=()) 
                                                      returns @display {label: "Project List"} @tainted 
                                                      ProjectList|error {
        return getRepositoryProjectList(repositoryOwner, repositoryName, state, perPageCount, self.accessToken, 
                                        self.githubGraphQlClient, nextPageCursor);
    }

    # Get user project list
    # 
    # + username - Project owner name
    # + perPageCount - Per page record count
    # + nextPageCursor - Next page token
    # 
    # + return - `ProjectList` record if successful or else `error`
    @display { label: "Get User Projects" }
    remote isolated function getUserProjectList(@display {label: "Project Owner Name"} string username, 
                                                @display {label: "Per Page Count"} int perPageCount, 
                                                @display {label: "Next Page Cursor"} string? nextPageCursor=()) 
                                                returns @display {label: "Project List"} @tainted ProjectList|error {
        return getUserProjectList(username, perPageCount, self.accessToken, self.githubGraphQlClient, nextPageCursor);
    }


    // Organizations

    # Get a organization
    # 
    # + organizationName - Organization name
    # 
    # + return - `Organization` record if successful or else `error`
    @display { label: "Get Organization" }
    remote isolated function getOrganization(@display {label: "Organization Name"} string organizationName) 
                                             returns @display {label: "Organization"} @tainted Organization|error {
        return getOrganization(organizationName, self.accessToken, self.githubGraphQlClient);
    }

    # Get user organization list
    # 
    # + username - Organization username
    # + perPageCount - Per page record count
    # + nextPageCursor - Next page token
    # 
    # + return - `OrganizationList` record or else `error`
    @display { label: "Get User Organization List" }
    remote isolated function getUserOrganizationList(@display {label: "Organization Username"} string username, 
                                                     @display {label: "Per Page Count"} int perPageCount, 
                                                     @display {label: "Next Page Cursor"} string? nextPageCursor=()) 
                                                     returns @display {label: "Organization List"} @tainted 
                                                     OrganizationList|error {
        return getUserOrganizationList(username, perPageCount, self.accessToken, self.githubGraphQlClient, 
                                       nextPageCursor);
    }

    # Get organization member list
    # 
    # + organizationName - Organization username
    # + perPageCount - Per page record count
    # + nextPageCursor - Next page token
    # 
    # + return - `UserList` record if successful or else `error`
    @display { label: "Get Organization Members" }
    remote isolated function getOrganizationMemberList(@display {label: "Organization Name"} string organizationName, 
                                                       @display {label: "Per Page Count"} int perPageCount, 
                                                       @display {label: "Next Page Cursor"} string? nextPageCursor=()) 
                                                       returns @display {label: "User List"} @tainted UserList|error {
        return getOrganizationMemberList(organizationName, perPageCount, self.accessToken, self.githubGraphQlClient, 
                                         nextPageCursor);
    }

    # Get organization Id
    # 
    # + organizationName - Organization username
    # 
    # + return - Organization Id
    @display { label: "Get Organization Id" }
    remote isolated function getOrganizationOwnerId(@display {label: "Organization Name"} string organizationName) 
                                                    returns @display {label: "Organization Id"} @tainted string|error {
        return getOrganizationOwnerId(organizationName, self.accessToken, self.githubGraphQlClient);
    }
}

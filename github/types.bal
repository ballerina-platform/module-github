//// Copyright (c) 2018, WSO2 Inc. (http://www.wso2.org) All Rights Reserved.
////
//// WSO2 Inc. licenses this file to you under the Apache License,
//// Version 2.0 (the "License"); you may not use this file except
//// in compliance with the License.
//// You may obtain a copy of the License at
////
//// http://www.apache.org/licenses/LICENSE-2.0
////
//// Unless required by applicable law or agreed to in writing,
//// software distributed under the License is distributed on an
//// "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
//// KIND, either express or implied.  See the License for the
//// specific language governing permissions and limitations
//// under the License.

import ballerina/http;

# Repesent GitHub user
#
# + anyPinnableItems - Determine if this repository owner has any items that can be pinned to their profile.
# + avatarUrl - A URL pointing to the user's public avatar.
# + bio - The user's public profile bio.
# + bioHTML - The user's public profile bio as HTML.
# + company - The user's public profile company.
# + companyHTML - The user's public profile company as HTML.
# + createdAt - Identifies the date and time when the object was created.
# + databaseId - Identifies the primary key from the database.
# + email - The user's publicly visible profile email.
# + hasSponsorsListing - True if this user/organization has a GitHub Sponsors listing.
# + id - User ID
# + isBountyHunter - Whether or not this user is a participant in the GitHub Security Bug Bounty.
# + isCampusExpert - Whether or not this user is a participant in the GitHub Campus Experts Program.
# + isDeveloperProgramMember - Whether or not this user is a GitHub Developer Program member.
# + isEmployee - Whether or not this user is a GitHub employee.
# + isGitHubStar - Whether or not this user is a member of the GitHub Stars Program.
# + isSiteAdmin - Whether or not this user is a site administrator.
# + isViewer - Whether or not this user is the viewing user.
# + location - The user's public profile location.
# + login - The username used to login.
# + projectsUrl - The HTTP URL listing user's projects
# + resourcePath - The HTTP path for this user
# + twitterUsername - The user's Twitter username.
# + updatedAt - Identifies the date and time when the object was last updated.
# + url - The HTTP URL for this user
# + websiteUrl - A URL pointing to the user's public website/blog.
# + name - The user's public profile name.
public type User record {
    boolean anyPinnableItems?;
    string avatarUrl?;
    string? bio?;
    string bioHTML?;
    string? company?;
    string companyHTML?;
    string createdAt?;
    int? databaseId?;
    string email?;
    boolean hasSponsorsListing?;
    string id;
    boolean isBountyHunter?;
    boolean isCampusExpert?;
    boolean isDeveloperProgramMember?;
    boolean isEmployee?;
    boolean isGitHubStar?;
    boolean isSiteAdmin?;
    boolean isViewer?;
    string? location?;
    string login;
    string projectsUrl?;
    string resourcePath?;
    string? twitterUsername?;
    string updatedAt?;
    string url?;
    string? websiteUrl?;
    string? name?;
};

# Represent GitHub repository owner
#
# + id - ID
# + login - The username used to login.
# + resourcePath - The HTTP URL for the owner.
# + url - The HTTP URL for the owner.
# + avatarUrl - A URL pointing to the owner's public avatar.
public type RepositoryOwner record {
    string id;
    string login;
    string resourcePath?;
    string url?;
    string avatarUrl?;
};

# Represent GitHub actor.
#
# + login - The username of the actor.
# + resourcePath - The HTTP path for this actor.
# + url - The HTTP URL for this actor.
# + avatarUrl - A URL pointing to the actor's public avatar.
public type Actor record {
   string login;
   string resourcePath?;
   string url?;
   string avatarUrl?;
};

# Represent GitHub repository.
#
# + createdAt - Identifies the date and time when the object was created.
# + databaseId - Identifies the primary key from the database.
# + deleteBranchOnMerge - Whether or not branches are automatically deleted when merged in this repository.
# + description - The description of the repository.
# + descriptionHTML - The description of the repository rendered to HTML.
# + diskUsage - The number of kilobytes this repository occupies on disk.
# + forkCount - Returns how many forks there are of this repository in the whole network.
# + hasIssuesEnabled - Indicates if the repository has issues feature enabled.
# + hasProjectsEnabled - Indicates if the repository has the Projects feature enabled.
# + hasWikiEnabled - Indicates if the repository has wiki feature enabled.
# + homepageUrl - The repository's URL.
# + id - ID
# + isArchived - Indicates if the repository is unmaintained.
# + isBlankIssuesEnabled - Returns true if blank issue creation is allowed
# + isDisabled - Returns whether or not this repository disabled.
# + isEmpty - Returns whether or not this repository is empty.
# + isFork - Identifies if the repository is a fork.
# + isInOrganization - Indicates if a repository is either owned by an organization, or is a private fork of an organization repository.
# + isLocked - Indicates if the repository has been locked or not.
# + isMirror - Identifies if the repository is a mirror.
# + isPrivate - Identifies if the repository is private or internal.
# + isSecurityPolicyEnabled - Returns true if this repository has a security policy
# + isTemplate - Identifies if the repository is a template that can be used to generate new repositories.
# + isUserConfigurationRepository - Is this repository a user configuration repository?
# + mergeCommitAllowed - Whether or not PRs are merged with a merge commit on this repository.
# + mirrorUrl - The repository's original mirror URL.
# + name - The name of the repository.
# + nameWithOwner - The repository's name with owner.
# + owner - The User owner of the repository.
# + projectsResourcePath - The HTTP path listing the repository's projects
# + projectsUrl - The HTTP URL listing the repository's projects
# + pushedAt - Identifies when the repository was last pushed to.
# + rebaseMergeAllowed - Whether or not rebase-merging is enabled on this repository.
# + resourcePath - The HTTP path for this repository
# + securityPolicy - The security policy URL.
# + sshUrl - The SSH URL to clone this repository
# + stargazerCount - Returns a count of how many stargazers there are on this object
# + tempCloneToken - Temporary authentication token for cloning this repository.
# + updatedAt - Identifies the date and time when the object was last updated.
# + url - The HTTP URL for this repository
# + viewerCanAdminister - Indicates whether the viewer has admin permissions on this repository.
# + viewerCanCreateProjects - Can the current viewer create new projects on this owner.
# + viewerCanSubscribe - Check if the viewer is able to change their subscription status for the repository.
public type Repository record {
  string createdAt;
  int? databaseId?;
  boolean deleteBranchOnMerge?;
  string? description?;
  string descriptionHTML?;
  int? diskUsage?;
  int forkCount?;
  boolean hasIssuesEnabled?;
  boolean hasProjectsEnabled?;
  boolean hasWikiEnabled?;
  string? homepageUrl?;
  string id;
  boolean isArchived?;
  boolean isBlankIssuesEnabled?;
  boolean isDisabled?;
  boolean isEmpty?;
  boolean isFork?;
  boolean isInOrganization?;
  boolean isLocked?;
  boolean isMirror?;
  boolean isPrivate?;
  boolean? isSecurityPolicyEnabled?;
  boolean isTemplate?;
  boolean isUserConfigurationRepository?;
  boolean mergeCommitAllowed?;
  string? mirrorUrl?;
  string name;
  string nameWithOwner;
  RepositoryOwner owner;
  string projectsResourcePath?;
  string projectsUrl?;
  string? pushedAt?;
  boolean rebaseMergeAllowed?;
  string resourcePath?;
  string? securityPolicy?;
  string sshUrl?;
  int stargazerCount?;
  string? tempCloneToken?;
  string updatedAt?;
  string url?;
  boolean viewerCanAdminister?;
  boolean viewerCanCreateProjects?;
  boolean viewerCanSubscribe?;
};

# Represent GitHub branch.
#
# + id - Id
# + name - Name of the branch
# + prefix - GitHub reference prefix
public type Branch record {
  string id;
  string name;
  string prefix;
};

# Represent GitHub issue.
#
# + author - The actor who authored the comment.
# + body - Identifies the body of the issue.
# + bodyHTML - The body rendered to HTML.
# + bodyResourcePath - The http path for this issue body
# + bodyText - Identifies the body of the issue rendered to text.
# + bodyUrl - The http URL for this issue body
# + closed - `true` if the object is closed (definition of closed may depend on type)
# + closedAt - Identifies the date and time when the object was closed.
# + createdAt - Identifies the date and time when the object was created.
# + createdViaEmail - Check if this comment was created via an email reply.
# + databaseId - Identifies the primary key from the database.
# + editor - The actor who edited the comment.
# + id - ID
# + isPinned - Indicates whether or not this issue is currently pinned to the repository issues list
# + isReadByViewer - Is this issue read by the viewer
# + lastEditedAt - The moment the editor made the last edit
# + locked - `true` if the object is locked
# + number - Identifies the issue number.
# + publishedAt - Identifies when the comment was published at.
# + resourcePath - The HTTP path for this issue
# + state - Identifies the state of the issue.
# + title - Identifies the issue title.
# + updatedAt - Identifies the date and time when the object was last updated.
# + url - The HTTP URL for this issue
# + viewerDidAuthor - Did the viewer author this comment.
# + viewerCanUpdate - Check if the current viewer can update this object.
public type Issue record {
    Actor? author?;
    string body?;
    string bodyHTML?;
    string bodyResourcePath?;
    string bodyText?;
    string bodyUrl?;
    boolean closed?;
    string? closedAt?;
    string createdAt?;
    boolean createdViaEmail?;
    int? databaseId?;
    Actor? editor?;
    string id;
    boolean? isPinned?;
    boolean? isReadByViewer?;
    string? lastEditedAt?;
    boolean locked?;
    int number;
    string? publishedAt?;
    string resourcePath?;
    IssueState state?;
    string title?;
    string updatedAt?;
    string url?;
    boolean viewerDidAuthor?;
    boolean viewerCanUpdate?;
};

# Represent GitHub issue comment.
#
# + author - The actor who authored the comment.
# + body - The body as Markdown.
# + bodyHTML - The body rendered to HTML.
# + bodyText - The body rendered to text.
# + createdAt - Identifies the date and time when the object was created.
# + databaseId - Identifies the primary key from the database.
# + editor - The actor who edited the comment.
# + id - ID
# + isMinimized - Returns whether or not a comment has been minimized.
# + lastEditedAt - The moment the editor made the last edit
# + minimizedReason - Returns why the comment was minimized.
# + publishedAt - Identifies when the comment was published at.
# + url - The HTTP URL for this issue comment
# + viewerCanDelete - Check if the current viewer can delete this object.
# + viewerCanUpdate - Check if the current viewer can update this object.
# + viewerDidAuthor - Did the viewer author this comment.
public type IssueComment record {
    Actor? author?;
    string body?;
    string bodyHTML?;
    string bodyText?;
    string createdAt?;
    int? databaseId?;
    Actor? editor?;
    string id;
    boolean isMinimized?;
    string? lastEditedAt?;
    string? minimizedReason?;
    string? publishedAt?;
    string url?;
    boolean viewerCanDelete?;
    boolean viewerCanUpdate?;
    boolean viewerDidAuthor?;
};

# Represent GitHub Label.
#
# + color - Identifies the label color.
# + createdAt - Identifies the date and time when the label was created.
# + description - A brief description of this label.
# + id - ID
# + isDefault - Indicates whether or not this is a default label.
# + name - Identifies the label name.
# + updatedAt - Identifies the date and time when the label was last updated.
# + url - The HTTP URL for this label.
public type Label record {
    string color?;
    string? createdAt?;
    string? description?;
    string id;
    boolean isDefault?;
    string name;
    string updatedAt?;
    string url?;
};

# Represent GitHub milestone
#
# + id -
# + number -
# + closed - `true` if the object is closed (definition of closed may depend on type)
# + closedAt - Identifies the date and time when the object was closed.
# + createdAt - Identifies the date and time when the object was created.
# + creator - Identifies the actor who created the milestone.
# + description - Identifies the description of the milestone.
# + dueOn - Identifies the due date of the milestone.
# + progressPercentage - Identifies the percentage complete for the milestone
# + resourcePath - The HTTP path for this milestone
# + title - Identifies the title of the milestone.
# + updatedAt - Identifies the date and time when the object was last updated.
# + url - The HTTP URL for this milestone
public type Milestone record {
    string id;
    int number;
    boolean closed?;
    string? closedAt?;
    string createdAt?;
    Actor? creator?;
    string? description?;
    string? dueOn?;
    float progressPercentage?;
    string resourcePath?;
    string title?;
    string updatedAt?;
    string url?;
};

# Represent GitHub page info.
#
# + startCursor - When paginating backwards, the cursor to continue.
# + endCursor - When paginating forwards, the cursor to continue. [next page token]
# + hasNextPage - When paginating forwards, are there more items?
# + hasPreviousPage - When paginating backwards, are there more items?
public type PageInfo record {
    string? startCursor;
    string? endCursor;
    boolean hasNextPage;
    boolean hasPreviousPage;
};

# Represent GitHub Reference
#
# + id - ID
# + name - The ref name.
# + prefix - The ref's prefix, such as `refs/heads/` or `refs/tags/`.
public type Ref record {
    string id;
    string name;
    string prefix;
};

# Represent GitHub pull request.
#
# + additions - The number of additions in this pull request.
# + author - The actor who authored the comment.
# + baseRef - Identifies the base Ref associated with the pull request.
# + baseRefName - Identifies the name of the base Ref associated with the pull request, even if the ref has been deleted.
# + body - The body as Markdown.
# + bodyHTML - The body rendered to HTML.
# + bodyText - The body rendered to text.
# + changedFiles - The number of changed files in this pull request.
# + checksResourcePath - The HTTP path for the checks of this pull request.
# + checksUrl - The HTTP URL for the checks of this pull request.
# + closed - `true` if the pull request is closed
# + closedAt - Identifies the date and time when the object was closed.
# + createdAt - Identifies the date and time when the object was created.
# + createdViaEmail - Check if this comment was created via an email reply.
# + databaseId - Identifies the primary key from the database.
# + deletions - The number of deletions in this pull request.
# + editor - The actor who edited this pull request's body.
# + headRef - Identifies the head Ref associated with the pull request.
# + headRefName - Identifies the name of the head Ref associated with the pull request, even if the ref has been deleted.
# + headRepositoryOwner - The owner of the repository associated with this pull request's head Ref.
# + id - ID
# + isDraft - Identifies if the pull request is a draft.
# + lastEditedAt - The moment the editor made the last edit
# + locked - `true` if the pull request is locked
# + merged - Whether or not the pull request was merged.
# + mergedBy - The actor who merged the pull request.
# + number - Identifies the pull request number.
# + publishedAt - Identifies when the comment was published at.
# + resourcePath - The HTTP path for this pull request.
# + revertUrl - The HTTP URL for reverting this pull request.
# + state - Identifies the state of the pull request.
# + title - Identifies the pull request title.
# + updatedAt - Identifies the date and time when the object was last updated.
# + url - The HTTP URL for this pull request.
public type PullRequest record {
    int additions?;
    Actor? author?;
    Ref? baseRef?;
    string baseRefName?;
    string body?;
    string bodyHTML?;
    string bodyText?;
    int changedFiles?;
    string checksResourcePath?;
    string checksUrl?;
    boolean closed?;
    string? closedAt?;
    string createdAt?;
    boolean createdViaEmail?;
    int? databaseId?;
    int deletions?;
    Actor? editor?;
    Ref? headRef?;
    string headRefName?;
    RepositoryOwner? headRepositoryOwner?;
    string id;
    boolean isDraft?;
    string? lastEditedAt?;
    boolean locked?;
    boolean merged?;
    Actor? mergedBy?;
    int number;
    string? publishedAt?;
    string resourcePath?;
    string revertUrl?;
    PullRequestState state?;
    string title?;
    string updatedAt?;
    string url?;
};

# Represent GitHub pull request review state.
#
# + PR_REVIEW_PENDING - A review that has not yet been submitted.
# + PR_REVIEW_COMMENTED - An informational review.
# + PR_REVIEW_APPROVED - A review allowing the pull request to merge.
# + PR_REVIEW_CHANGES_REQUESTED - A review blocking the pull request from merging.
# + PR_REVIEW_DISMISSED - A review that has been dismissed.
public enum PullRequestReviewState {
    PR_REVIEW_PENDING = "PENDING",
    PR_REVIEW_COMMENTED = "COMMENTED",
    PR_REVIEW_APPROVED = "APPROVED",
    PR_REVIEW_CHANGES_REQUESTED = "CHANGES_REQUESTED",
    PR_REVIEW_DISMISSED = "DISMISSED"
}

# Represent GitHub project state.
#
# + PROJECT_OPEN - The project is open.
# + PROJECT_CLOSED - The project is closed.
public enum ProjectState {
    PROJECT_OPEN = "OPEN",
    PROJECT_CLOSED = "CLOSED"
}

# Represent GitHub pull request review
#
# + body - Identifies the pull request review body.
# + createdAt - Identifies the date and time when the object was created.
# + id - ID
# + lastEditedAt - The moment the editor made the last edit
# + url - The HTTP URL permalink for this PullRequestReview.
# + state - Identifies the current state of the pull request review.
# + publishedAt - Identifies when the comment was published at.
public type PullRequestReview record {
    string body?;
    string createdAt?;
    string id;
    string? lastEditedAt?;
    string url?;
    PullRequestReviewState state?;
    string? publishedAt?;
};

# Represent GitHub project
#
# + id - ID
# + name - The project's name.
# + body - The project's description body.
# + closed - `true` if the object is closed (definition of closed may depend on type)
# + closedAt - Identifies the date and time when the object was closed.
# + createdAt - Identifies the date and time when the object was created.
# + creator - The actor who originally created the project.
# + databaseId - Identifies the primary key from the database.
# + number - The project's number.
# + state - Whether the project is open or closed.
# + updatedAt - Identifies the date and time when the object was last updated.
# + url - The HTTP URL for this project
public type Project record {
    string id;
    string name;
    string? body?;
    boolean closed?;
    string? closedAt?;
    string createdAt?;
    Actor? creator?;
    int? databaseId?;
    int number?;
    ProjectState state?;
    string updatedAt?;
    string url?;
};

# Represent GitHub organization
#
# + avatarUrl - A URL pointing to the organization's public avatar.
# + description - The organization's public profile description.
# + email - The organization's public email.
# + id - ID
# + location - The organization's public profile location.
# + login - The organization's login name.
# + name - The organization's public profile name.
# + projectsResourcePath - The HTTP path listing organization's projects
# + projectsUrl - The HTTP URL listing organization's projects
# + resourcePath - The HTTP path for this organization.
# + url - The HTTP URL for this organization.
# + websiteUrl - The organization's public profile URL.
public type Organization record {
    string avatarUrl?;
    string? description?;
    string? email?;
    string id;
    string? location?;
    string login;
    string name;
    string projectsResourcePath?;
    string projectsUrl?;
    string resourcePath?;
    string url?;
    string? websiteUrl?;
};

# Represent GitHub repository list.
#
# + nodes - Repository list
# + pageInfo - Response pagination info 
# + totalCount - Total repository count
public type RepositoryListPayload record {
    Repository[] nodes;
    PageInfo pageInfo;
    int totalCount;
};

# Represent GitHub repository list.
#
# + repositories - Repository list
# + pageInfo - Response pagination info 
# + totalCount - Total repository count
public type RepositoryList record {
    Repository[] repositories;
    PageInfo pageInfo;
    int totalCount;
};


# Represent GitHub collaborator list.
#
# + nodes - Collaborator list.
# + pageInfo - Response pagination info.
# + totalCount - Total collaborator count.
public type CollaboratorListPayload record {

    User[] nodes;
    PageInfo pageInfo;
    int totalCount;
};

# Represent GitHub collaborator list.
#
# + collaborators - Collaborator list.
# + pageInfo - Response pagination info.
# + totalCount - Total collaborator count.
public type CollaboratorList record {

    User[] collaborators;
    PageInfo pageInfo;
    int totalCount;
};

# Represent GitHub branch list.
#
# + nodes - Branch list.
# + pageInfo - Response pagination info.
# + totalCount - Total branch count.
public type BranchListPayload record {
    Branch[] nodes;
    PageInfo pageInfo;
    int totalCount;
};

# Represent GitHub branch list.
#
# + branches - Branch list.
# + pageInfo - Response pagination info.
# + totalCount - Total branch count.
public type BranchList record {
    Branch[] branches;
    PageInfo pageInfo;
    int totalCount;
};

# Represent GitHub issue list.
#
# + nodes - Issue list
# + pageInfo - Response pagination info.
# + totalCount - Total issues count.
public type IssueListPayload record {
    Issue[] nodes;
    PageInfo pageInfo;
    int totalCount;
};

# Represent GitHub issue list.
#
# + issues - Issue list
# + pageInfo - Response pagination info.
# + totalCount - Total issues count.
public type IssueList record {
    Issue[] issues;
    PageInfo pageInfo;
    int totalCount;
};

# Represent GitHub issue comment list.
#
# + nodes - Issues Comment list
# + pageInfo - Response pagination info.
# + totalCount - Total issues comment count.
public type IssueCommentListPayload record {
    IssueComment[] nodes;
    PageInfo pageInfo;
    int totalCount;
};

# Represent GitHub issue comment list.
#
# + issueComments - Issues Comment list
# + pageInfo - Response pagination info.
# + totalCount - Total issues comment count.
public type IssueCommentList record {
    IssueComment[] issueComments;
    PageInfo pageInfo;
    int totalCount;
};

# Represent GitHub label list.
#
# + nodes - Labale list.
# + pageInfo - Response pagination info.
# + totalCount - Total label count
public type LabelListPayload record {
    Label[] nodes;
    PageInfo pageInfo;
    int totalCount;
};

# Represent GitHub label list.
#
# + labels - Labale list.
# + pageInfo - Response pagination info.
# + totalCount - Total label count
public type LabelList record {
    Label[] labels;
    PageInfo pageInfo;
    int totalCount;
};

# Represent GitHub milestone list.
#
# + nodes - Milestone list
# + pageInfo - Response pagination info.
# + totalCount - Total milestone count
public type MilestoneListPayload record {
    Milestone[] nodes;
    PageInfo pageInfo;
    int totalCount;
};

# Represent GitHub milestone list.
#
# + milestones - Milestone list
# + pageInfo - Response pagination info.
# + totalCount - Total milestone count
public type MilestoneList record {
    Milestone[] milestones;
    PageInfo pageInfo;
    int totalCount;
};

# Represent GitHub pull request list.
#
# + nodes - Pull Request list
# + pageInfo - Response pagination info.
# + totalCount - Total pull request count
public type PullRequestListPayload record {
    PullRequest[] nodes;
    PageInfo pageInfo;
    int totalCount;
};

# Represent GitHub pull request list.
#
# + pullRequests - Pull Request list
# + pageInfo - Response pagination info.
# + totalCount - Total pull request count
public type PullRequestList record {
    PullRequest[] pullRequests;
    PageInfo pageInfo;
    int totalCount;
};

# Represent GitHub pull request review list.
#
# + nodes - Pull Request Review list
# + pageInfo - Response pagination info.
# + totalCount - Total pull request review count
public type PullRequestReviewListPayload record {
    PullRequestReview[] nodes;
    PageInfo pageInfo;
    int totalCount;
};

# Represent GitHub pull request review list.
#
# + pullRequestReviews - Pull Request Review list
# + pageInfo - Response pagination info.
# + totalCount - Total pull request review count
public type PullRequestReviewList record {
    PullRequestReview[] pullRequestReviews;
    PageInfo pageInfo;
    int totalCount;
};

# Represent GitHub project list.
# 
# + nodes - Project list
# + pageInfo - Response pagination info.
# + totalCount - Total projects count.
public type ProjectListPayload record {
    Project[] nodes;
    PageInfo pageInfo;
    int totalCount;
};

# Represent GitHub project list.
# 
# + projects - Project list
# + pageInfo - Response pagination info.
# + totalCount - Total projects count.
public type ProjectList record {
    Project[] projects;
    PageInfo pageInfo;
    int totalCount;
};

# Represent GitHub organization list.
#
# + nodes - Organization list.
# + pageInfo - Response pagination info.
# + totalCount - Total organization count.
public type OrganizationListPayload record {
    Organization[] nodes;
    PageInfo pageInfo;
    int totalCount;
};

# Represent GitHub organization list.
#
# + organizations - Organization list.
# + pageInfo - Response pagination info.
# + totalCount - Total organization count.
public type OrganizationList record {
    Organization[] organizations;
    PageInfo pageInfo;
    int totalCount;
};

# Represent GitHub user list.
#
# + nodes - User list.
# + pageInfo - Response pagination info.
# + totalCount - Total user count
public type UserListPayload record {
    User[] nodes;
    PageInfo pageInfo;
    int totalCount;
};

# Represent GitHub user list.
#
# + users - User list.
# + pageInfo - Response pagination info.
# + totalCount - Total user count
public type UserList record {
    User[] users;
    PageInfo pageInfo;
    int totalCount;
};

# Represents the Github Client Connector Endpoint configuration.
# 
# + clientConfig - HTTP client endpoint configuration
# + accessToken - The access token of the Github 
@display{label: "Connection Config"}
public type Configuration record {
    http:ClientConfiguration clientConfig = {};
    string accessToken;
};

# Represent repository visibility types
# 
# + PRIVATE_REPOSITORY - The repository is visible only to anyone
# + PUBLIC_REPOSITORY - The repository is visible only to those with explicit access.
# + INTERNAL_REPOSITORY - The repository is visible only to users in the same business.
public enum RepositoryVisibility {
    PRIVATE_REPOSITORY = "PRIVATE",
    PUBLIC_REPOSITORY = "PUBLIC",
    INTERNAL_REPOSITORY = "INTERNAL"
}

# Represent create repository input payload
# + ownerId - The ID of the owner for the new repository.
# + name - The name of the new repository.
# + description - A short description of the new repository.
# + visibility - Indicates the repository's visibility level. eg: github: PUBLIC_REPOSITORY
# + template - Whether this repository should be marked as a template such that anyone who can access it can create new repositories with the same files and directory structure.
# + homepageUrl - The URL for a web page about this repository.
# + hasWikiEnabled - Indicates if the repository should have the wiki feature enabled.
# + hasIssuesEnabled - Indicates if the repository should have the issues feature enabled.
# + teamId - When an organization is specified as the owner, this ID identifies the team that should be granted access to the new repository.
# + clientMutationId - A unique identifier for the client performing the mutation.
public type CreateRepositoryInput record {
    string ownerId?;
    string name;
    string description?;
    RepositoryVisibility visibility;
    boolean template?;
    string homepageUrl?;
    boolean hasWikiEnabled?;
    boolean hasIssuesEnabled?;
    string teamId?;
    string clientMutationId?;
};

# Represent update repository input payload.
#
# + clientMutationId - A unique identifier for the client performing the mutation. 
# + description - A new description for the repository. Pass an empty string to erase the existing description.
# + hasIssuesEnabled - Indicates if the repository should have the issues feature enabled.
# + hasProjectsEnabled - Indicates if the repository should have the project boards feature enabled.
# + hasWikiEnabled - Indicates if the repository should have the wiki feature enabled.
# + homePageUrl - The URL for a web page about this repository. Pass an empty string to erase the existing URL.
# + name - The new name of the repository.
# + repositoryId - The ID of the repository to update.
# + template - Whether this repository should be marked as a template such that anyone who can access it can create new repositories with the same files and directory structure.
public type UpdateRepositoryInput record {
    @display { label: "Client Mutation Id" }
    string clientMutationId?;
    @display { label: "Description" }
    string description?;
    @display { label: "Has Issues Enabled" }
    boolean hasIssuesEnabled?;
    @display { label: "Has Project Boards Enabled" }
    boolean hasProjectsEnabled?;
    @display { label: "Has Wiki Enabled" }
    boolean hasWikiEnabled?;
    @display { label: "Home Page URL" }
    string homePageUrl?;
    @display { label: "Name" }
    string name?;
    @display { label: "Repository Id" }
    string repositoryId?;
    @display { label: "Template" }
    boolean template?;
};

# Represent create issue input payload.
#
# + title - The title for the issue.
# + body - The body for the issue description.
# + assigneeNames - The GitHub usernames of the user assignees for this issue.
# + milestoneId - The Node ID of the milestone for this issue.
# + labelNames - An array of Node IDs of labels for this issue.
# + projectIds - An array of Node IDs for projects associated with this issue.
# + issueTemplate - The name of an issue template in the repository, assigns labels and assignees from the template to the issue
# + clientMutationId - A unique identifier for the client performing the mutation.
public type CreateIssueInput record {
    @display { label: "Title" }
    string title;
    @display { label: "Body" }
    string body?;
    @display { label: "Assignee Names" }
    string[] assigneeNames?;
    @display { label: "Milestone Id" }
    string milestoneId?;
    @display { label: "Label Names" }
    string[] labelNames?;
    @display { label: "Project Ids" }
    string[] projectIds?;
    @display { label: "Issue Template" }
    string issueTemplate?;
    @display { label: "Client Mutation Id" }
    string clientMutationId?;
};

# Represent create issue input payload.
#
# + repositoryId - The Node ID of the repository.
# + title - The title for the issue.
# + body - The body for the issue description.
# + assigneeIds - The Node ID for the user assignee for this issue.
# + milestoneId - The Node ID of the milestone for this issue.
# + labelIds - An array of Node IDs of labels for this issue.
# + projectIds - An array of Node IDs for projects associated with this issue.
# + issueTemplate - The name of an issue template in the repository, assigns labels and assignees from the template to the issue
# + clientMutationId - A unique identifier for the client performing the mutation.
public type CreateIssueInputPayload record {
    string repositoryId;
    string title;
    string body?;
    string[] assigneeIds?;
    string milestoneId?;
    string[] labelIds?;
    string[] projectIds?;
    string issueTemplate?;
    string clientMutationId?;
};

# Represent update issue input payload.
#
# + id - The ID of the Issue to modify.
# + title - The title for the issue.
# + body - The body for the issue description.
# + assigneeNames - An array of GitHub usernames of users for this issue.
# + milestoneId - The Node ID of the milestone for this issue.
# + labelNames - An array of label names of labels for this issue.
# + state - The desired issue state.
# + projectIds - An array of Node IDs for projects associated with this issue.
# + clientMutationId - A unique identifier for the client performing the mutation.
public type UpdateIssueInput record {
    @display { label: "Id" }
    string id?;
    @display { label: "Issue Title" }
    string title?;
    @display { label: "Issue Description" }
    string body?;
    @display { label: "Assignee Names" }
    string[] assigneeNames?;
    @display { label: "Milestone Ids" }
    string milestoneId?;
    @display { label: "Label Names" }
    string[] labelNames?;
    @display { label: "State" }
    IssueState state?;
    @display { label: "Project Ids" }
    string[] projectIds?;
    @display { label: "Client Mutation Id" }
    string clientMutationId?;
};

# Represent update issue input payload.
#
# + id - The ID of the Issue to modify.
# + title - The title for the issue.
# + body - The body for the issue description.
# + assigneeIds - An array of Node IDs of users for this issue.
# + milestoneId - The Node ID of the milestone for this issue.
# + labelIds - An array of Node IDs of labels for this issue.
# + state - The desired issue state.
# + projectIds - An array of Node IDs for projects associated with this issue.
# + clientMutationId - A unique identifier for the client performing the mutation.
public type UpdateIssueInputPayload record {
    string id?;
    string title?;
    string body?;
    string[] assigneeIds?;
    string milestoneId?;
    string[] labelIds?;
    IssueState state?;
    string[] projectIds?;
    string clientMutationId?;
};

# Represent issue state types.
#
# + ISSUE_OPEN - An issue that is still open
# + ISSUE_CLOSED - An issue that has been closed
public enum IssueState {
    ISSUE_OPEN="OPEN",
    ISSUE_CLOSED="CLOSED"
}

# Represent add comment input payload.
#
# + subjectId - The Node ID of the subject to modify.
# + body - The contents of the comment.
# + clientMutationId - A unique identifier for the client performing the mutation.
public type AddCommentInput record {
    string subjectId;
    string body;
    string clientMutationId?;
};

# Represent add comment input payload.
# + repositoryOwnerName - GitHub username of the repository owner
# + repositoryName - Repository name
# + issueNumber - Issue number
# + body - The contents of the comment.
# + clientMutationId - A unique identifier for the client performing the mutation.
public type AddIssueCommentInput record {
    @display { label: "Repository Owner Name" }
    string repositoryOwnerName;
    @display { label: "Repository Name" }
    string repositoryName;
    @display { label: "Issue Number" }
    int issueNumber;
    @display { label: "Body" }
    string body;
    @display { label: "Client Mutation Id" }
    string clientMutationId?;
};

# Represent update issue comment input payload.
#
# + id - The ID of the IssueComment to modify.
# + body - The updated text of the comment.
# + clientMutationId - A unique identifier for the client performing the mutation.
public type UpdateIssueCommentInput record {
    @display { label: "Issue Comment Id" }
    string id;
    @display { label: "Comment Text" }
    string body;
    @display { label: "Client Mutation Id" }
    string clientMutationId?;
};

# Represent delete issue comment input payload.
#
# + id - The ID of the comment to delete.
# + clientMutationId - A unique identifier for the client performing the mutation.
public type DeleteIssueCommentInput record {
    @display { label: "Issue Comment Id" }
    string id;
    @display { label: "Client Mutation Id" }
    string clientMutationId?;
};

# Represent create label input payload.
#
# + name - Name of the label
# + description - Description of the label
# + color - Color of the label
# + repositoryId - Node ID of the repository where this label needs to be created
# + clientMutationId - A unique identifier for the client performing the mutation.
public type CreateLabelInput record {
    @display { label: "Name" }
    string name;
    @display { label: "Description" }
    string description;
    @display { label: "Color" }
    string color;
    @display { label: "Repository Id" }
    string repositoryId;
    @display { label: "Client Mutation Id" }
    string clientMutationId?;
};

# Represent update label input payload.
#
# + id - Label ID
# + name - Name of the label
# + description - Description of the label
# + color - Color of the label
# + clientMutationId - A unique identifier for the client performing the mutation.
public type UpdateLabelInput record {
    @display { label: "Label Id" }
    string id;
    @display { label: "Name" }
    string name?;
    @display { label: "Description" }
    string description?;
    @display { label: "Color" }
    string color?;
    @display { label: "Client Mutation Id" }
    string clientMutationId?;
};

# Represent delete label input payload.
#
# + id - Node ID of the label
# + clientMutationId - A unique identifier for the client performing the mutation.
public type DeleteLabelInput record {
    @display { label: "Label Id" }
    string id;
    @display { label: "Client Mutation Id" }
    string clientMutationId?;
};

# Represent add label to labelable input payload.
#
# + labelableId - The id of the labelable object to add labels to.
# + labelIds - The ids of the labels to add.
# + clientMutationId - A unique identifier for the client performing the mutation.
public type AddLabelsToLabelableInput record {
    string labelableId;
    string[] labelIds?;
    string clientMutationId?;
};

# Represent add label to issue input payload.
#
# + repositoryOwnerName - Repository owner name/ GitHub username
# + repositoryName - Repository name
# + issueNumber - Issue number
# + labelNames - Repository label name
# + clientMutationId - A unique identifier for the client performing the mutation. 
public type AddIssueLabelsInput record {
    @display { label: "Repository Owner Name" }
    string repositoryOwnerName;
    @display { label: "Repository Name" }
    string repositoryName;
    @display { label: "Issue Number" }
    int issueNumber;
    @display { label: "Label Names" }
    string[] labelNames;
    @display { label: "Client Mutation Id" }
    string clientMutationId?;
};

# Represent remove label from labelable input payload.
#
# + repositoryOwnerName - Repository owner name/ GitHub username
# + repositoryName - Repository name
# + issueNumber - Issue number
# + labelNames - Array of existing label names of the issue to be removed
# + clientMutationId - A unique identifier for the client performing the mutation.
public type RemoveIssueLabelInput record {
    @display { label: "Repository Owner Name" }
    string repositoryOwnerName;
    @display { label: "Repository Name" }
    string repositoryName;
    @display { label: "Issue Number" }
    int issueNumber;
    @display { label: "Label Names" }
    string[] labelNames;
    @display { label: "Client Mutation Id" }
    string clientMutationId?;
};

# Represent remove label from labelable input payload.
#
# + labelableId - The id of the labelable object to add labels to.
# + labelIds - The ids of the labels to add.
# + clientMutationId - A unique identifier for the client performing the mutation.
public type RemoveLabelsFromLabelableInput record {
    string labelableId;
    string[] labelIds;
    string clientMutationId?;
};

# Represent GitHub pull request create input payload.
#
# + repositoryId - Node of the repository where the pull request create
# + title - Title of the pull request
# + baseRefName - The name of the branch you want your changes pulled into. This should be an existing branch on the current repository. You cannot update the base branch on a pull request to point to another repository.
# + headRefName - The name of the branch where your changes are implemented. For cross-repository pull requests in the same network, namespace `head_ref_name` with a user like this: `username:branch`.
# + body - The contents of the pull request.
# + maintainerCanModify - Indicates whether maintainers can modify the pull request.
# + draft - Indicates whether this pull request should be a draft.
# + clientMutationId - A unique identifier for the client performing the mutation.
public type CreatePullRequestInput record {
    @display { label: "Repository Id" }
    string repositoryId?;
    @display { label: "Title" }
    string title;
    @display { label: "Base Ref Name" }
    string baseRefName;
    @display { label: "Head Ref Name" }
    string headRefName;
    @display { label: "Body" }
    string body?;
    @display { label: "Maintainer Can Modify" }
    boolean maintainerCanModify = false;
    @display { label: "Fraft" }
    boolean draft = false;
    @display { label: "Client Mutation Id" }
    string clientMutationId?;
};

# Represent GitHub pull request update input payload.
#
# + pullRequestId - The Node ID of the pull request.
# + baseRefName - The name of the branch you want your changes pulled into. This should be an existing branch on the current repository.
# + title - Title of the pull request
# + body - The contents of the pull request.
# + state - The target state of the pull request.
# + maintainerCanModify - Indicates whether maintainers can modify the pull request.
# + assigneeNames - An array of assignee names of users for this pull request.
# + milestoneId - The Node ID of the milestone for this pull request.
# + labelNames - An array of label names of labels for this pull request.
# + projectIds - An array of Node IDs for projects associated with this pull request.
# + clientMutationId - A unique identifier for the client performing the mutation.
public type UpdatePullRequestInput record {
    @display { label: "Pull Request Id" }
    string pullRequestId?;
    @display { label: "Base Ref Name" }
    string baseRefName?;
    @display { label: "Title" }
    string title?;
    @display { label: "Pull Request Content" }
    string body?;
    @display { label: "State" }
    PullRequestState state?;
    @display { label: "Maintainer Can Modify" }
    boolean maintainerCanModify?;
    @display { label: "Assignee Names" }
    string[] assigneeNames?;
    @display { label: "Milestone Id" }
    string milestoneId?;
    @display { label: "Label Names" }
    string[] labelNames?;
    @display { label: "Project Ids" }
    string[] projectIds?;
    @display { label: "Client Mutation Id" }
    string clientMutationId?;
};

# Represent GitHub pull request update input payload.
#
# + pullRequestId - The Node ID of the pull request.
# + baseRefName - The name of the branch you want your changes pulled into. This should be an existing branch on the current repository.
# + title - Title of the pull request
# + body - The contents of the pull request.
# + state - The target state of the pull request.
# + maintainerCanModify -
# + assigneeIds - An array of Node IDs of users for this pull request.
# + milestoneId - The Node ID of the milestone for this pull request.
# + labelIds - An array of Node IDs of labels for this pull request.
# + projectIds - An array of Node IDs for projects associated with this pull request.
# + clientMutationId - A unique identifier for the client performing the mutation.
public type UpdatePullRequestInputPayload record {
    string pullRequestId?;
    string baseRefName?;
    string title?;
    string body?;
    PullRequestState state?;
    boolean maintainerCanModify?;
    string[] assigneeIds?;
    string milestoneId?;
    string[] labelIds?;
    string[] projectIds?;
    string clientMutationId?;
};

# Represent GitHub pull request states.
#
# + PULL_REQUEST_OPEN - A pull request that is still open.
# + PULL_REQUEST_CLOSED - A pull request that has been closed without being merged.
public enum PullRequestState {
    PULL_REQUEST_OPEN="OPEN",
    PULL_REQUEST_CLOSED="CLOSED"
}

# Represent GitHub pull request review create input payload.
#
# + pullRequestId - The Node ID of the pull request to modify.
# + commitOID - The commit OID the review pertains to.
# + body - The contents of the review body comment.
# + event - The event to perform on the pull request review.
# + comments - The review line comments.
# + threads - The review line comment threads.
# + clientMutationId - A unique identifier for the client performing the mutation. A unique identifier for the client performing the mutation.
public type AddPullRequestReviewInput record {
    @display { label: "Pull Request Id" }
    string pullRequestId?;
    @display { label: "Commit OID" }
    string commitOID?;
    @display { label: "Body" }
    string body?;
    @display { label: "Event" }
    PullRequestReviewEvent event?;
    @display { label: "Review Comments" }
    DraftPullRequestReviewComment[] comments?;
    @display { label: "Pull Request Review Threads" }
    DraftPullRequestReviewThread[] threads?;
    @display { label: "Client Mutation Id" }
    string clientMutationId?;
};

# Repreent GitHub draft pull request review comment payload.
#
# + path - Path to the file being commented on.
# + position - Position in the file to leave a comment on.
# + body - Body of the comment to leave.
public type DraftPullRequestReviewComment record {
    @display { label: "Path" }
    string path;
    @display { label: "Position" }
    int position;
    @display { label: "Body" }
    string body;
};

# Represent GitHub draft pull request review thread.
#
# + path - Path to the file being commented on.
# + line - The line of the blob to which the thread refers. The end of the line range for multi-line comments.
# + side - The side of the diff on which the line resides. For multi-line comments, this is the side for the end of the line range.
# + startLine - The first line of the range to which the comment refers.
# + startSide - The side of the diff on which the start line resides.
# + body - Body of the comment to leave.
public type DraftPullRequestReviewThread record {
    @display { label: "Path" }
    string path;
    @display { label: "Line" }
    int line;
    @display { label: "Side" }
    DiffSide side = DIFF_SIDE_RIGHT;
    @display { label: "Start Line" }
    int startLine?;
    @display { label: "Start Side" }
    DiffSide startSide = DIFF_SIDE_RIGHT;
    @display { label: "Body" }
    string body;
};

# Represent GitHub pull request review states.
#
# + PULL_REQUEST_REVIEW_COMMENT - Submit general feedback without explicit approval.
# + PULL_REQUEST_REVIEW_APPROVE - Submit feedback and approve merging these changes.
# + PULL_REQUEST_REVIEW_REQUEST_CHANGES - Submit feedback that must be addressed before merging.
# + PULL_REQUEST_REVIEW_DISMISS - Dismiss review so it now longer effects merging.
public enum PullRequestReviewEvent {
    PULL_REQUEST_REVIEW_COMMENT="COMMENT",
    PULL_REQUEST_REVIEW_APPROVE="APPROVE",
    PULL_REQUEST_REVIEW_REQUEST_CHANGES="REQUEST_CHANGES",
    PULL_REQUEST_REVIEW_DISMISS="DISMISS"
}

# Represent GitHub change Diff sides.
#
# + DIFF_SIDE_RIGHT - The right side of the diff.
# + DIFF_SIDE_LEFT - The left side of the diff.
public enum DiffSide {
    DIFF_SIDE_RIGHT="RIGHT",
    DIFF_SIDE_LEFT="LEFT"
}

# Represent GitHub pull request review update input payload.
#
# + pullRequestReviewId - The Node ID of the pull request review to modify.
# + body - The contents of the pull request review body.
# + clientMutationId - A unique identifier for the client performing the mutation.
public type UpdatePullRequestReviewInput record {
    @display { label: "Pull Request Review Id" }
    string pullRequestReviewId;
    @display { label: "Body" }
    string body;
    @display { label: "Client Mutation Id" }
    string clientMutationId?;
};

# Represent pull request review delete input payload.
#
# + pullRequestReviewId - The Node ID of the pull request review to delete.
# + clientMutationId - A unique identifier for the client performing the mutation.
public type DeletePullRequestReviewInput record {
    @display { label: "Pull Request Review Id" }
    string pullRequestReviewId;
    @display { label: "Client Mutation Id" }
    string clientMutationId?;
};


# Represent GitHub project templates.
#
# + PROJECT_TEMPLATE_AUTOMATED_KANBAN_V2 - Create a board with v2 triggers to automatically move cards across To do, In progress and Done columns.
# + PROJECT_TEMPLATE_AUTOMATED_REVIEWS_KANBAN - Create a board with triggers to automatically move cards across columns with review automation.
# + PROJECT_TEMPLATE_BASIC_KANBAN - Create a board with columns for To do, In progress and Done.
# + PROJECT_TEMPLATE_BUG_TRIAGE - Create a board to triage and prioritize bugs with To do, priority, and Done columns.
public enum ProjectTemplate {
    PROJECT_TEMPLATE_AUTOMATED_KANBAN_V2 = "AUTOMATED_KANBAN_V2",
    PROJECT_TEMPLATE_AUTOMATED_REVIEWS_KANBAN = "AUTOMATED_REVIEWS_KANBAN",
    PROJECT_TEMPLATE_BASIC_KANBAN = "BASIC_KANBAN",
    PROJECT_TEMPLATE_BUG_TRIAGE = "BUG_TRIAGE"
}

# Represent GitHub project creation input payload.
#
# + ownerName - Repository owner name/ GitHub username.
# + name - Name of the project
# + body - Description of the project.
# + repositoryNames - Array of repository names to be included in the project.
# + clientMutationId - A unique identifier for the client performing the mutation.
# + template - The name of the GitHub-provided template.
public type CreateRepositoryProjectInput record {
    @display { label: "Repository Owner Name" }
    string ownerName;
    @display { label: "Project Name" }
    string name;
    @display { label: "Project Description" }
    string body?;
    @display { label: "Repository Names" }
    string[] repositoryNames?;
    @display { label: "Client Mutation Id" }
    string clientMutationId?;
    @display { label: "Project Template" }
    ProjectTemplate template?;
};

# Represent GitHub project creation input payload.
#
# + ownerId - The owner ID to create the project under.
# + name - The name of project.
# + body - The description of project.
# + repositoryIds - A list of repository IDs to create as linked repositories for the project
# + clientMutationId - A unique identifier for the client performing the mutation.
# + template - The name of the GitHub-provided template.
public type CreateProjectInput record {
    string ownerId;
    string name;
    string body?;
    string[] repositoryIds?;
    string clientMutationId?;
    ProjectTemplate template?;
};

# Represent GitHub project update input payload.
#
# + projectId - The Project ID to update.
# + body - The description of project.
# + name - The name of project.
# + public - Whether the project is public or not.
# + state - Whether the project is open or closed.
# + clientMutationId - A unique identifier for the client performing the mutation.
public type UpdateProjectInput record {
    @display { label: "Project Id" }
    string projectId;
    @display { label: "Project Description" }
    string body?;
    @display { label: "Project Name" }
    string name?;
    @display { label: "Is Public" }
    boolean 'public?;
    @display { label: "Project State" }
    ProjectState state?;
    @display { label: "Client Mutation Id" }
    string clientMutationId?;
};

# Represent GitHub project delete input payload.
#
# + projectId -
# + clientMutationId - A unique identifier for the client performing the mutation.
public type DeleteProjectInput record {
    @display { label: "Project Id" }
    string projectId;
    @display { label: "Client Mutation Id" }
    string clientMutationId?;
};
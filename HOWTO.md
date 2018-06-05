# GitHub Cloner

The GitHub Cloner is a project that replaces itself with a full copy of a GitHub repository, including all branches and all history.

## How to use this project

This project is used in the New Project menu in the Glitch editor. If you want to use it manually, for example to include it in your GitHub repository or in another webpage as a working link, you can do it in two ways:

## Cloning a public repository

Use this url:

    https://glitch.com/edit/#!/remix/github-cloner?GITHUB_REPO=orgname/reponame

## Cloning a private repository

Use this url:

    https://glitch.com/edit/#!/remix/github-cloner?GITHUB_USER=github_login&GITHUB_TOKEN=github_token&GITHUB_REPO=orgname/reponame

The `GITHUB_TOKEN` provided should have repo access.

Please note that this url is _not_ safe to be shared as it contains a GitHub token, which acts as a password.

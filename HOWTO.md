# Git Cloner

The Git Cloner is a project that replaces itself with a full copy of a git repository, including all branches and all history.

## How to use this project

This project is used in the New Project menu in the Glitch editor. If you want to use it manually, for example to include it in your external git hosting site or in another webpage as a working link, you can do it in two ways:

## Cloning a public repository

Use an url like this:

    https://glitch.com/edit/#!/remix/clone-from-repo?&REPO_URL=https://example.com/org/repo.git
    
Example:

    https://glitch.com/edit/#!/remix/clone-from-repo?REPO_URL=https://github.com/howdyai/botkit-starter-slack.git

## Cloning a private repository

Use the same pattern as before, but with the username and password in the url:

    https://glitch.com/edit/#!/remix/clone-from-repo?&REPO_URL=https://user:pass@example.com/org/repo.git

Please note that this url is _not_ safe to be shared as it contains a password.

<div align="center">
<h1>update-7zip-inside-repos<br>
<a href="https://chse.dev/donate"><img alt="Donate" src="https://img.shields.io/badge/Donate_To_This_Project-brightgreen"></a>
<a href="https://github.com/chxseh/update-7zip-inside-repos/actions/workflows/linter.yml"><img alt="GitHub Actions Status" src="https://github.com/chxseh/update-7zip-inside-repos/actions/workflows/linter.yml/badge.svg"></a>
<a href="https://github.com/chxseh/update-7zip-inside-repos/stargazers"><img alt="Stars" src="https://img.shields.io/github/stars/chxseh/update-7zip-inside-repos"></a>
<a href="https://github.com/chxseh/update-7zip-inside-repos/issues"><img alt="Issues" src="https://img.shields.io/github/issues/chxseh/update-7zip-inside-repos"></a>
<a href="https://github.com/chxseh/update-7zip-inside-repos/pulls"><img alt="Pull Requests" src="https://img.shields.io/github/issues-pr/chxseh/update-7zip-inside-repos"></a>
<a href="https://github.com/chxseh/update-7zip-inside-repos/network"><img alt="Forks" src="https://img.shields.io/github/forks/chxseh/update-7zip-inside-repos"></a>
<a href="https://github.com/chxseh/update-7zip-inside-repos/blob/main/LICENSE.md"><img alt="License" src="https://img.shields.io/github/license/chxseh/update-7zip-inside-repos"></a>
</h1></div>

Update 7-Zip inside GitHub Repos automatically.

To use this workflow, please make sure your repository settings look like this:

![img](https://i.imgur.com/NsPU9Gh.png)

The result will look like this:

![result](https://i.imgur.com/DgmecQJ.png)

## Usage

```yaml
---
name: "📝 Update 7-Zip"

on:
  schedule:
    - cron: "0 2 16 * *"

env:
  ACTIONS_ALLOW_UNSECURE_COMMANDS: "true"

jobs:
  update7zip:
    runs-on: "ubuntu-latest"

    steps:
      - uses: actions/checkout@v3
      - run: echo "::set-env name=LATEST_7ZIP::$(curl -s https://raw.githubusercontent.com/chxseh/update-7zip-inside-repos/main/latest/latest.txt | head -n 1)"
      - run: curl https://raw.githubusercontent.com/chxseh/update-7zip-inside-repos/main/update-repos/update.sh | bash
      - uses: peter-evans/create-pull-request@v4
        with:
          commit-message: 📝 Update 7-Zip
          title: Update 7-Zip to ${{ env.LATEST_7ZIP }}
          body: Update 7-Zip to ${{ env.LATEST_7ZIP }}
          branch: update-7zip-${{ env.LATEST_7ZIP }}
          author: "github-actions <41898282+github-actions[bot]@users.noreply.github.com>"
          delete-branch: true

```

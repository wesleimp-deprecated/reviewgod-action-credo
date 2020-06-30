# GitHub Action: Run credo with reviewdog

This action runs [credo](https://github.com/rrrene/credo) with [reviewdog](https://github.com/reviewdog/reviewdog) on pull requests to improve code review experience.

## Inputs

**github_token**

Default is `${{ github.token }}`. If using a pre-built docker image, you must set it explicitly to `github_token: ${{ secrets.github_token }}`.

**credo_lint_flags**

Optional. creado  flags. Default is `--strict --format=flycheck`.

**tool_name**

Optional. Tool name to use for reviewdog reporter. Useful when running multiple actions with different config.

**level**

Optional. Report level for reviewdog [info,warning,error]. It's same as -level flag of reviewdog.

**reporter**

Optional. Reporter of reviewdog command [github-pr-check,github-pr-review]. It's same as `-reporter` flag of reviewdog.

**reviewdog_flags**

Optional. Additional reviewdog flags.

## Example usage

`.github/workflows/reviewdog.yml`

```yaml
name: reviewdog
on: [pull_request]

jobs:
  credo:
    name: runner / credo
    runs-on: ubuntu-latest
    container:
      image: elixir:1.10.3-slim
    steps:
      - uses: actions/checkout@v1
      - name: Install Dependencies
        run: |
          mix local.rebar --force
          mix local.hex --force
          mix deps.get

      - name: credo
        uses: reviewdog/action-credo@v1
        with:
          github_token: ${{ secrets.github_token }}
          reporter: github-pr-review # Change reporter.
```

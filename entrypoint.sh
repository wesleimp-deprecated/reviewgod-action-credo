#!/bin/sh

cd "${GITHUB_WORKSPACE}/${INPUT_WORKDIR}" || exit 1

export REVIEWDOG_GITHUB_API_TOKEN="${INPUT_GITHUB_TOKEN}"

mix credo suggest ${INPUT_CREDO_LINT_FLAGS} \
  | reviewdog -efm="%f:%l:%c: %t: %m" -name="${INPUT_TOOL_NAME}" -reporter="${INPUT_REPORTER:-github-pr-check}" -level="${INPUT_LEVEL}" ${INPUT_REVIEWDOG_FLAGS}

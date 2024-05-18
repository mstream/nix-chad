#!/usr/bin/env bash

set -e
set -E
set -x

REPO_ROOT=$(git rev-parse --show-toplevel)
cd "$REPO_ROOT"

if [[ $(git diff HEAD --stat) != '' ]]; then
	echo 'changes to git working directory after detected:'
	echo 'vvv'
	git status
	git diff HEAD
	echo '^^^'
	echo 'aborting'
	exit 1
else
	echo 'git branch is clean'
fi

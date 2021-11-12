#!/usr/bin/env bash
set -x

# https://stackoverflow.com/questions/42218009/how-to-tell-if-any-command-in-bash-script-failed-non-zero-exit-status/42219754#42219754
# Set err to 1 if pytest failed.
error=0
trap 'error=1' ERR

GIT_ROOT=$(git rev-parse --show-toplevel)
cd "$GIT_ROOT" || exit

pip install opencv-python==4.5.4.58
pip install pandas numpy paddlepaddle paddlehub gast==0.3.3

pytest "$GIT_ROOT"/tests/integration/frameworks/paddle --cov=bentoml --cov-config=.coveragerc -vvv

test $error = 0 # Return non-zero if pytest failed
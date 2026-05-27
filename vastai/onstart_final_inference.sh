#!/usr/bin/env bash
set -euxo pipefail

export DEBIAN_FRONTEND=noninteractive
export DATA_DIRECTORY="${DATA_DIRECTORY:-/workspace}"
export LD_LIBRARY_PATH="/usr/lib/x86_64-linux-gnu:${LD_LIBRARY_PATH:-}"

mkdir -p /workspace
cd /workspace

apt-get update
apt-get install -y --no-install-recommends git git-lfs curl ca-certificates tmux htop nvtop rsync
git lfs install || true

if [ ! -d /workspace/math-sft-final-inference/.git ]; then
  git clone https://github.com/Danny-jin/math-sft-final-inference.git /workspace/math-sft-final-inference
else
  git -C /workspace/math-sft-final-inference pull --ff-only || true
fi

cd /workspace/math-sft-final-inference
bash scripts/setup_vastai_env.sh 2>&1 | tee /workspace/setup_final_repo.log

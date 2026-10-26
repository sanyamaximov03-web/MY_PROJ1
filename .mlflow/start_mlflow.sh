#!/usr/bin/env bash
set -euo pipefail

# Работает из любой директории; предполагает активированное venv из ЛР1.
MLFLOW_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
mkdir -p "$MLFLOW_DIR/mlartifacts"
cd "$MLFLOW_DIR"

if ! command -v mlflow >/dev/null 2>&1; then
  echo 'Команда mlflow не найдена. Активируй venv и установи зависимости.' >&2
  exit 1
fi

echo "Backend SQLite: $MLFLOW_DIR/mlruns.db"
echo "Артефакты: $MLFLOW_DIR/mlartifacts"
echo 'Открой http://127.0.0.1:5000/'

exec mlflow server \
  --host 127.0.0.1 \
  --port 5000 \
  --backend-store-uri "sqlite:///$MLFLOW_DIR/mlruns.db" \
  --artifacts-destination "$MLFLOW_DIR/mlartifacts" \
  --serve-artifacts

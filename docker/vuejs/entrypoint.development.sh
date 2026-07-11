#!/bin/sh
set -e

if [ ! -d "node_modules" ] || [ ! -f "node_modules/.bin/vite" ]; then
    echo "node_modules or vite binary not found. Installing packages..."
    npm install
else
    echo "node_modules already exists. Skipping npm install."
fi

npm run dev -- --host=0.0.0.0 --port=5173
#!/bin/bash

echo "🔥 NUCLEAR CACHE FIX - This will work!"
echo ""

# Kill ALL node processes
echo "1. Killing all Node processes..."
pkill -9 node 2>/dev/null || true
sleep 2

# Remove ALL possible cache
echo "2. Removing ALL cache directories..."
rm -rf .nuxt
rm -rf dist
rm -rf node_modules/.cache
rm -rf node_modules/.vite
rm -rf .cache

# Remove problematic temp files
echo "3. Cleaning up temp files..."
find . -name "*.log" -delete 2>/dev/null || true
find . -name ".DS_Store" -delete 2>/dev/null || true

# Reinstall node_modules
echo "4. Removing and reinstalling node_modules..."
rm -rf node_modules
rm -rf yarn.lock

echo "5. Fresh install..."
yarn install

echo ""
echo "✅ Done! Cache completely cleared!"
echo ""
echo "Now run: yarn dev"
echo ""

#!/bin/bash
# Fix Nuxt cache issues - Clear and rebuild

echo "🔧 Fixing Nuxt cache..."
echo ""

# Stop any running dev servers
echo "1. Stopping any running processes..."
pkill -f "nuxt" 2>/dev/null || true

# Remove cache directories
echo "2. Removing cache directories..."
rm -rf .nuxt
rm -rf node_modules/.cache
rm -rf dist

echo "3. Cache cleared!"
echo ""
echo "✅ Done! Now restart your dev server:"
echo "   yarn dev"
echo ""

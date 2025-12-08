#!/bin/bash
# Quick rebuild and preview

cd /workspaces/Tillerstead

# Clean
echo "🧹 Cleaning..."
rm -rf _site assets/css/main.css

# Build CSS
echo "🎨 Building CSS..."
npm run build:css 2>&1 | grep -v "Deprecation Warning" || true

# Build Jekyll
echo "🏗️  Building Jekyll..."
bundle exec jekyll build --quiet

# Check result
if [ -f "_site/index.html" ]; then
    echo ""
    echo "✅ Build successful!"
    echo ""
    echo "Files updated:"
    ls -lh assets/css/main.css 2>/dev/null || echo "  ⚠️  CSS not found"
    ls -lh _site/index.html 2>/dev/null || echo "  ⚠️  Site not built"
    echo ""
    echo "🌐 To view: npm run dev"
    echo "📱 Or open: file://$(pwd)/_site/index.html"
else
    echo ""
    echo "❌ Build failed! Check output above for errors."
    exit 1
fi

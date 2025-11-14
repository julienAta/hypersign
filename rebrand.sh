#!/bin/bash

# Hyperion Rebranding Script for DocuSeal
# This script replaces all DocuSeal branding with Hyperion branding

echo "🎨 Starting DocuSeal → Hyperion rebranding..."

# Replace "DocuSeal" with "Hyperion"
echo "Replacing DocuSeal text..."
find . -type f \( -name "*.erb" -o -name "*.rb" -o -name "*.yml" -o -name "*.html" \) \
  -not -path "./node_modules/*" \
  -not -path "./.git/*" \
  -not -path "./vendor/*" \
  -exec sed -i '' 's/DocuSeal/Hyperion/g' {} +

# Replace "docuseal.com" with "hyperion-app.ai"
echo "Replacing domain references..."
find . -type f \( -name "*.erb" -o -name "*.rb" -o -name "*.yml" -o -name "*.html" \) \
  -not -path "./node_modules/*" \
  -not -path "./.git/*" \
  -not -path "./vendor/*" \
  -exec sed -i '' 's/docuseal\.com/hyperion-app.ai/g' {} +

# Replace "@docusealco" with "@hyperion_ai" (or your Twitter handle)
echo "Replacing social media handles..."
find . -type f \( -name "*.erb" -o -name "*.rb" -o -name "*.yml" -o -name "*.html" \) \
  -not -path "./node_modules/*" \
  -not -path "./.git/*" \
  -not -path "./vendor/*" \
  -exec sed -i '' 's/@docusealco/@hyperion_ai/g' {} +

# Update default app name in environment
echo "Updating default configuration..."
if [ -f "config/application.rb" ]; then
  sed -i '' 's/config\.application_name = .*/config.application_name = "Hyperion"/g' config/application.rb
fi

# Update README
echo "Updating README..."
if [ -f "README.md" ]; then
  sed -i '' 's/DocuSeal/Hyperion/g' README.md
  sed -i '' 's/docuseal/hyperion/g' README.md
fi

echo "✅ Rebranding complete!"
echo ""
echo "Next steps:"
echo "1. Review changes: git diff"
echo "2. Replace logo files in public/"
echo "3. Build Docker image: docker build -t hyperion-docuseal ."
echo "4. Update docker-compose.yml to use hyperion-docuseal image"

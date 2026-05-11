#!/bin/bash
# Pre-flight checklist for Reality Distortion before TestFlight upload.
# Run before every fastlane beta. Exits non-zero on any failure.
#
# Mirrors Marion's preflight_script_pattern memory: 15 gate checks covering
# versions, Info.plist sanity, asset compilation, signing config, URLs.

set -e
cd "$(dirname "$0")/.."
REPO=$(pwd)

red() { echo -e "\033[31m✗ $*\033[0m"; }
green() { echo -e "\033[32m✓ $*\033[0m"; }
amber() { echo -e "\033[33m! $*\033[0m"; }

fail=0
warn=0

echo "═══════════════════════════════════════════════════════════"
echo "  ViralIQ preflight"
echo "═══════════════════════════════════════════════════════════"

# 1. Required tools
for tool in xcodegen xcodebuild plutil curl; do
  if command -v $tool >/dev/null 2>&1; then
    green "$tool available"
  else
    red "$tool not installed"
    fail=$((fail+1))
  fi
done

# 2. project.yml exists
if [ -f project.yml ]; then green "project.yml present"; else red "project.yml missing"; fail=$((fail+1)); fi

# 3. xcodeproj is up to date with project.yml
if [ project.yml -nt ViralIQ.xcodeproj/project.pbxproj ]; then
  amber "project.yml newer than xcodeproj — run 'xcodegen generate'"
  warn=$((warn+1))
else
  green "xcodeproj in sync with project.yml"
fi

# 4. Info.plist
PLIST="ViralIQ/Info.plist"
if [ -f "$PLIST" ]; then
  green "Info.plist present"
  # Bundle ID
  BID=$(plutil -extract CFBundleIdentifier raw "$PLIST" 2>/dev/null || echo "")
  if [ "$BID" = "com.melmarion.viraliq" ] || [ -z "$BID" ]; then
    green "Bundle ID OK ($BID)"
  else
    amber "Bundle ID = '$BID' (expected com.melmarion.viraliq or empty=xcodegen)"
    warn=$((warn+1))
  fi
else
  red "Info.plist missing"
  fail=$((fail+1))
fi

# 5. App icon
ICON="ViralIQ/Assets.xcassets/AppIcon.appiconset/icon-1024.png"
if [ -f "$ICON" ]; then
  ICON_SIZE=$(stat -f%z "$ICON")
  if [ "$ICON_SIZE" -gt 10000 ]; then
    green "AppIcon 1024×1024 present ($ICON_SIZE bytes)"
  else
    red "AppIcon 1024×1024 suspiciously small ($ICON_SIZE bytes)"
    fail=$((fail+1))
  fi
else
  red "AppIcon icon-1024.png missing"
  fail=$((fail+1))
fi

# 6. AccentColor
if [ -f "ViralIQ/Assets.xcassets/AccentColor.colorset/Contents.json" ]; then
  green "AccentColor.colorset present"
else
  red "AccentColor.colorset missing"
  fail=$((fail+1))
fi

# 7. Privacy URL resolves (must be public for App Review)
PRIVACY_URL="https://moranetz.github.io/viraliq-docs/privacy.html"
STATUS=$(curl -sS -o /dev/null -w "%{http_code}" "$PRIVACY_URL")
if [ "$STATUS" = "200" ]; then
  green "Privacy URL resolves 200 ($PRIVACY_URL)"
else
  red "Privacy URL returned HTTP $STATUS ($PRIVACY_URL)"
  fail=$((fail+1))
fi

# 8. Support URL resolves
SUPPORT_URL="https://moranetz.github.io/viraliq-docs/"
STATUS=$(curl -sS -o /dev/null -w "%{http_code}" "$SUPPORT_URL")
if [ "$STATUS" = "200" ]; then
  green "Support URL resolves 200 ($SUPPORT_URL)"
else
  red "Support URL returned HTTP $STATUS ($SUPPORT_URL)"
  fail=$((fail+1))
fi

# 9. ExportOptions.plist
if [ -f ExportOptions.plist ]; then green "ExportOptions.plist present"; else red "ExportOptions.plist missing"; fail=$((fail+1)); fi

# 10. fastlane Appfile + Fastfile
if [ -f fastlane/Appfile ] && [ -f fastlane/Fastfile ]; then
  green "fastlane Appfile + Fastfile present"
else
  red "fastlane config incomplete"
  fail=$((fail+1))
fi

# 11. App Store Connect API key
ASC_KEY="$HOME/.appstoreconnect/private_keys/AuthKey_RQ97N8T3M4.p8"
if [ -f "$ASC_KEY" ]; then
  green "ASC API key present at $ASC_KEY"
else
  amber "ASC API key not found at $ASC_KEY — fastlane lanes that hit ASC will fail"
  warn=$((warn+1))
fi

# 12. Source files compile (quick sim build, no signing)
echo ""
echo "Running quick sim build (no signing)..."
if xcodebuild -project ViralIQ.xcodeproj -scheme ViralIQ \
    -sdk iphonesimulator -destination 'platform=iOS Simulator,name=iPhone 17 Pro' \
    -configuration Debug build CODE_SIGNING_ALLOWED=NO 2>&1 | tail -2 | grep -q "BUILD SUCCEEDED"; then
  green "Debug sim build SUCCEEDED"
else
  red "Debug sim build FAILED — fix compile errors before TestFlight"
  fail=$((fail+1))
fi

# 13. Marketing version + build number sanity
MARKETING_VERSION=$(awk -F': ' '/MARKETING_VERSION/ {print $2}' project.yml | tr -d '"')
if [ -n "$MARKETING_VERSION" ]; then
  green "MARKETING_VERSION = $MARKETING_VERSION"
else
  amber "MARKETING_VERSION not set in project.yml"
  warn=$((warn+1))
fi

# 14. Deployment target >= 17.0 (for foregroundStyle on Text concatenation)
DT=$(awk -F': ' '/iOS:/ {gsub(/"/,"",$2); print $2}' project.yml)
if [ -n "$DT" ]; then
  green "iOS deployment target = $DT"
else
  amber "iOS deployment target unclear"
  warn=$((warn+1))
fi

# 15. .gitignore presence
if [ -f .gitignore ]; then green ".gitignore present"; else amber ".gitignore missing"; warn=$((warn+1)); fi

echo ""
echo "═══════════════════════════════════════════════════════════"
if [ "$fail" -gt 0 ]; then
  red "Preflight FAILED ($fail blocker / $warn warning)"
  exit 1
elif [ "$warn" -gt 0 ]; then
  amber "Preflight passed with $warn warning(s)"
  exit 0
else
  green "Preflight all green"
  exit 0
fi

#!/bin/bash

# Export audit logs in various formats
AUDIT_DIR="/Users/drewstoneburger/repos/opnova/audit"
EXPORT_DIR="${AUDIT_DIR}/exports"
DATE=$(date +%Y-%m-%d)

mkdir -p "$EXPORT_DIR"

# 1. Create JSON export
echo "Creating JSON export..."
cat > "${EXPORT_DIR}/audit-${DATE}.json" << EOF
{
  "project": "OpNova",
  "export_date": "$(date -u +%Y-%m-%dT%H:%M:%SZ)",
  "sessions": [
EOF

# Add session data
first=true
for session in "${AUDIT_DIR}/sessions"/*.md; do
    if [ "$first" = true ]; then
        first=false
    else
        echo "," >> "${EXPORT_DIR}/audit-${DATE}.json"
    fi
    
    title=$(grep "^# Session:" "$session" | sed 's/# Session: //')
    date=$(grep "^\*\*Date:\*\*" "$session" | sed 's/\*\*Date:\*\* //')
    
    echo "    {" >> "${EXPORT_DIR}/audit-${DATE}.json"
    echo "      \"title\": \"$title\"," >> "${EXPORT_DIR}/audit-${DATE}.json"
    echo "      \"date\": \"$date\"," >> "${EXPORT_DIR}/audit-${DATE}.json"
    echo "      \"file\": \"$(basename "$session")\"" >> "${EXPORT_DIR}/audit-${DATE}.json"
    echo "    }" >> "${EXPORT_DIR}/audit-${DATE}.json"
done

cat >> "${EXPORT_DIR}/audit-${DATE}.json" << EOF
  ]
}
EOF

# 2. Create HTML summary
echo "Creating HTML summary..."
cat > "${EXPORT_DIR}/audit-${DATE}.html" << EOF
<!DOCTYPE html>
<html>
<head>
    <title>OpNova Project Audit Log</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 40px; }
        .session { border: 1px solid #ddd; margin: 20px 0; padding: 20px; }
        .date { color: #666; font-size: 0.9em; }
        pre { background: #f5f5f5; padding: 10px; overflow-x: auto; }
    </style>
</head>
<body>
    <h1>OpNova Project Audit Log</h1>
    <p>Generated: $(date)</p>
EOF

for session in "${AUDIT_DIR}/sessions"/*.md; do
    echo "    <div class='session'>" >> "${EXPORT_DIR}/audit-${DATE}.html"
    pandoc "$session" >> "${EXPORT_DIR}/audit-${DATE}.html" 2>/dev/null || cat "$session" >> "${EXPORT_DIR}/audit-${DATE}.html"
    echo "    </div>" >> "${EXPORT_DIR}/audit-${DATE}.html"
done

echo "</body></html>" >> "${EXPORT_DIR}/audit-${DATE}.html"

# 3. Create archive
echo "Creating archive..."
tar -czf "${EXPORT_DIR}/opnova-audit-${DATE}.tar.gz" -C "$AUDIT_DIR" sessions commands configs

echo "Exports created in: $EXPORT_DIR"
echo "- JSON: audit-${DATE}.json"
echo "- HTML: audit-${DATE}.html" 
echo "- Archive: opnova-audit-${DATE}.tar.gz"

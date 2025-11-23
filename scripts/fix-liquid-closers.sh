#!/usr/bin/env bash
set -euo pipefail
echo "Starting fix-liquid-closers"
# Find literal Liquid incorrect closers
candidates=$(git grep -n --full-name -E '\{%\s*end\s*%\}' || true)
if [[ -z "$candidates" ]]; then
  echo "No '{% end %}' occurrences found."
else
  echo "Candidates for '{% end %}':"
  echo "$candidates"
fi

apply_replacement() {
  local file="$1"
  local lineno="$2"
  local start=$(( lineno > 40 ? lineno - 40 : 1 ))
  opener=$(sed -n "${start},${lineno}p" "$file" | tac | grep -m1 -E '{%\s*(if|for|capture|unless|case)\b' || true)
  if [[ -z "$opener" ]]; then
    echo "  Could not infer opener for $file:$lineno — SKIP"
    return
  fi
  if echo "$opener" | grep -q '{%\s*if\b'; then repl='{% endif %}'; fi
  if echo "$opener" | grep -q '{%\s*for\b'; then repl='{% endfor %}'; fi
  if echo "$opener" | grep -q '{%\s*capture\b'; then repl='{% endcapture %}'; fi
  if echo "$opener" | grep -q '{%\s*unless\b'; then repl='{% endunless %}'; fi
  if echo "$opener" | grep -q '{%\s*case\b'; then repl='{% endcase %}'; fi
  if [[ -z "${repl:-}" ]]; then
    echo "  No replacement inferred for $file:$lineno — SKIP"
    return
  fi
  echo "  Replacing in $file:$lineno -> $repl"
  perl -0777 -pe "s/\{%\s*end\s*%\}/$repl/g" -i.bak "$file"
}

# Iterate candidates and apply replacements where possible
while IFS= read -r line; do
  file=$(echo "$line" | cut -d: -f1)
  lineno=$(echo "$line" | cut -d: -f2)
  apply_replacement "$file" "$lineno"
done <<< "$candidates"

# Report ERB-like tags for manual review
echo ""
echo "Scanning for ERB-like tags (<% ... %>) — listing occurrences for manual review"
git grep -n --full-name -E '<%[^=]' || true

echo "Done. Please review .bak files for backups and run 'bundle exec jekyll build --trace' to verify."

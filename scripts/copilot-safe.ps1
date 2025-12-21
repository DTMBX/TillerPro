<#
copilot-safe.ps1
Launch GitHub Copilot CLI with a tight allowlist and hard denies.
Edit the allow/deny rules to match your repo’s AI instruction guide boundaries.

Usage:
  pwsh -File .\scripts\copilot-safe.ps1
#>

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

# --- Guardrails: only run from inside a trusted repo root ---
$repoRoot = (Resolve-Path ".").Path

# Optional: require your instruction files to exist (adjust paths to your repo)
$requiredFiles = @(
  ".github\copilot-instructions.md",
  "AI_PROJECT_INSTRUCTIONS.md",
  "scripts"  # folder check below
)

foreach ($p in $requiredFiles) {
  if (!(Test-Path (Join-Path $repoRoot $p))) {
    throw "Missing required repo instruction path: $p`nRefusing to start Copilot CLI."
  }
}

# --- Copilot CLI policy ---
# Prefer: allow specific tools/commands; deny the sharp knives.
# Notes:
# - GitHub docs show Copilot CLI supports allow/deny tool patterns and an allow-all-tools mode (don’t use allow-all-tools). :contentReference[oaicite:1]{index=1}
# - Example patterns shown publicly include allowing git:* but denying git push. :contentReference[oaicite:2]{index=2}

# Allowlist examples (tighten/expand as needed)
$allowTools = @(
  # File edits (if you want Copilot to write)
  "write",

  # Read-only ops are usually safest
  "read",

  # Shell: allow common dev tooling but keep it narrow.
  # These patterns are illustrative; adjust to your workflow.
  "shell(git status)",
  "shell(git diff*)",
  "shell(git log*)",
  "shell(git add*)",
  "shell(git commit*)",

  "shell(npm*)",
  "shell(node*)",
  "shell(ruby*)",
  "shell(bundle*)",
  "shell(jekyll*)"
)

# Denylist examples (keep these blocked)
$denyTools = @(
  # Destructive file ops
  "shell(rm*)",
  "shell(rmdir*)",
  "shell(del*)",
  "shell(erase*)",
  "shell(Remove-Item*)",

  # Permission/system tampering
  "shell(chmod*)",
  "shell(chown*)",
  "shell(icacls*)",

  # Network fetch/execute patterns (tighten as you see fit)
  "shell(curl*)",
  "shell(wget*)",
  "shell(Invoke-WebRequest*)",
  "shell(Invoke-RestMethod*)",

  # Git operations that can publish/overwrite remotely
  "shell(git push*)",
  "shell(git fetch*)",
  "shell(git remote*)"
)

# Build args for the copilot CLI process
$args = @()

foreach ($t in $allowTools) { $args += @("--allow-tool", $t) }
foreach ($t in $denyTools)  { $args += @("--deny-tool",  $t) }

# Start Copilot CLI in the current directory.
# The “trust this folder” prompt is a separate concept in Copilot CLI docs; you can choose “remember this folder” once to stop repeated trust prompts. :contentReference[oaicite:3]{index=3}
Write-Host "Starting Copilot CLI with allow/deny rules..." -ForegroundColor Green
& copilot @args

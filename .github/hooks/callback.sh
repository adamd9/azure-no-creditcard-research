#!/bin/bash
# Copilot CLI hook callback — sends hook payload to the agent's HTTP server
# HOOK_TYPE and AGENT_CALLBACK_URL are set via environment variables

INPUT=$(cat)

if [ -z "$AGENT_CALLBACK_URL" ]; then
  echo "[copilot-hook] AGENT_CALLBACK_URL not set, skipping callback" >&2
  exit 0
fi

# POST the hook payload to the agent callback endpoint
curl -s -X POST "${AGENT_CALLBACK_URL}/api/copilot/callback" \
  -H "Content-Type: application/json" \
  -d "{\"hookType\": \"${HOOK_TYPE}\", \"payload\": ${INPUT}}" \
  --connect-timeout 5 \
  --max-time 10 \
  2>/dev/null || echo "[copilot-hook] callback failed (non-fatal)" >&2

exit 0

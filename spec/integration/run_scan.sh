#!/usr/bin/env bash
#
# Runs WPScan against the demo WordPress site set up by setup_wp_test_env.sh and
# verifies the scan results via verify_results.rb. Used by the GitHub Actions
# integration test (.github/workflows/build.yml) and runnable locally to iterate
# on the integration test suite.
#
# CI runs this twice against the same site, once with the paid/enterprise API token
# and once with a free one, so that plan specific API regressions are caught (the
# free plan lost access to the v4 plugin/theme endpoints in
# https://github.com/wpscanteam/wpscan/issues/2079 without CI noticing).
#
# Usage (local), after setup_wp_test_env.sh has prepared the site:
#   export WPSCAN_API_TOKEN=...
#   bash spec/integration/run_scan.sh
#
# Run from the wpscan repo root. The scan output is written to ./scan-results.json
# in the current working directory.
#
# Environment variables:
#   WPSCAN_API_TOKEN  (required) API token to scan with
#   TARGET_URL        Site to scan (default: https://wordpress-test.ddev.site)
#   OUTPUT_FILE       Where the JSON results are written (default: scan-results.json)
#   EXPECTED_PLAN     Plan the token must resolve to, e.g. "free" or "enterprise"
#                     (default: no assertion)
#   MIN_API_REQUESTS  API requests the token must have left before scanning (default: 10)

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "${SCRIPT_DIR}/../.." && pwd)"
TARGET_URL="${TARGET_URL:-https://wordpress-test.ddev.site}"
OUTPUT_FILE="${OUTPUT_FILE:-scan-results.json}"
EXPECTED_PLAN="${EXPECTED_PLAN:-}"
# The scan spends one API request per detected plugin, theme and WordPress version,
# which is ~6 for this test site. 10 leaves some headroom for added test fixtures.
MIN_API_REQUESTS="${MIN_API_REQUESTS:-10}"

# Exported so verify_results.rb below picks it up
export EXPECTED_PLAN

if [ -z "${WPSCAN_API_TOKEN:-}" ]; then
  echo "Error: WPSCAN_API_TOKEN is not set. Get a token at https://wpscan.com/profile"
  exit 1
fi

if ! command -v jq > /dev/null 2>&1; then
  echo "Error: jq is required by the API pre-flight below (pre-installed on GitHub runners)"
  exit 1
fi

STATUS_URL="https://wpscan.com/api/v4/status"

# Pre-flight the token against the API status endpoint. This is the same endpoint WPScan
# itself calls at the start and end of every scan, so it costs no quota, and it turns the
# two ways a spent token fails into one explicit message: an exhausted quota otherwise
# either aborts the scan with a bare exit code 4, or (when it runs out mid scan) has the
# API's 429s swallowed into empty vulnerability data by DB::VulnApi.get, which is
# indistinguishable from a genuine detection regression.
echo "Checking API token status at ${STATUS_URL}"

if ! STATUS_RESPONSE="$(curl -sS --max-time 30 -w '\n%{http_code}' \
  -H "Authorization: Token token=${WPSCAN_API_TOKEN}" "${STATUS_URL}")"; then
  echo "Error: could not reach the WPScan API status endpoint. See https://status.wpscan.com/"
  exit 1
fi

STATUS_CODE="$(printf '%s' "${STATUS_RESPONSE}" | tail -n1)"
STATUS_JSON="$(printf '%s' "${STATUS_RESPONSE}" | sed '$d')"

# A rejected token answers 401 {"status":"unauthorized"}, so the body alone is not enough
if [ "${STATUS_CODE}" != "200" ]; then
  echo "Error: the API status endpoint returned HTTP ${STATUS_CODE}: ${STATUS_JSON}"
  echo "The token is likely invalid or expired. Service status: https://status.wpscan.com/"
  exit 1
fi

if ! printf '%s' "${STATUS_JSON}" | jq -e . > /dev/null 2>&1; then
  echo "Error: the API status endpoint returned a non-JSON response: ${STATUS_JSON}"
  exit 1
fi

API_STATUS="$(printf '%s' "${STATUS_JSON}" | jq -r '.status // ""')"
PLAN="$(printf '%s' "${STATUS_JSON}" | jq -r '.plan // ""')"
REMAINING="$(printf '%s' "${STATUS_JSON}" | jq -r '.requests_remaining // ""')"

if [ "${API_STATUS}" = "forbidden" ]; then
  echo "Error: the API token was rejected (status: ${API_STATUS})"
  exit 1
fi

if [ -n "${EXPECTED_PLAN}" ] && [ "${PLAN}" != "${EXPECTED_PLAN}" ]; then
  echo "Error: expected the ${EXPECTED_PLAN} plan, token reports '${PLAN}'. Wrong token in this env?"
  exit 1
fi

# Enterprise plans always report -1 (unlimited), so only a non negative count is worth
# gating on. The regexp also skips any non numeric value the API may return.
if [[ "${REMAINING}" =~ ^[0-9]+$ ]] && [ "${REMAINING}" -lt "${MIN_API_REQUESTS}" ]; then
  echo "Error: the ${PLAN} token has ${REMAINING} of the ${MIN_API_REQUESTS} API requests the scan needs."
  echo "This is a quota problem, not a WPScan regression: wait for the daily reset or raise the limit."
  exit 1
fi

if [ "${REMAINING}" = "-1" ]; then
  REMAINING="unlimited"
fi

echo "API token OK: plan=${PLAN}, requests_remaining=${REMAINING}"

# Update the local vulnerability DB so the scan has fresh data
bundle exec ruby -I"${REPO_ROOT}/lib" "${REPO_ROOT}/bin/wpscan" --update

# Run the scan. Exit code 5 means vulnerabilities were found, which is what we
# expect for this intentionally-vulnerable demo site. Any other code is a failure.
# Using passive plugin/theme detection to avoid false positives in the test env.
set +e
bundle exec ruby -I"${REPO_ROOT}/lib" "${REPO_ROOT}/bin/wpscan" \
  --url "${TARGET_URL}" \
  --disable-tls-checks \
  --clear-cache \
  --format json \
  --output "${OUTPUT_FILE}" \
  --api-token "${WPSCAN_API_TOKEN}" \
  -e vp,vt,u,cb,dbe,tt \
  --plugins-detection passive \
  --themes-detection passive
EXIT_CODE=$?
set -e

if [ "${EXIT_CODE}" -ne 5 ]; then
  echo "Expected wpscan exit code 5 (vulnerabilities found), got ${EXIT_CODE}"
  exit 1
fi

echo "WPScan found vulnerabilities (exit code 5)"

# Verify the JSON output matches our expectations
bundle exec ruby "${SCRIPT_DIR}/verify_results.rb" "${OUTPUT_FILE}"

#!/usr/bin/env bash
#
# Runs WPScan against the demo WordPress site set up by setup_wp_test_env.sh and
# verifies the scan results via verify_results.rb. Used by the GitHub Actions
# integration test (.github/workflows/build.yml) and runnable locally to iterate
# on the integration test suite.
#
# Usage (local), after setup_wp_test_env.sh has prepared the site:
#   export WPSCAN_API_TOKEN=...
#   bash spec/integration/run_scan.sh
#
# Run from the wpscan repo root. The scan output is written to ./scan-results.json
# in the current working directory.

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "${SCRIPT_DIR}/../.." && pwd)"
TARGET_URL="${TARGET_URL:-https://wordpress-test.ddev.site}"
OUTPUT_FILE="${OUTPUT_FILE:-scan-results.json}"

if [ -z "${WPSCAN_API_TOKEN:-}" ]; then
  echo "Error: WPSCAN_API_TOKEN is not set. Get a token at https://wpscan.com/profile"
  exit 1
fi

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

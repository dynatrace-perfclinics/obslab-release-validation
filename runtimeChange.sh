#!/bin/bash
# Usage: ./runtimeChange.sh flagKey newFlagValue remediationValueIfFailure
# eg. ./runtimeChange.sh paymentServiceFailure on off

echo "Changing $1 to $2 but in case of failure, revert back to $3"

##############
# Step 1
# Inform Dynatrace that a configuration change is occurring
##############
curl -X POST "$DT_ENDPOINT_UC14/api/v2/events/ingest" \
  -H "accept: application/json; charset=utf-8" -H "Authorization: Api-Token $DT_API_TOKEN_UC14" -H "Content-Type: application/json; charset=utf-8" \
  -d "{
  \"title\": \"featureflag change\",
  \"entitySelector\": \"type(SERVICE),entityName.equals(paymentservice)\",
  \"eventType\": \"CUSTOM_INFO\",
  \"timeout\": 1,
  \"properties\": {
    \"type\": \"configuration_change\",
    \"feature_flag.key\": \"$1\",
    \"defaultValue\": \"$2\",
    \"remediation.feature_flag.key\": \"$1\",
    \"remediation.defaultValue\": \"$3\"
  }
}"

##############
# Step 2
# Change the $1 feature flag key to the value of $2
# Save the resulting JSON back to the same file using sponge
##############
jq ".flags.$1.defaultVariant = \"$2\"" src/flagd/demo.flagd.json | sponge src/flagd/demo.flagd.json

echo
echo "flag: $1 property: defaultVariant set to value: $2 revert value (in case of problems): $3"
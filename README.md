# demo-release-validation

## Prerequisites

You must have the following to follow this hands on demo.

1. A Dynatrace environment ([sign up here](https://dynatrace.com/trial))
1. A Dynatrace API token (see below)

Save the Dynatrce environment URL **without** the trailing slash: eg. `https://abc12345.live.dynatrace.com`

### Create API Token
In Dynatrace:

1. Press `ctrl + k`. Search for `access tokens`.
1. Create a new access token with the following permissions:
   - `metrics.ingest`
   - `logs.ingest`
   - `openTelemetryTrace.ingest`
   - `openpipeline.events_sdlc`

Save this token and provide it when requested during startup.

## Begin

Click this button to open the demo environment.

[![Open in GitHub Codespaces](https://github.com/codespaces/badge.svg)](https://codespaces.new/dynatrace-perfclinics/demo-release-validation)

```
kubectl -n default wait --for=condition=Ready --all --timeout 300s pod
kubectl -n default port-forward svc/my-otel-demo-frontendproxy 8080
```

Go to ports tab, right click the `demo app` entry and choose `Open in browser`.

## Validate Telemetry

In Dynatrace:

1. Press `Ctrl + k`. Search for `services`. Go to services screen and validate you can see services.
1. Open a service and validate that the URL contains `SERVICE-****`.
    1. If the URL contains `CUSTOM_DEVICE-****`:
        1. Press `Ctrl + k` and search for `settings`.
        1. Go to `Service Detection > Unified services for OpenTelemetry` and ensure the toggle is on.

1. Press `Ctrl + k`. Search for `distributed traces`. Go to distributed traces and validate data is flowing.
1. Press `Ctrl + k`. Search for `metrics`. Go to metrics and search for `app.` and validate you can see some metrics.
1. Press `Ctrl + k`. Search for `notebooks`. Create a new notebook then click `+` to add a new `DQL` section. Type: `fetch logs, scanLimitGBytes: 1 | filter contains(content, "conversion")` and validate you can see some log lines.

If these four things are OK, your telemetry is flowing correctly into Dynatrace.

## Create Site Reliability Guardian

Site reliability guardians are a mechanism to automate deployment checks.

1. Press `Ctrl + k` search for `Site Reliability Guardian` and select the app.
1. Click `+ Guardian` to add a new guardian.
1. Under `Four Golden Signals` choose `Use template`.
1. Click `Run query` and select `frontend`. Click `Apply to template (1)`.
1. Hover over the `Saturation` objective and delete it. There are no resource statistics available so this objective cannot be evaluated.
1. At top top right, customise the guardian name to be called `Four golden signals (frontend)`.
1. Click `Save`

## Create Workflow

Running guardians can be automated so they happen whenever you prefer (on demand / on schedule / event based).

In this demo, a load test will run and trigger a guardian (via an event sent from the load test). Let's plumb that together now.

Ensure you are still on the `Four golden signals (frontend)` screen.

1. Click the `Automate` button. This will create a template workflow.
1. Change the `event type` from `bizevents` to `events`
1. Change the `Filter query` to `event.type == "test" AND event.category == "finished" AND service == "frontend"` (this will be explained soon)

The workflow is now created and connected to the guardian. It will be triggered whenever the platform receives an event like below.

In this demo, the load test tool ([k6](https://k6.io)) will send this event but it could come from anywhere (Shell scripts, GitHub Actions, Terraform, Jenkins etc.)

```
curl -i -X POST "https://abc12345.live.dynatrace.com/platform/ingest/v1/events.sdlc" ^
     -H "Content-Type: application/json" ^
     -H "Authorization: Api-Token dt0c01.*****.****" ^
     -d "{\"event.type\":\"test\", \"event.category\":\"finished\", \"service\": \"frontend\", \"duration\": \"30m\"}"
```

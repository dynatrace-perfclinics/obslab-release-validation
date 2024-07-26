# Enable Automatic Baselining for Site Reliability Guardian

Objectives that are set to "auto baseline" in Dynatrace Site Reliability Guardians require `5` runs in order to enable the baselines.

In a real scenario, these test runs would likely be spread over hours, days or weeks. This provides Dynatrace with ample time to gather sufficient usage data.

For demo purposes, 5 seperate "load tests" will be triggered in quick succession to enable the baselining.

First, apply the load test script:

```
kubectl apply -f .devcontainer/k6/k6-load-test-script.yaml
```

## Trigger the First Load Test

```
kubectl apply -f .devcontainer/k6/k6-srg-training-run1.yaml
```

## Trigger the Second Load Test

Wait a few seconds and trigger the second load test:

```
kubectl apply -f .devcontainer/k6/k6-srg-training-run2.yaml
```

## Trigger the Third Load Test

Wait a few seconds and trigger the third load test:

```
kubectl apply -f .devcontainer/k6/k6-srg-training-run3.yaml
```
## Trigger the Fourth Load Test

Wait a few seconds and trigger the fourth load test:

```
kubectl apply -f .devcontainer/k6/k6-srg-training-run4.yaml
```

## Trigger the Final Training Load Test

Wait a few seconds and trigger the final (fifth) load test:

```
kubectl apply -f .devcontainer/k6/k6-srg-training-run5.yaml
```

## Wait for Completion

Each load test runs for 1 minute so keep running the following command until you see all jobs listed as `Complete`:

```
kubectl get jobs
```

The automatic baselines for the guardian are now enabled. You can proceed to use the guardian for "real" evaluations.

## [Click Here to Continue...](enable-auto-baselines.md)
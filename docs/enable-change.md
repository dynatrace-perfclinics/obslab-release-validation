A product manager informs you that they're ready to release their new feature. They ask you to enable the feature and run the load test in a dev environment.

They tell you that the new feature is behind a flag called `paymentServiceFailure` (yes, an obvious name for this demo) and they tell you to change the `defaultValue` from `off` to `on`.

## Update the Feature Flag and Inform Dynatrce

Run the following script which:

- Notifies Dynatrace using a `CUSTOM_INFO` event of the change inc. the new value
- Changes the `defaultValue` of the `paymentServiceFailure` feature flag to `on`
- Applies the configuration change

```
./runtimeChange.sh paymentServiceFailure on
```

## Run Acceptance Load Test

It is time to run an acceptance load test to see if the new feature has caused a regression.

This load test will run for 3 minutes and then trigger the site reliability guardian again:

```
kubectl apply -f .devcontainer/k6/k6-after-change.yaml
```

## [What's Next?](whats-next.md)
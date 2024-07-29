# demo-release-validation

The docs are now build with mkdocs. `mkdocs serve` to see (or look at `/docs` folder)

## TODO
- Address any TODOs in docs
- Auto capture span attributes: `grpc.error_message`, `grpc.error_name` and `app.payment.amount` ([sample cURL here](https://github.com/dynatrace-perfclinics/traveladvisor/blob/55c3fabb5ec49cc03694057112ac69fe8edb2d64/.devcontainer/deployment.sh#L5))
- Toggle the `paymentServiceFailure` feature flag + add docs
- Investigate move guardian to `checkout` service and / or frontend + document

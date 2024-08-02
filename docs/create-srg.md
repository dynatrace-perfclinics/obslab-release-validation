# Create Site Reliability Guardian

[Site reliability guardians](https://docs.dynatrace.com/docs/platform-modules/automations/site-reliability-guardian){target="_blank"} are a mechanism to automate analysis when changes are made. They can be used in production (on a CRON) or as deployment checks (eg. pre and post deployment health checks, security checks, infrastructure health checks).

We will create a guardian to check the `frontend` microservice that the user interacts with.

* Press `ctrl + k` search for `Site Reliability Guardian` and select the app.
* Click `+ Guardian` to add a new guardian.
* Under `Four Golden Signals` choose `Use template`.
* Click `Run query` and select `frontend`. Click `Apply to template (1)`.
* Hover over the `Saturation` objective and delete it (there are no resource statistics from OpenTelemetry available so this objective cannot be evaluated).
* At the top right of the screen, customise the guardian name to be called `Three golden signals (frontend)`.
* Click `Save`

![dynatrace site reliability guardian: screen 1](images/dt-srg-screen-1.png)
![dynatrace site reliability guardian: screen 2](images/dt-srg-screen-2.png)
![dynatrace site reliability guardian: screen 3](images/dt-srg-screen-3.png) # TODO: Update screenshot to highlight `frontend` not `frontend-web`
![dynatrace site reliability guardian: screen 4](images/dt-srg-screen-4.png)
![dynatrace site reliability guardian: screen 5](images/dt-srg-screen-5.png)

Note: This process can be automated for at-scale usage using [Monaco or Terraform](https://docs.dynatrace.com/docs/manage/configuration-as-code){target="_blank"}.

```
## TODO: Need secondary tutorial on this? Link to it for each...
```

## [Click Here to Continue...](automate-srg.md)
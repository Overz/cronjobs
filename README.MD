# CRONJOBS

Example of cronjobs running in an alpine container pointing logs to the [logs](./logs/) directory of this repository and performing updates.

The [periodic](./etc/periodic/) directory contains the cron files and they are run with a `run-parts` command that goes through all the scripts inside the folders pointed to by the [crontab](./etc/ configuration) crontabs/root).

To check whether or not each script should be executed an auxiliary file [disable](./etc/periodic/disable) was created, in order to add the `name` of each file that will be **disabled**.

---

## Environments

The [environments.conf](./environments.conf) file is used to build the docker images through the [docker](./docker) script, which was created to help perform these tasks.

Nothing prevents various conditions or `environments` files from being made.

An `environments.local.conf` file was used to cover local settings and hide passwords/access tokens, so it has not been verified.

## Running

An **argument** is required to run the application, which defines which configuration should be used for the build.

- `L`: local, also accepted as lowercase
- `P`: production, also accepted as lowercase

Remembering that the **environments.conf** file must be properly configured! For more script questions, run the `help` command.

```sh
# root of this repository

$ ./docker all l

# OR

$ ./docker build l && ./docker run l

```

---

## Arch

Because the configuration of these cronjobs are symbolic links, any changes made to the repository, the internal update also occurs, thus reflecting directly on the application as a whole.

See [entrypoint](./entrypoint)

## Logs

The generated log schemas were just for demonstration/examples of how a cronjob performs its internal tasks on a VM.

To improve the logs, `rsyslogs` + `graylogs` or `prometheus` + `grafana` should be applied for "decent" monitoring of the system logs.

---

## Helpers

To facilitate the stop/start of the service, [cron](./cron) can be run inside the application to perform some necessary tasks...

---
title: LDAP Self Service
description: How to use No Fuss Computings NodeRED LDAP Self Service Full-Stack Application.
date: 2023-08-14
template: project.html
about: https://gitlab.com/nofusscomputing/projects/nodered_ldap_self_service
---

This project is a NodeRED Full-Stack application for LDAP Self-Service. You can deploy this project by cloning the repo and adding to your NodeRED instance, or you can pull [our docker image](https://hub.docker.com/r/nofusscomputing/ldap-selfservice) that is already setup for immediate spin-up. The latter only requires that you add your credential encryption key and the credentials for LDAP, GLPI and your OAuth2 provider.


## Features

Currently this project is a work-in-progress. Whilst it can be used, some features are still in the planning stage.

Self Service Features:

- Edit personal details _(planned)_

- Edit Self-Service password reset questions _(planned)_

- Change password

- Reset password

General Features:

- Oauth2 Authentication

- Token Authentication

- GLPI form to ticket flow

- Cron Jobs:

    - Remove expired sessions


## Usage

There are two ways to use this NodeRed flow:

1. Clone to the data directory of your NodeRED insance

1. Use our pre-built docker image


### Docker Image

!!! info
    The docker image is available via `docker pull nofusscomputing/ldap-selfservice` available tags are detailed below


Available tags for the docker image is as follows:

- `dev` The current working head of the repositories `development` branch.

- `{\d}.{\d}.{\d}rc{\d}` The tag on the repositories `development` branch.

- `{\d}.{\d}.{\d}` The tag on the repositories `master` branch. _considered stable_

- `latest` The current working head of the repositories `master` branch. _considered stable_


[This docker image](https://hub.docker.com/r/nofusscomputing/ldap-selfservice) is designed to be behind a reverse-proxy. The proxy will be the service that provides ingress logging and `HTTPS` termination. NodeRED serves the the Self-Service site on `HTTP/80` at the `/` path with `/admin` path available for administering the flows. If when starting the docker container you specify an environmental variable of `NODE_RED_CREDENTIAL_SECRET` it will be used by NodeRED to decrypt your `flows_cred.json` file.

Data for the container is stored in two volumes `/data` and `/usr/src/node-red`. The repo does contain a `flows_cred.json` file, however this is our credential file. It's recommended that you log into the flows admin and set the credentials to your desired values. Export it and as part of the deployment process, mount a read-only copy of your `flows_cred.json` file to path `/data/flows_cred.json` within the container.

!!! danger "Security"
    Path `/admin` should not be made publically available, as access to this path grants full access to the backend as well as access to passwords and secrets from your `flows_cred.json` file.


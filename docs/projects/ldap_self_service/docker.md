---
title: LDAP Self Service Docker Image
description: How to use No Fuss Computings NodeRED LDAP Self Service Docker Image.
date: 2023-08-15
template: project.html
about: https://gitlab.com/nofusscomputing/projects/nodered_ldap_self_service
---

[This docker image](https://hub.docker.com/r/nofusscomputing/ldap-selfservice) is designed to be behind a reverse-proxy. The proxy will be the service that provides ingress logging and `HTTPS` termination. NodeRED serves the the Self-Service site on `HTTP/80` at the `/` path with `/admin` path available for administering the flows. If when starting the docker container you specify an environmental variable of `NODE_RED_CREDENTIAL_SECRET` it will be used by NodeRED to decrypt your `flows_cred.json` file.

Data for the container is stored in two volumes `/data` and `/usr/src/node-red`. The repo does contain a `flows_cred.json` file, however this is our credential file. It's recommended that you log into the flows admin and set the credentials to your desired values. Export it and as part of the deployment process, mount a read-only copy of your `flows_cred.json` file to path `/data/flows_cred.json` within the container.

!!! danger "Security"
    Path `/admin` should not be made publically available, as access to this path grants full access to the backend as well as access to passwords and secrets from your `flows_cred.json` file.


## Docker Hub

!!! info
    The docker image is available via `docker pull nofusscomputing/ldap-selfservice` available tags are detailed below

Available tags for the docker image is as follows:

- `dev` The current working head of the repositories `development` branch.

- `{\d}.{\d}.{\d}rc{\d}` The tag on the repositories `development` branch.

- `{\d}.{\d}.{\d}` The tag on the repositories `master` branch. _considered stable_

- `latest` The current working head of the repositories `master` branch. _considered stable_


## Flow Credentials

You can edit these from within the flow administration or use the included scripts and manually edit the `json` file. Within the container these scripts are stored in `/bin` as such can be called from any path. To decrypt `flows_cred,json` use `decrypt-flows-cred.sh /data` (you will be prompted for the decryption password) and this will output a file called `flows_cred.json.tmp` containing the decrypted `flows_cred.json`. to encrypt the temp `flows_cred.json.tmp` back into `flows_cred.json` use command `encrypt-flows-cred.sh /data`, (you will be prompted for the encryption password)

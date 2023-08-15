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

- scripts to (en/de)crypt the `flows_cred.json`


## Usage

There are two ways to use this NodeRed flow:

1. Clone to the data directory of your NodeRED insance

1. [Use our pre-built docker image](docker.md)

!!! danger "Security"
    if you choose your own NodeRED instance to deploy LDAP Self-Service, Care must be taken to ensure that the path the flows admin is on not be publically available, as access to this path grants full access to the backend as well as access to passwords and secrets from your `flows_cred.json` file.


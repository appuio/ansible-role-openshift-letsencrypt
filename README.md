OpenShift Let's Encrypt role
============================

This Ansible role configures Let's Encrypt integration on OpenShift.
Work in progress: curently only configures the HAProxy frontend.

Requirements
------------

One of:

* OpenShift Enterprise 3.2
* OpenShift Container Platform 3.3 or later
* OpenShift Origin M5 1.3 or later.

OpenShift routers reachable from internet.

Role Variables
--------------

| Name                       | Default value                                     | Description                                                                           |
|----------------------------|---------------------------------------------------|---------------------------------------------------------------------------------------|
| routers                    | None (Required)                                   | List of router DeploymentConfigs to configure                                         |
| letsencrypt_frontend_host  | None (Required)                                   | Hostname of Let's Encrypt frontend                                                    |
| letsencrypt_challenge_host | None (Required)                                   | Name of Let's Encrypt challenge host                                                  |
| master_public_api_url      | *openshift_master_public_api_url*                 | Public URL of OpenShift master, used for OAuth                                        |
| deployment_type            | *openshift_deployment_type*, openshift-enterprise | OpenShift deployment type (`openshift-enterprise` or `origin`), determines base image |
| src                        | https://github.com/appuio/letsencrypt.git         | Source repository of the Let's Encrypt integration                                    |
| version                    | master                                            | Version of the integration to build, i.e. Git ref of repo above                       |
| proxy_memory_limit         | 96Mi                                              | Memory limit for OAuth proxy                                                          |

Dependencies
------------

* <https://github.com/appuio/ansible-role-openshift-haproxy>

Example Usage
-------------

`playbook.yml`:

    roles:
    - role: ansible-role-openshift-letsencrypt
      routers:
      - ha-router-ex1
      letsencrypt_frontend_host: letsencrypt.example.com
      letsencrypt_challenge_host: letsencrypt-challenge.cloudapps.example.com

License
-------

Apache License Version 2.0

Author Information
------------------

APPUiO Team <info@appuio.ch>

OpenShift Let's Encrypt role
============================

This Ansible role configures Let's Encrypt integration on OpenShift.
Work in progress: curently only configures the HAProxy frontend.

Requirements
------------

One of:

* OpenShift Container Platform 3.4 or later
* OpenShift Origin M5 1.4 or later.

OpenShift routers reachable from internet.

Role Variables
--------------

| Name     | Default value    | Description                                    |
|----------|------------------|------------------------------------------------|
| routers  | None (Required)  | List of router DeploymentConfigs to configure  |

Dependencies
------------

* <https://github.com/appuio/ansible-role-openshift-haproxy>

Example Usage
-------------

`playbook.yml`:

    roles:
    - role: ../ansible-role-openshift-letsencrypt
      routers:
      - ha-router-ex1

License
-------

Apache License Version 2.0

Author Information
------------------

APPUiO Team <info@appuio.ch>

# ivansible.cert_copy

Sometimes development requires a production SSL certificate but deploying
letsencrypt [master](https://github.com/ivansible/cert-master)
or [replica](https://github.com/ivansible/cert-replica) role
is not an option.

This role manually copies letsencrypt certificates from certbot master host
to a development environment. Automatic updates are not enabled. However,
the environment fully mimics directory and update handler structure of master.
You still can manually trigger all post-update handler scripts by invoking
`/usr/local/sbin/certbot-update.sh`.

Certbot creates certificates and private keys with permissions 0644.
It rather prevents world access on the directory level.
Some software e.g. Postgresql server requires that private keys are not world-readable.
This role takes care of asigning appropriate group to private keys
and sets their mode to 0640. This is done during certificate deployment.


## Requirements

None


## Variables

Available variables are listed below, along with default values.

    certbot_master_host: None
When defined, this must be inventory hostname of the master host.
The parameter must be configured in the ansible inventory or on command
line for all role hosts, there is no default.

    certbot_group: ssl-cert
Members of this unix group will have read access to certificates.
This group should be the same as on the master host.


## Tags

- `cert_copy_install` -- install certbot and create manual update script
- `cert_copy_download` -- archive certbot certificates from master
                          (this step is performed once on every slave)
- `cert_copy_upload` -- upload archived certificates to slaves
- `cert_copy_permissions` -- fix group permissions of certificate files
- `cert_copy_all` -- all tasks


## Dependencies

None


## Example Playbook

    - hosts: development-boxes
      roles:
         - role: ivansible.cert_copy
           certbot_master_host: zeus


## License

MIT

## Author Information

Created in 2018-2020 by [IvanSible](https://github.com/ivansible)

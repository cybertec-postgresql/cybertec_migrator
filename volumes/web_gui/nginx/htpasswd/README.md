# Basic Authentication

To enable HTTP Basic Auth, create a new file `.htpasswd`:

```shell
touch .htpasswd
```

To add a new user, start by adding a username (replace the example with your own username):
```shell
sh -c "echo -n 'john-doe:' >> ./.htpasswd"
```

Finish the process by generating a password:
```shell
sh -c "openssl passwd -apr1 >> ./.htpasswd"
```

Restart the migrator for the new users to come into effect:
```shell
# Within the repository root
./migrator up
```

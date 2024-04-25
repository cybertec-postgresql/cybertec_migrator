# Oracle Wallet Support

To use Wallet Encrypted Oracle Databases you have to provide the following files:
- sqlnet.ora
- tnsnames.ora
- cwallet.sso
- ewallet.p12

To do this we added a third Volume `core-config`, mounted into `/volumes`


These files must be stored in the `core` container in the directory `/volumes`
```
volumes
├── core
│   └── config
│       └── oracle
│           ├── network
│           │   └── admin
│           │       ├── sqlnet.ora
│           │       └── tnsnames.ora
│           └── wallet
│               ├── README
│               ├── cwallet.sso
│               ├── cwallet.sso.lck
│               ├── ewallet.p12
│               └── ewallet.p12.lck
```

The easiest way to copy the files is ` oc rsync  --container  core /myPath/migrator/volumes/core/config/ <podname>:/volumes/core/config `

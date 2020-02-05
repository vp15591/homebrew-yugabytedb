<img src="https://github.com/yugabyte/yugabyte-db/raw/master/architecture/images/ybDB_horizontal.jpg" width="256"/> <img src="https://brew.sh/assets/img/homebrew-256x256.png" height="72">

# The Yugabyte DB Homebrew Tap

This is a custom [Homebrew](https://brew.sh) tap for official Yugabyte DB.

## Setup

You can add the custom tap in a macOS terminal session using:

```
$ brew tap yugabyte/yugabytedb
```

## Installing Formulae

Once the tap has been added locally, you can install individual software packages with:

```
$ brew install <formula>
```

For example:

 * Install the latest available production release of YugabyteDB. This will currently install YUgabyte 2.0.11.0:
 ```
 $ brew install yugabytedb
 ```

 * Install YugabyteDB version 2.0.10.0 . This will install Yugabyte 2.0.10.0:
 ```
 $ brew install yugabytedb@2.0.10.0
 ```

 * Install the latest avalable Yugabyte CLI tools :
 ```
 $ brew install yugabytedb-client
 ```

 * Install Yugabyte CLI tools version 2.0.10.0 :
 ```
 $ brew install yugabytedb-client@2.0.10.0
 ```

## Default Paths for the Yugabyte Formula

In addition to installing the Yugabyte server and tool binaries, the `yugabytedb` formula creates:

 * log directory path: `/usr/local/var/log/yugabyte`
 * configuration file: `/usr/local/etc/yugabyte.conf`
 * data directory path: `/usr/local/var/yugabyte_data`

## Starting the Yugabyte Server

### Run `yugabytedb` as a service

To have start `yugabytedb` immediately and also restart at login, use:

```
$ brew services start yugabytedb
```
If you manage `yugabyted` as a service it will use the default paths listed above. To stop the server instance use:

```
$ brew services stop yugabytedb
```

### Start `yugabytedb` manually

If you want yo run Yugayte manually then, you can run:

```
$ yugabyted start --config /usr/local/etc/yugabyte.conf
```
Note: if you do not include the `--config` option with a path to a configuration file, the Yugabyte server will start with the default config.

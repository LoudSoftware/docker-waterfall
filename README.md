# Not supported/maintained anymore since @itzg made a more elaborate version [here](https://github.com/itzg/docker-bungeecord)

This is a docker image of [Waterfall](https://github.com/PaperMC/Waterfall) a drop-in replacement for [BungeeCord](https://github.com/SpigotMC/BungeeCord) and is intended to be used as a frontend of a cluster of [itzg/minecraft-server](https://hub.docker.com/r/itzg/minecraft-server/) conatiners.

## Using with itzg/minecraft-server image

When using with the server image [itzg/minecraft-server](https://hub.docker.com/r/itzg/minecraft-server/)
you can disable online mode, which is required by bungeecord, by setting `ONLINE_MODE=FALSE`, such as

```bash
docker run ... -e ONLINE_MODE=FALSE itzg/minecraft-server
```

[Here](docs/docker-compose.yml) is an example Docker Compose file.

## Environment Settings

* **WATERFALL_JOB_ID**=lastSuccessfulBuild

  The Jenkins job ID of the artifact to download and run and is used when
  deriving the default value of `WATERFALL_JAR_URL`

* **WATERFALL_BASE_URL**=https://papermc.io/ci/job/Waterfall

  Used to derive the default value of `WATERFALL_JAR_URL`

* **WATERFALL_JAR_URL**=${WATERFALL_BASE_URL}/${WATERFALL_JOB_ID}/artifact/Waterfall-Proxy/bootstrap/target/Waterfall.jar

  If set, can specify a custom, fully qualified URL of the Waterfall.jar

* **MEMORY**=512m

  The Java memory heap size to specify to the JVM.

* **UID**=1000

  Default is 1000, can be set to whatever you need.

* **GID**=1000

  Default is 1000, can be set to whatever you need.

* **INIT_MEMORY**=${MEMORY}

  Can be set to use a different initial heap size.

* **MAX_MEMORY**=${MEMORY}

  Can be set to use a different max heap size.

* **JVM_OPTS**

  Additional -X options to pass to the JVM.

## Volumes

* **/server**

  The working directory where Waterfall is started. This is the directory
  where its `config.yml` will be loaded.
  
* **/plugins**

  Plugins will be copied across from this directory before the server is started.

* **/config**
  
  The `/config/config.yml` file in this volume will be copied accross on startup if it is newer than the config in `/server/config.yml`.

## Ports

* **25577**

  The listening port of Waterfall, which you will typically want to port map
  to the standard Minecraft server port of 25565 using:

  ```
  -p 25565:25577
  ```

## Waterfall Configuration

[Waterfall Configuration Guide](https://www.spigotmc.org/wiki/Bungeecord-configuration-guide/)

## Scenarios

### Running non-root

This image may be run as a non-root user but does require an attached `/server`
volume that is writable by that uid, such as:

    docker run ... -u $uid -v $(pwd)/data:/server loudsoftware/docker-waterfall

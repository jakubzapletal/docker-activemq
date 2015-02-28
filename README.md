# ActiveMQ dockerfile

This image contains a default configuration of ActiveMQ based on [jakubzapletal/ubuntu:14.04](https://github.com/jakubzapletal/docker-ubuntu/tree/14.04).

## Using the Docker Hub
 
This image is published under [Jakub Zapletal's repository on the Docker Hub](https://hub.docker.com/u/jakubzapletal/) and all you need as a prerequisite is having Docker installed on your machine.
The container exposes the following ports:

- `61612`: Stomp
- `61613`: Stomp over NIO
- `61616`: Broker URI
- `8161`: Web Console

There is the prepared volume `/data` for saving data into a local machine.

To start a container with this image you just need to run the following command:

```bash
docker run -d -p 61612:61612 -p 61613:61613 -p 61616:61616 -p 8161:8161 -v <LOCAL_PATH>:/data --name activemq jakubzapletal/activemq
```

If you already have services running on your host that are using any of these ports, you may wish to map the container
ports to whatever you want by changing left side number in the `-p` parameters. Find more details about mapping ports
in the [Docker documentation](http://docs.docker.com/userguide/dockerlinks/).

## Building the image yourself

The Dockerfile and supporting configuration files are available in the Github repository. This comes specially handy if you want to change any configuration or simply if you want to know how the image was built.

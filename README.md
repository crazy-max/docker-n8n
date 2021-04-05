<p align="center"><a href="https://github.com/crazy-max/docker-n8n" target="_blank"><img height="128" src=".github/docker-n8n.jpg"></a></p>

<p align="center">
  <a href="https://hub.docker.com/r/crazymax/n8n/tags?page=1&ordering=last_updated"><img src="https://img.shields.io/github/v/tag/crazy-max/docker-n8n?label=version&style=flat-square" alt="Latest Version"></a>
  <a href="https://github.com/crazy-max/docker-n8n/actions?workflow=build"><img src="https://img.shields.io/github/workflow/status/crazy-max/docker-n8n/build?label=build&logo=github&style=flat-square" alt="Build Status"></a>
  <a href="https://hub.docker.com/r/crazymax/n8n/"><img src="https://img.shields.io/docker/stars/crazymax/n8n.svg?style=flat-square&logo=docker" alt="Docker Stars"></a>
  <a href="https://hub.docker.com/r/crazymax/n8n/"><img src="https://img.shields.io/docker/pulls/crazymax/n8n.svg?style=flat-square&logo=docker" alt="Docker Pulls"></a>
  <br /><a href="https://github.com/sponsors/crazy-max"><img src="https://img.shields.io/badge/sponsor-crazy--max-181717.svg?logo=github&style=flat-square" alt="Become a sponsor"></a>
  <a href="https://www.paypal.me/crazyws"><img src="https://img.shields.io/badge/donate-paypal-00457c.svg?logo=paypal&style=flat-square" alt="Donate Paypal"></a>
</p>

## About

[n8n](https://github.com/n8n-io/n8n) Docker image based on Alpine Linux.<br />
If you are interested, [check out](https://hub.docker.com/r/crazymax/) my other Docker images!

💡 Want to be notified of new releases? Check out 🔔 [Diun (Docker Image Update Notifier)](https://github.com/crazy-max/diun) project!

___

* [Build locally](#build-locally)
* [Image](#image)
* [Environment variables](#environment-variables)
* [Ports](#ports)
* [Usage](#usage)
* [Upgrade](#upgrade)
* [How can I help?](#how-can-i-help)
* [License](#license)

## Build locally

```shell
git clone https://github.com/crazy-max/docker-n8n.git
cd docker-n8n

# Build image and output to docker (default)
docker buildx bake

# Build multi-platform image
docker buildx bake image-all
```

## Image

| Registry                                                                                         | Image                           |
|--------------------------------------------------------------------------------------------------|---------------------------------|
| [Docker Hub](https://hub.docker.com/r/crazymax/n8n/)                                             | `crazymax/n8n`                  |
| [GitHub Container Registry](https://github.com/users/crazy-max/packages/container/package/n8n)   | `ghcr.io/crazy-max/n8n`         |

Following platforms for this image are available:

```
$ docker run --rm mplatform/mquery crazymax/n8n:latest
Image: crazymax/n8n:latest
 * Manifest List: Yes
 * Supported platforms:
   - linux/amd64
   - linux/arm/v7
   - linux/arm64
```

## Environment variables

* `TZ`: The timezone assigned to the container (default `UTC`)

To configure the application, just add the environment variables as shown in the official
[Configuration page](https://docs.n8n.io/reference/configuration.html) of n8n.

## Ports

* `5678`: HTTP port

## Usage

### Docker Compose

Docker compose is the recommended way to run this image. You can use the following
[docker compose template](examples/compose/docker-compose.yml), then run the container:

```bash
docker-compose up -d
docker-compose logs -f
```

### Command line

You can also use the following minimal command:

```shell
docker run -d -p 5678:5678 --name n8n \
  -e "TZ=Europe/Paris" \
  -e "GENERIC_TIMEZONE=Europe/Paris" \
  -v $(pwd)/data:/data \
  crazymax/n8n:latest
```

## Upgrade

To upgrade, pull the newer image and launch the container :

```bash
docker-compose pull
docker-compose up -d
```

## How can I help?

All kinds of contributions are welcome :raised_hands:! The most basic way to show your support is to star :star2:
the project, or to raise issues :speech_balloon: You can also support this project by
[**becoming a sponsor on GitHub**](https://github.com/sponsors/crazy-max) :clap: or by making
a [Paypal donation](https://www.paypal.me/crazyws) to ensure this journey continues indefinitely! :rocket:

Thanks again for your support, it is much appreciated! :pray:

## License

MIT. See `LICENSE` for more details.

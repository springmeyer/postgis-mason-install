Install postgres/postgis locally with mason

[![Build Status](https://travis-ci.org/springmeyer/postgis-mason-install.svg?branch=master)](https://travis-ci.org/springmeyer/postgis-mason-install)

This is a sample repo designed to be used as a starting point for
how to easily install postgis via mason.

## Supports

 - CI systems like travis/circle ci
 - Docker (no sudo required)
 - OS X
 - Linux

## Usage

First install mason: https://github.com/mapbox/mason/#installation

```sh
mkdir ./mason
curl -sSfL https://github.com/mapbox/mason/archive/v0.8.0.tar.gz | tar --gunzip --extract --strip-components=1 --exclude="*md" --exclude="test*" --directory=./mason
```

Then install postgis with mason:

```bash
./mason/mason install postgis 2.3.2
```

For fully automated advanced setup you can run the sample scripts:

```bash
./setup.sh && ./install.sh
```

You should understand what these scripts are doing, and plan to customize them. Read the code at:

   - [setup.sh](./setup.sh)
   - [install.sh](./install.sh)

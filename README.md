Install postgres/postgis/gdal locally with mason

[![Build Status](https://travis-ci.org/springmeyer/postgis-mason-install.svg?branch=master)](https://travis-ci.org/springmeyer/postgis-mason-install)

This is a sample repo designed to be used as a starting point for how to easily install postgis via mason.

## Supports

 - CI systems like travis/circle ci
 - Docker (no sudo required)
 - OS X
 - Linux

A bonus is that this setup:

- Installs everything locally. There are not global interactions or dependencies. Everything is isolated to the folder you install into.
- This setup can be used to run multiple postgres servers on one machine with unique ports. Not that you really want to do that in production, but it can be useful for testing and "sandboxing" postgres per project.

## Usage

Overall the flow is:

 - Install Mason locally
 - Install postgis and gdal locally with mason
 - Create a `mason-config.env` to source key settings for your local database setup
 - Initialize the database
 - Start postgres
 - Load extensions
 - All done: postgres/postgis is ready to use

Sample scripts in this repo can walk you through the exact steps and are a starting point for scripting this in an automated way. See the  `test-all.sh` as a starting point.

You should understand what these scripts are doing, and plan to customize them.

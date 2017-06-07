Install postgres/postgis/gdal locally with mason

[![Build Status](https://travis-ci.org/springmeyer/postgis-mason-install.svg?branch=master)](https://travis-ci.org/springmeyer/postgis-mason-install)

This is a sample repo designed to be used as a starting point for how to easily install postgis via mason.

## Supports

 - CI systems like travis/circle ci
 - Docker (no sudo required)
 - OS X
 - Linux

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

Install postgres/postgis locally with mason

This is a sample repo designed to be used as a starting point for
how to easily install postgis into your github repo. Can be used for
both continuous integrations (installs on travis/circle.ci) and for
local or production development.

## Depends

 - mason loaded as git submodule:
   - `git submodule add https://github.com/mapbox/mason.git mason`

## Usage

This is a way to install and run postgis from binaries that is exactly the same on mac and linux.

```bash
export MASON_DIR=mason
./mason/mason install postgis 2.2.2
./local-install.sh
```
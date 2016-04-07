Install postgres/postgis locally with mason

This is a sample repo designed to be used as a starting point for
how to easily install postgis into your github repo. Can be used for
both continuous integrations (installs on travis/circle.ci) and for
local or production development.

This is a way to install and run postgis from binaries that is exactly the same on mac and linux.

## Usage

It is as simple as installing mason:


```bash
git clone https://github.com/mapbox/mason.git mason
export MASON_DIR=mason
```

Then installing postgis with mason:

```bash
./mason/mason install postgis 2.2.2
```

For advanced details on how to fully setup and use this postgis install see:

   - [setup.sh](./setup.sh)
   - [install.sh](./install.sh)

Install postgres/postgis locally with mason

This is a sample repo designed to be used as a starting point for
how to easily install postgis. Can be used for both continuous integrations
(installs on travis/circle.ci) and for local or production development.

## Usage

First install mason:

```bash
git clone https://github.com/mapbox/mason.git mason
export MASON_DIR=mason
```

Then install postgis with mason:

```bash
./mason/mason install postgis 2.2.2
```

For fully automated advanced setup you can run the sample scripts:

```bash
./setup.sh && ./install.sh
```

You should understand what these scripts are doing, and plan to customize them. Read the code at:

   - [setup.sh](./setup.sh)
   - [install.sh](./install.sh)

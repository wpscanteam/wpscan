<p align="center">
  <a href="https://wpscan.com/">
    <img src="https://raw.githubusercontent.com/wpscanteam/wpscan/gh-pages/images/wpscan_logo.png" alt="WPScan logo">
  </a>
</p>

<h3 align="center">WPScan</h3>

<p align="center">
  WordPress Security Scanner
  <br>
  <br>
  <a href="https://wpscan.com/" title="homepage" target="_blank">WPScan WordPress Vulnerability Database</a> - <a href="https://wordpress.org/plugins/wpscan/" title="wordpress security plugin" target="_blank">WordPress Security Plugin</a>
</p>

<p align="center">
  <a href="https://badge.fury.io/rb/wpscan" target="_blank"><img src="https://badge.fury.io/rb/wpscan.svg"></a>
  <a href="https://hub.docker.com/r/wpscanteam/wpscan/" target="_blank"><img src="https://img.shields.io/docker/pulls/wpscanteam/wpscan.svg"></a>
  <a href="https://github.com/wpscanteam/wpscan/actions?query=workflow%3ABuild" target="_blank"><img src="https://github.com/wpscanteam/wpscan/workflows/Build/badge.svg"></a>
  <a href="https://codeclimate.com/github/wpscanteam/wpscan" target="_blank"><img src="https://codeclimate.com/github/wpscanteam/wpscan/badges/gpa.svg"></a>
</p>

# INSTALL

## Prerequisites

- (Optional but highly recommended: [rbenv](https://github.com/rbenv/rbenv))
- Ruby >= 3.3 - Recommended: latest stable
- Curl >= 7.72 - Recommended: latest stable
  - The 7.29 has a segfault
  - The < 7.72 could result in `Stream error in the HTTP/2 framing layer` in some cases
- RubyGems - Recommended: latest stable
- Nokogiri might require packages to be installed via your package manager depending on your OS, see https://nokogiri.org/tutorials/installing_nokogiri.html

### In a Pentesting distribution

When using a pentesting distribution (such as Kali Linux), it is recommended to install/update wpscan via the package manager if available.

### In macOSX via Homebrew

```shell
brew install wpscanteam/tap/wpscan
```

### From RubyGems

```shell
gem install wpscan
```

On MacOSX, if a ```Gem::FilePermissionError``` is raised due to Apple's System Integrity Protection (SIP), either install RVM and install wpscan again, or run ```sudo gem install -n /usr/local/bin wpscan``` (see [#1286](https://github.com/wpscanteam/wpscan/issues/1286))

# Updating

You can update the local database by using ```wpscan --update```

Updating WPScan itself is either done via ```gem update wpscan``` or the packages manager (this is quite important for distributions such as in Kali Linux: ```apt-get update && apt-get upgrade```) depending on how WPScan was (pre)installed

# Docker

Pull the repo with ```docker pull wpscanteam/wpscan```

Enumerating usernames

```shell
docker run -it --rm -v wpscan-db:/wpscan/.cache/wpscan/db wpscanteam/wpscan --url https://target.tld/ --enumerate u
```

Enumerating a range of usernames

```shell
docker run -it --rm -v wpscan-db:/wpscan/.cache/wpscan/db wpscanteam/wpscan --url https://target.tld/ --enumerate u1-100
```

** replace u1-100 with a range of your choice.

## Persisting the local database

The image ships with a copy of the local database baked in at build time. Because the example commands above use `--rm`, any database update performed during a run is discarded when the container exits, so the next run starts again from the (potentially stale) baked-in copy.

Mounting a named volume at `/wpscan/.cache/wpscan/db` (the `wpscan` user's cache directory inside the container) keeps the database across runs, so `wpscan --update` only re-downloads files whose checksums actually changed and the 5-day staleness prompt behaves as it would for a local install:

```shell
docker run -it --rm -v wpscan-db:/wpscan/.cache/wpscan/db wpscanteam/wpscan --update
```

The named volume is created automatically on first use if it doesn't already exist.

# Usage

Full user documentation can be found here; https://github.com/wpscanteam/wpscan/wiki/WPScan-User-Documentation

```wpscan --url blog.tld``` This will scan the blog using default options with a good compromise between speed and accuracy. For example, the plugins will be checked passively but their version with a mixed detection mode (passively + aggressively). Potential config backup files will also be checked, along with other interesting findings.

If a more stealthy approach is required, then ```wpscan --stealthy --url blog.tld``` can be used.
As a result, when using the ```--enumerate``` option, don't forget to set the ```--plugins-detection``` accordingly, as its default is 'passive'.

For more options, open a terminal and type ```wpscan --help``` (if you built wpscan from the source, you should type the command outside of the git repo)

## Database Location

The database location follows the [XDG Base Directory Specification](https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html):

- **New installations**: `~/.cache/wpscan/db` (or `$XDG_CACHE_HOME/wpscan/db` if set)
- **Existing installations**: `~/.wpscan/db` (legacy path, maintained for backward compatibility)

Runtime files such as the default HTTP cache and cookie jar are stored under `$TMPDIR/wpscan` when
`$TMPDIR` is set. Otherwise they use the same per-user XDG cache directory, for example
`~/.cache/wpscan/cache` and `~/.cache/wpscan/cookie_jar.txt`. These defaults can be overridden
with `--cache-dir` and `--cookie-jar`.

To migrate an existing installation to the XDG path:

```shell
mv ~/.wpscan ~/.cache/wpscan
```

## Optional: WordPress Vulnerability Database API

The WPScan CLI tool uses the [WordPress Vulnerability Database API](https://wpscan.com/api) to retrieve WordPress vulnerability data in real-time. For WPScan to retrieve the vulnerability data an API token must be supplied via the `--api-token` option, or via a configuration file, as discussed below. An API token can be obtained by registering an account on [WPScan.com](https://wpscan.com/register).

Up to **25** API requests per day are given free of charge, that should be suitable to scan most WordPress websites at least once per day. When the daily 25 API requests are exhausted, WPScan will continue to work as normal but without any vulnerability data.

### How many API requests do you need?

- Our WordPress scanner makes one API request for the WordPress version, one request per installed plugin, and one request per the installed theme.
- On average, a WordPress website has 22 installed plugins.

## Load CLI options from file/s

WPScan can load all options (including the `--url`) from configuration files, the following locations are checked (order: first to last):

- `~/.wpscan/scan.json`
- `~/.wpscan/scan.yml`
- `pwd/.wpscan/scan.json`
- `pwd/.wpscan/scan.yml`

If those files exist, options from the `cli_options` key will be loaded and overridden if found twice.

e.g:

`~/.wpscan/scan.yml`:

```yml
cli_options:
  proxy: 'http://127.0.0.1:8080'
  verbose: true
```

`pwd/.wpscan/scan.yml`:

```yml
cli_options:
  proxy: 'socks5://127.0.0.1:9090'
  url: 'http://target.tld'
```

Running ```wpscan``` in the current directory (pwd) is the same as ```wpscan -v --proxy socks5://127.0.0.1:9090 --url http://target.tld```

Other command line options can be added by using snake case convention. e.g:
```yml
cli_options:
  user_agent: "Testing UA"
  max_threads: 1
  headers: "Custom-Header: aaaa; Another Header: bbb"
```

## Save API Token in a file

The feature mentioned above is useful to keep the API Token in a config file and not have to supply it via the CLI each time. To do so, create the ~/.wpscan/scan.yml file containing the below:

```yml
cli_options:
  api_token: 'YOUR_API_TOKEN'
```

## Load API Token From ENV (since v3.7.10)

The API Token will be automatically loaded from the ENV variable `WPSCAN_API_TOKEN` if present. If the `--api-token` CLI option is also provided, the value from the CLI will be used.


## Enumerating usernames

```shell
wpscan --url https://target.tld/ --enumerate u
```

Enumerating a range of usernames

```shell
wpscan --url https://target.tld/ --enumerate u1-100
```

** replace u1-100 with a range of your choice.

# LICENSE

## WPScan Public Source License

The WPScan software (henceforth referred to simply as "WPScan") is dual-licensed - Copyright 2011-2019 WPScan Team.

Cases that include the commercialization of WPScan require a commercial, non-free license. Otherwise, WPScan can be used without charge under the terms set out below.

### 1. Definitions

1.1 "License" means this document.

1.2 "Contributor" means each individual or legal entity that creates, contributes to the creation of, or owns WPScan.

1.3 "WPScan Team" means WPScan’s core developers.

### 2. Commercialization

Commercial use is one intended for commercial advantage or monetary compensation.

Example cases of commercialization are:

- Using WPScan to provide commercial managed/Software-as-a-Service services.
- Distributing WPScan as a commercial product or as part of one.
- Using WPScan as a value-added service/product.

Example cases that do not require a commercial license, and thus fall under the terms set out below, include (but are not limited to):

- Penetration testers (or penetration testing organizations) using WPScan as part of their assessment toolkit.
- Penetration Testing Linux Distributions including but not limited to Kali Linux, SamuraiWTF, BackBox Linux.
- Using WPScan to test your own systems.
- Any non-commercial use of WPScan.

If you need to purchase a commercial license or are unsure whether you need to purchase a commercial license contact us - contact@wpscan.com.

Free-use Terms and Conditions;

### 3. Redistribution

Redistribution is permitted under the following conditions:

- Unmodified License is provided with WPScan.
- Unmodified Copyright notices are provided with WPScan.
- Does not conflict with the commercialization clause.

### 4. Copying

Copying is permitted so long as it does not conflict with the Redistribution clause.

### 5. Modification

Modification is permitted so long as it does not conflict with the Redistribution clause.

### 6. Contributions

Any Contributions assume the Contributor grants the WPScan Team the unlimited, non-exclusive right to reuse, modify and relicense the Contributor's content.

### 7. Support, updates, and maintenance 

WPScan is provided under an AS-IS basis and without any support, updates, or maintenance. Support, updates and maintenance may be given according to the sole discretion of the WPScan Team.

### 8. Disclaimer of Warranty

WPScan is provided under this License on an “as is” basis, without warranty of any kind, either expressed, implied, or statutory, including, without limitation, warranties that the WPScan is free of defects, merchantable, fit for a particular purpose or non-infringing.

### 9. Limitation of Liability

To the extent permitted under Law, WPScan is provided under an AS-IS basis. The WPScan Team shall never, and without any limit, be liable for any damage, cost, expense or any other payment incurred as a result of WPScan's actions, failure, bugs, and/or any other interaction between WPScan and end-equipment, computers, other software or any 3rd party, end-equipment, computer or services.

### 10. Disclaimer

Running WPScan against websites without prior mutual consent may be illegal in your country. The WPScan Team accepts no liability and is not responsible for any misuse or damage caused by WPScan.

### 11. Trademark

The "wpscan" term is a registered trademark. This License does not grant the use of the "wpscan" trademark or the use of the WPScan logo.

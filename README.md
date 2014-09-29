shellshock-patch-osx
====================

This will download Apple's bash source, patch it, build it, and create a pkg file for you.

This applies the following patches:
* bash32-052 - CVE-2014-6271 (aka shellshock)
* bash32-053 - CVE-2014-7169 (aka aftershock)
* bash32-054 - CVE-2014-6277 (another bash bug)

# Pre-requisites
* XCode, along with the command line tools
* [The Luggage](https://github.com/unixorn/luggage)

# Usage
1. Clone this repository
2. cd into the repository
3. `make dmg`

It takes less than a minute to generate the dmg with a pkg inside on my MBP. If you just want the pkg file, do `make pkg`

# Caveats
* I've only used this on 10.9. I don't admin OS X for a living any more, so I don't have spare machines with stale OS versions to test on any more. That said, it isn't doing anything all that special and should work on any version of OS X that has `/usr/bin/pkgbuild` and XCode. If you need to use packagemaker, comment out line 17 in the Makefile, `USE_PKGBUILD=1`, 
* Build the binaries on the version of OS X you plan on installing them on. I know for certain that binaries baked on 10.9 won't work on 10.6, and assume they won't work on 10.7 or 10.8 either.

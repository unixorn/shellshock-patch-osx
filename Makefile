#
#   Copyright 2014 Joe Block <jpb@ApesSeekingKnowledge.net>
#
#   Licensed under the Apache License, Version 2.0 (the "License");
#   you may not use this file except in compliance with the License.
#   You may obtain a copy of the License at
#
#       http://www.apache.org/licenses/LICENSE-2.0
#
#   Unless required by applicable law or agreed to in writing, software
#   distributed under the License is distributed on an "AS IS" BASIS,
#   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#   See the License for the specific language governing permissions and
#   limitations under the License.
#

USE_PKGBUILD=1

include /usr/local/share/luggage/luggage.make

TITLE=shellshock_updater
REVERSE_DOMAIN=net.unixorn
PAYLOAD=bash sh pack-bin-bash pack-bin-sh
SOURCES=bash-92.tar.gz bash32-052

.PHONY: apply_patches
.PHONY: bake_bash
.PHONY: burst_tarball
.PHONY: shellshock_binaries
.PHONY: sources
.PHONY: zap

shellshock_binaries: bash sh

sources: bash_tarball bash_patch

bash_tarball: bash-92.tar.gz

bash-92.tar.gz:
	@curl -O https://opensource.apple.com/tarballs/bash/bash-92.tar.gz

bash_patch: bash32-052

bash32-052:
	@curl -O http://ftp.gnu.org/pub/gnu/bash/bash-3.2-patches/bash32-052

burst_tarball: ${SOURCES}
	@tar xvzf bash-92.tar.gz

apply_patches: burst_tarball
	cd bash-92/bash-3.2; patch -p0 < ../../bash32-052

bake_bash: burst_tarball apply_patches
	cd bash-92; time xcodebuild

bash: bake_bash
	cp bash-92/build/Release/bash .

sh: bake_bash
	cp bash-92/build/Release/sh .

zap:
	@rm -fr bash-92 bash sh
	#@rm -fr ${SOURCES} bash-92

l_bin: l_root
	@sudo mkdir -p ${WORK_D}/bin
	@sudo chown -R root:wheel ${WORK_D}/bin
	@sudo chmod -R 755 ${WORK_D}/bin

pack-bin-%: % l_bin
	@sudo ${INSTALL} -m 555 -g wheel -o root "${<}" ${WORK_D}/bin


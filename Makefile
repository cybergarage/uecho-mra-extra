# Copyright (C) 2022 Satoshi Konno All rights reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

SHELL := bash

MRA_VER=MRA_en_V1.1.1

MRA_ZIP=${MRA_VER}.zip
MRA_URL=https://echonet.jp/wp/wp-content/uploads/pdf/General/Standard/MRA/${MRA_ZIP}
MRA_DIR=${MRA_VER}

MRA_EXT_DIR=extra
MRA_EXT_ZIP=${MRA_VER}-${MRA_EXT_DIR}.zip

MRA_DEF_FILE=mraData/definitions/definitions.json
MRA_DEV_DIR=mraData/devices
MRA_DEF_MERGE_FILE=definitions-extra.json

.PHONY: clean

all: update

clean:
	-@rm ${MRA_ZIP}
	-@rm ${MRA_EXT_ZIP}
	-@rm -rf ${MRA_DIR}

update: clean
	wget -q -O ${MRA_ZIP} ${MRA_URL}
	unzip ${MRA_ZIP}
	rm  ${MRA_ZIP}
	find ${MRA_EXT_DIR}/${MRA_DEV_DIR} -name "*.json" | xargs -Ifname -L 1 cp fname ${MRA_DIR}/mraData/devices
	jq -s '.[0] * .[1]' ${MRA_DIR}/${MRA_DEF_FILE} ${MRA_EXT_DIR}/${MRA_DEF_FILE} > ${MRA_DEF_MERGE_FILE}
	mv ${MRA_DEF_MERGE_FILE} ${MRA_DIR}/${MRA_DEF_FILE}
	zip -r ${MRA_EXT_ZIP} ${MRA_DIR}
	rm -rf ${MRA_DIR}
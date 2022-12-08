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
MRA_URL=https://echonet.jp/wp/wp-content/uploads/pdf/General/Standard/MRA/${MRA_ZIP}}
MRA_DIR=${MRA_en_V1}

.PHONY: update ${MRA_ZIP}

all: update

clean:
	@rm ${MRA_ZIP}
	@rm -rf ${MRA_DIR}

${MRA_ZIP}:
	@wget -q -O ${MRA_ZIP} ${MRA_URL}

update: ${MRA_ZIP} clean
	unzip ${MRA_ZIP}

.PHONY: all install deps release debug

all: release
install: install-release

RIME_BIN_DIR = library/rime/dist/bin
RIME_LIB_DIR = library/rime/dist/lib
DERIVED_DATA_PATH = build

RIME_LIBRARY_FILE_NAME = librime.1.dylib
# RIME_LIBRARY = dependency/rime/$(RIME_LIBRARY_FILE_NAME)

OPENCC_DATA_OUTPUT = library/rime/share/opencc/*.*

# 定位 install_name_tool 完整路径
INSTALL_NAME_TOOL = $(shell xcrun -find install_name_tool)
INSTALL_NAME_TOOL_ARGS = -add_rpath @loader_path/../Frameworks

copy-rime-binary:
	mkdir -p lib
	mkdir -p bin
	cp -L $(RIME_LIB_DIR)/$(RIME_LIBRARY_FILE_NAME) lib/
	cp -pR $(RIME_LIB_DIR)/rime-plugins lib/
	cp $(RIME_BIN_DIR)/rime_deployer bin/
	cp $(RIME_BIN_DIR)/rime_dict_manager bin/
	$(INSTALL_NAME_TOOL) $(INSTALL_NAME_TOOL_ARGS) bin/rime_deployer
	$(INSTALL_NAME_TOOL) $(INSTALL_NAME_TOOL_ARGS) bin/rime_dict_manager

copy-opencc-data:
	mkdir -p data/opencc
	cp $(OPENCC_DATA_OUTPUT) data/opencc/

copy-opencc-data:
	mkdir -p data/opencc
	cp $(OPENCC_DATA_OUTPUT) data/opencc/
	#cp $(PLUM_OPENCC_OUTPUT) data/opencc/ > /dev/null 2>&1 || true

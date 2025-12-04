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
	mkdir -p lib/
	mkdir -p bin/
	cp -L $(RIME_LIB_DIR)/$(RIME_LIBRARY_FILE_NAME) lib/
	cp -pR $(RIME_LIB_DIR)/rime-plugins lib/
	cp $(RIME_BIN_DIR)/rime_deployer bin/
	cp $(RIME_BIN_DIR)/rime_dict_manager bin/
	$(INSTALL_NAME_TOOL) $(INSTALL_NAME_TOOL_ARGS) bin/rime_deployer
	$(INSTALL_NAME_TOOL) $(INSTALL_NAME_TOOL_ARGS) bin/rime_dict_manager

copy-opencc-data:
	mkdir -p data/opencc
	cp $(OPENCC_DATA_OUTPUT) data/opencc/

#.PHONY: clean clean-deps
#
#clean:
#	rm -rf build > /dev/null 2>&1 || true
#	rm build.log > /dev/null 2>&1 || true
#	rm bin/* > /dev/null 2>&1 || true
#	rm lib/* > /dev/null 2>&1 || true
#	rm lib/rime-plugins/* > /dev/null 2>&1 || true
#	rm data/plum/* > /dev/null 2>&1 || true
#	rm data/opencc/* > /dev/null 2>&1 || true
#
#clean-package:
#	rm -rf package/*appcast.xml > /dev/null 2>&1 || true
#	rm -rf package/*.pkg > /dev/null 2>&1 || true
#	rm -rf package/sign_update > /dev/null 2>&1 || true
#
#clean-deps:
#	$(MAKE) -C plum clean
#	$(MAKE) -C librime clean
#	rm -rf librime/dist > /dev/null 2>&1 || true
#	$(MAKE) clean-sparkle

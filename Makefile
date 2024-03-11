.PHONY: all clean

TOPDIR = .
# software version information
VERSION = 1
PROJECT = mk_demo
SUBLEVEL = 4
YEAR = 2024
RELEASE_VERSION = $(PROJECT).$(YEAR).$(VERSION).$(SUBLEVEL)

BUILD_DIRS = $(TOPDIR)/source/module1\
			 $(TOPDIR)/source/module2\
			 $(TOPDIR)/source/module3\
			 $(TOPDIR)/source

all :
#   @shell(export TOPDIR=`pwd`)
	@echo "version information:" $(RELEASE_VERSION) $(BUILD_DIRS)
	@echo "building ..."
	@set -e;\
	for dir in $(BUILD_DIRS);\
	do\
		$(MAKE) -C $$dir;\
	done
	@echo ""
	@echo "\33[35m ~@^_^@~ \33[m"
	@echo ""
	@echo "Build completed"

clean :
	@echo "cleaning ..."
	for dir in $(BUILD_DIRS);\
	do\
		$(MAKE) -C $$dir clean;\
	done
	rm -rf $(RMS)
	@echo ""
	@echo "Clean completed"

version:
	@echo $(TOPDIR)
	@echo $(RELEASE_VERSION)
	@echo $(BUILD_DIRS)
	@echo $(RMS)
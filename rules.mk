# rules .mk

# Generic Makefile for C/C++ Program
# Author: Peter Zhu
# Description: # ------------
# This is an easily customizable makefile template. The purpose is to
# provide an instant building environment for C/C++ programs.
#
# It searches all the C/C++ source files in the specified directories,
# makes dependencies, compiles and links to form an executable.
#
# Besides its default ability to build C/C++ programs which use only
# standard C/C++ libraries, you can customize the Makefile to build
# those using other libraries. Once done, without any changes you can
# then build programs using the same or less libraries, even if source
# files are renamed, added or removed. Therefore, it is particularly
# convenient to use it to build codes for experimental or study use.
#
# GNU make is expected to use the Makefile. Other versions of makes
#

.PHONY : all clean

# Top directory Makefile
#TOPDIR = .

# The C program compiler
EXE_PATH ?= C:
DS_BINPATH ?= /NXP/S32DS.3.4/S32DS/build_tools
UNAME_A := $(shell uname -a)
ifneq ($(filter %Microsoft MINGW% MSYS% %Cygwin, $(UNAME_A)),)
	CPU_TOOLCHAIN_BINPATH ?= $(EXE_PATH)$(DS_BINPATH)/gcc_v10.2/gcc-10.2-arm64-linux/bin/aarch64-linux-gnu-
	CC := $(CPU_TOOLCHAIN_BINPATH)gcc.exe
	CPP := $(CPU_TOOLCHAIN_BINPATH)g++.exe
	LD := $(CPU_TOOLCHAIN_BINPATH)gcc.exe
	LDPP := $(CPU_TOOLCHAIN_BINPATH)g++.exe
	ASM := $(CPU_TOOLCHAIN_BINPATH)gcc.exe
	ASMPP := $(CPU_TOOLCHAIN_BINPATH)g++.exe
	AR := $(CPU_TOOLCHAIN_BINPATH)ar.exe
else
	CPU_TOOLCHAIN_BINPATH ?= $(CROSS_COMPLIER_PATH)
	CC := $(CPU_TOOLCHAIN_BINPATH)gcc
	CPP := $(CPU_TOOLCHAIN_BINPATH)g++		
	LD := $(CPU_TOOLCHAIN_BINPATH)gcc
	LDPP := $(CPU_TOOLCHAIN_BINPATH)g++
	ASM := $(CPU_TOOLCHAIN_BINPATH)gcc
	ASMPP := $(CPU_TOOLCHAIN_BINPATH)g++
	AR := $(CPU_TOOLCHAIN_BINPATH)ar
endif

#CC = gcc
MACRO = DEBUGALL
CFLAGS += -g -werror -D$(MACRO)
#AR = ar
ARFLAGES = crv

# default execute output directory
ifeq ($(DIR_EXES),)
DIR_EXES = $(TOPDIR)/build/out
endif

# default library creat directory
ifeq ($(DIR_LIBS),)
DIR_LIBS = $(TOPDIR)/build/libs
endif

# directory
DIRS = $(DIR_OBJS) $(DIR_DEPS) $(DIR_EXES) $(DIR_LIBS)

# include directory
ifneq ($(DIR_INCS),"")
DIR_INCS := $(strip $(DIR_INCS))
DIR_INCS := $(addprefix -I,$(DIR_INCS))
endif

# when build execute file
ifneq ($(EXES),)
EXES := $(addprefix $(DIR_EXES)/,$(EXES))
RMS += $(EXES)
DIR_LIBS := $(strip $(DIR_LIBS))
DIR_LIBS := $(addprefix -L,$(DIR_LIBS))
endif

# when build static libaray file
ifneq ($(LIBS),"")
LIBS := $(addprefix $(DIR_LIBS)/,$(LIBS))
RMS += $(LIBS)
endif

# default source code file directory
ifeq ($(DIR_SRCS),)
DIR_SRCS = .
endif

SRCS = $(wildcard $(DIR_SRCS)/*.c)
OBJS = $(patsubst %.c, %.o,$(notdir $(SRCS)))
OBJS := $(addprefix $(DIR_OBJS)/,$(OBJS))
RMS += $(OBJS) $(DIR_OBJS)

DEPS = $(patsubst %.c, %.dep,$(notdir $(SRCS)))
DEPS := $(addprefix $(DIR_DEPS)/,$(DEPS))
RMS += $(DEPS) $(DIR_DEPS)

ifneq ($(EXES),"")
all : $(EXES)
endif

ifneq ($(LIBS),"")
all : $(LIBS)
endif

ifneq ($(LINK_LIBS),"")
LINK_LIBS := $(strip $(LINK_LIBS))
LINK_LIBS := $(addprefix -l,$(LINK_LIBS))
endif

# include dependent files
ifneq ($(MAKECMDGOALS), clean)
-include $(DEPS)
endif

$(DIRS):
	mkdir -p $@

# creat execute file
$(EXES) : $(DIR_OBJS) $(OBJS) $(DIR_EXES)
	$(CC) $(DIR_INCS) $(CFLAGES) -o $@ $(OBJS) $(DIR_LIBS) $(LINK_LIBS)

# creat libaray file
$(LIBS) : $(DIR_LIBS) $(DIR_OBJS) $(OBJS)
# library type is static
ifeq ($(LIB_TYPE),static)
	$(AR) $(ARFLAGS) $@ $(OBJS)
endif

# library type is dynamic
ifeq ($(LIB_TYPE),dynamic)
	$(CC) -shared -o $@ $(OBJS)
endif

# creat object file
$(DIR_OBJS)/%.o : $(DIR_SRCS)/%.c
	@echo "source files:" $<
	@echo "object files:" $@
ifeq ($(LIB_TYPE),static)
	$(CC) $(DIR_INCS) $(CFLAGES) -o $@ -c $<
else
	$(CC) $(DIR_INCS) $(CFLAGES) -fPIC -o $@ -c $<
endif

# creat depandant file
$(DIR_DEPS)/%.dep : $(DIR_SRCS)/%.c $(DIR_DEPS)
	@echo "creating depend file ..." $@
	@set -e;\
	$(CC) $(DIR_INCS) -MM $< > $@.tmp;\
	sed 's,$*\.o[ :]*,$(DIR_OBJS)/\1.o $@ : ,g' < $@.tmp > $@
#	rm $@.tmp

clean:
	rm -rf $(RMS)
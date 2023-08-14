# Build directory
BUILD_DIR := build
# Project binary name
BIN   := $(BUILD_DIR)/c_minigame
RM    :=
MKDIR :=


SRCS := main.c
OBJS := $(SRCS:%.c=$(BUILD_DIR)/%.o)
INCS :=

CFLAGS := $(INCS) -std=c17 -Wall -Wextra -Wpedantic
CFLAGS += -Werror # Set all warnings to be treated as errors
CLIBS  :=

# Tell the program what OS we are in
UNAME_S :=

ifeq ($(OS), Windows_NT)
	# Append .exe to binary name
	BIN     := $(BIN:%=%.exe)
	CC      := gcc.exe
	RM      += rm.exe -f
	MKDIR   +=

	# NOTE: I don't think this is portable, please change this.
	CLIBS += -L"D:/Program Files (x86)/Dev-Cpp/MinGW64/lib" -L"D:/Program Files (x86)/Dev-Cpp/MinGW64/x86_64-w64-mingw32/lib" -static-libgcc
	INCS  += -I"D:/Program Files (x86)/Dev-Cpp/MinGW64/include" -I"D:/Program Files (x86)/Dev-Cpp/MinGW64/x86_64-w64-mingw32/include" -I"D:/Program Files (x86)/Dev-Cpp/MinGW64/lib/gcc/x86_64-w64-mingw32/4.9.2/include"
else
	# Get OS name
	UNAME_S += $(shell uname -s)

	ifeq ($(UNAME_S), Linux)
		RM    += rm
		MKDIR += mkdir
		CLIBS += -lncurses -ltinfo
	endif
endif

.PHONY: all clean
.DELETE_ON_ERROR: clean

all: $(BIN)

$(BUILD_DIR):
	$(MKDIR) $(BUILD_DIR)

$(BIN): $(OBJS)
	$(CC) $< -o $@ $(CLIBS) $(CFLAGS)

$(OBJS): $(SRCS) $(BUILD_DIR)
	$(CC) -c $< -o $@ $(CFLAGS)

clean:
	$(RM) $(OBJ)
	$(RM) $(BIN)

# Project binary name
BIN   := c_minigame
RM    :=
MKDIR :=

# Build directory
BUILD_DIR := build

SRCS := main.c
OBJS := $(SRCS:%.c=$(BUILD_DIR)/%.o)
INCS :=

CFLAGS += $(INCS) -Wall -Wextra -Wpedantic
CFLAGS += -Werror # Set all warnings to be treated as errors

# Tell the program what OS we are in
OSFLAGS :=
UNAME_S :=

ifeq ($(OS), Windows_NT)
	# Append .exe to binary name
	BIN     := $(BIN:%=%.exe)
	CC      := gcc.exe
	OSFLAGS += -D WIN32
	RM      += rm.exe -f
	MKDIR   +=

	# NOTE: I don't think this is portable, please change this.
	CFLAGS += -L"D:/Program Files (x86)/Dev-Cpp/MinGW64/lib" -L"D:/Program Files (x86)/Dev-Cpp/MinGW64/x86_64-w64-mingw32/lib" -static-libgcc
	INCS   += -I"D:/Program Files (x86)/Dev-Cpp/MinGW64/include" -I"D:/Program Files (x86)/Dev-Cpp/MinGW64/x86_64-w64-mingw32/include" -I"D:/Program Files (x86)/Dev-Cpp/MinGW64/lib/gcc/x86_64-w64-mingw32/4.9.2/include"
else
	# Get OS name
	UNAME_S += $(shell uname -s)

	ifeq ($(UNAME_S), Linux)
		OSFLAGS += -D LINUX
		RM      += rm
		MKDIR   += mkdir
	endif
	ifeq ($(UNAME_S), Darwin)
		OSFLAGS += -D OSX
		RM      += rm
		MKDIR   += mkdir
	endif
endif

.PHONY: all clean
.DELETE_ON_ERROR: clean

all: $(BIN)

$(BUILD_DIR):
	$(MKDIR) $(BUILD_DIR)

$(BIN): $(OBJS)
	$(CC) $< -o $@ $(CFLAGS) $(OSFLAGS)

$(OBJS): $(SRCS) $(BUILD_DIR)
	$(CC) -c $< -o $@ $(CFLAGS) $(OSFLAGS)

clean:
	$(RM) $(OBJ)
	$(RM) $(BIN)

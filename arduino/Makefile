# Board setup
BOARD_TAG    = nano
BOARD_SUB    = atmega328

# Use 'do_upload' target to upload software to arduino's flash.
# You need to set this variable correctly.
MONITOR_PORT ?= /dev/ttyUSB0

# LCD pins/pcb socket have been prepared, but software is lagging behind.
# Disabling until the situation changes.
#ARDUINO_LIBS = LiquidCrystal

# Libs for handling the Nema motor and the trigger swtiches.
ARDUINO_LIBS = StepperDriver Switch

# Points to submodule
ARDMK_DIR:=$(PWD)/Arduino-Makefile

# You may need to change this, depending on your local setup.
ARDUINO_DIR ?= $(HOME)/arduino/arduino-1.8.5

USER_LIB_PATH := $(PWD)

# We don't need exact math. Let gcc be a bit more agressive.
CFLAGS += -ffast-math
CXXFLAGS += -ffast-math

include $(ARDMK_DIR)/Arduino.mk

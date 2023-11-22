#############################
# Make file for STM8S208RB
#############################
MCU=stm8s208RB
PROGRAMMER=stlinkv21
FLASH_SIZE=131072
BOARD_INC=inc/stm8s208.inc inc/nucleo_8s208.inc
BUILD_DIR=build/s208/
include Makefile

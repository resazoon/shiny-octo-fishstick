ARCHS = arm64
TARGET = iphone:clang:latest

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = MyFirstESP
MyFirstESP_FILES = main.mm
MyFirstESP_CFLAGS = -fobjc-arc -Wno-deprecated-declarations
MyFirstESP_FRAMEWORKS = UIKit Foundation CoreGraphics

include $(THEOS_MAKE_PATH)/tweak.mk

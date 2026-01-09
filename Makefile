ARCHS = arm64
TARGET = iphone:clang:latest:14.0

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = MyFirstESP
MyFirstESP_FILES = main.mm
MyFirstESP_CFLAGS = -fobjc-arc
MyFirstESP_FRAMEWORKS = UIKit Foundation CoreGraphics

include $(THEOS_MAKE_PATH)/tweak.mk

ARCHS = arm64
# 最新のSDKに無理に合わせず、自動で最適なものを選ばせる設定だじょ
TARGET = iphone:clang:latest:15.0

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = MyFirstESP
MyFirstESP_FILES = main.mm
MyFirstESP_CFLAGS = -fobjc-arc -Wno-deprecated-declarations -Wno-unused-variable
MyFirstESP_FRAMEWORKS = UIKit Foundation CoreGraphics

include $(THEOS_MAKE_PATH)/tweak.mk

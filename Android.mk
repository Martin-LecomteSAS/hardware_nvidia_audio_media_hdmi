# Copyright (C) 2012 The Android Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

ifeq ($(BOARD_USES_TEGRA_HDMI),true)

LOCAL_PATH := $(call my-dir)

###
### GENERIC AUDIO HAL
###

ifneq ($(TARGET_BOOTLOADER_BOARD_NAME),)
TARGET_AUDIO_HWNAME := $(TARGET_BOOTLOADER_BOARD_NAME)
else
TARGET_AUDIO_HWNAME := $(TARGET_BOARD_PLATFORM)
endif

include $(CLEAR_VARS)

LOCAL_MODULE := audio.primary.$(TARGET_AUDIO_HWNAME)
LOCAL_MODULE_RELATIVE_PATH := hw

LOCAL_SRC_FILES := \
	nvidia_hdmi_audio_hw.c

LOCAL_C_INCLUDES += \
	external/tinyalsa/include \
	system/media/audio_route/include \
	$(call include-path-for, audio-utils) \
	$(call include-path-for, audio-effects)

ifdef BOARD_AUDIO_PCM_DEVICE_DEFAULT_OUT
    LOCAL_CFLAGS += -DPCM_DEVICE_DEFAULT_OUT=$(BOARD_AUDIO_PCM_DEVICE_DEFAULT_OUT)
endif

ifdef BOARD_AUDIO_PCM_DEVICE_DEFAULT_IN
    LOCAL_CFLAGS += -DPCM_DEVICE_DEFAULT_IN=$(BOARD_AUDIO_PCM_DEVICE_DEFAULT_IN)
endif

ifdef BOARD_AUDIO_OUT_SAMPLING_RATE
    LOCAL_CFLAGS += -DOUT_SAMPLING_RATE=$(BOARD_AUDIO_OUT_SAMPLING_RATE)
endif

LOCAL_SHARED_LIBRARIES := liblog libcutils libtinyalsa libaudioutils libaudio-resampler libaudioroute libaudiospdif
LOCAL_MODULE_TAGS := optional

include $(BUILD_SHARED_LIBRARY)

endif

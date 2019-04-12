#!/bin/bash

if [ "$1" = "on" ]
then

	adb shell settings put global sysui_demo_allowed 1
	adb shell am broadcast -a com.android.systemui.demo -e command clock -e hhmm 0600
	adb shell am broadcast -a com.android.systemui.demo -e command network -e mobile show -e level 4 -e datatype lte
	adb shell am broadcast -a com.android.systemui.demo -e command network -e wifi hide
	adb shell am broadcast -a com.android.systemui.demo -e command battery -e plugged false -e level 100
	adb shell am broadcast -a com.android.systemui.demo -e command notifications -e visible false
	adb shell settings put secure icon_blacklist alarm_clock,rotate,battery
	adb shell settings put global policy_control immersive.navigation=apps

else

	adb shell settings put global policy_control null*
	adb shell settings put secure icon_blacklist null*
	adb shell settings put secure icon_blacklist rotate
	adb shell am broadcast -a com.android.systemui.demo -e command exit

fi

#!/bin/bash
# Auto Increment Version Script
buildPlist="CoachTools-Info.plist"
buildVersion=$(/usr/libexec/PlistBuddy -c "Print CFBuildVersion" $buildPlist)
buildNumber=$(/usr/libexec/PlistBuddy -c "Print CFBuildNumber" $buildPlist)
buildNumber=$(($buildNumber + 1))
/usr/libexec/PlistBuddy -c "Set :CFBuildNumber $buildNumber" $buildPlist
/usr/libexec/PlistBuddy -c "Set :CFBundleVersion $buildVersion.$buildNumber" $buildPlist
/usr/libexec/PlistBuddy -c "Set :CFBundleShortVersionString $buildVersion.$buildNumber" $buildPlist

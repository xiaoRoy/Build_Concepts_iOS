#!/bin/sh

#  ImageLoadingXCFrameworkScript.sh
#  NetworkService
#
#  Created by Jerry Li on 2025/4/25.
#  
xcodebuild -create-xcframework \
    -archive "../archives/ImageLoading-iOS.xcarchive" -framework ImageLoading.framework \
    -archive "../archives/ImageLoading-iOS-Simulator.xcarchive" -framework ImageLoading.framework \
    -output "../xcframeworks/ImageLoading.xcframework"

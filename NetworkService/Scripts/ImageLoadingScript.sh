#!/bin/sh

#  ImageLoadingScript.sh
#  NetworkService
#
#  Created by Jerry Li on 2025/4/24.
#

PROJECT="../NetworkService.xcodeproj"
SCHEME="XCFramework ImageLoading"

xcodebuild archive \
    -project "$PROJECT" \
    -scheme "$SCHEME" \
    -destination "generic/platform=iOS" \
    -archivePath "../archives/ImageLoading-iOS" \
    SKIP_INSTALL=NO \
    BUILD_LIBRARY_FOR_DISTRIBUTION=YES \
    
xcodebuild archive \
    -project "$PROJECT" \
    -scheme "$SCHEME" \
    -destination "generic/platform=iOS Simulator" \
    -archivePath "../archives/ImageLoading-iOS-Simulator" \
    SKIP_INSTALL=NO \
    BUILD_LIBRARY_FOR_DISTRIBUTION=YES \
  




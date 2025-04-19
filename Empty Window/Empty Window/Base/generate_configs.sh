#
#//  generate_cofigs.sh
#//  Empty Window
#//
#//  Created by Jerry Li on 2025/4/16.
#//

#!/bin/sh
# Define the output path for the generated Swift file.

echo "Current build configuration:${CONFIGURATION}"
echo "SRCROOT:${SRCROOT}"
#CONFIG_IN_LOWER=$(echo "${CONFIGURATION}" | '[:upper:]' '[:lower:]')
ENV_FILE="${SRCROOT}/Empty Window/Configs/${CONFIGURATION}.env"

set -a
. "$ENV_FILE"
set +a

CONFIG_FILE_NAME="Configs.swift"

CONFIGS_SWIFT_FILE="${SRCROOT}/Empty Window/Base/${CONFIG_FILE_NAME}"

echo "Generating ${CONFIG_FILE_NAME} file at: ${CONFIGS_SWIFT_FILE}"

cat > "$CONFIGS_SWIFT_FILE" <<EOF
// This file is auto-generated. Do not edit.

struct Configs {
    static let remoteConfiKey: String = "${REMOTE_CONFIG_KEY:-default-remote-config-key}"
}
EOF
echo "${CONFIG_FILE_NAME} generated successfully."

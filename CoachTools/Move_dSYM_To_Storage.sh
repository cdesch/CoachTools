#!/bin/sh

if [ "$BUILD_STYLE" == "Debug" ]; then
  echo "Skipping debug"
  exit 0;
fi

if [ "$EFFECTIVE_PLATFORM_NAME" == "-iphonesimulator" ]; then
  echo "Skipping simulator build"
  exit 0;
fi

SRC_PATH=${DWARF_DSYM_FOLDER_PATH}/${DWARF_DSYM_FILE_NAME}
RELATIVE_DEST_PATH=dSYM/${EXECUTABLE_NAME}.$(date +%Y%m%d%H%M%S).app.dSYM
DEST_PATH=${PROJECT_DIR}/${RELATIVE_DEST_PATH}
echo "moving ${SRC_PATH} to ${DEST_PATH}"

mv "${SRC_PATH}" "${DEST_PATH}"

if [ -f ".git/config" ]; then
  git add "${RELATIVE_DEST_PATH}"
  git commit -m "Added dSYM file for ${BUILD_STYLE} build" "${RELATIVE_DEST_PATH}"
fi
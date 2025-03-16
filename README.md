# Sample QT apps

## GcBug

A QT app demonstrating how to use std::shared_ptr in QML.

## TableDemo

A QT app demonstrating redundant TableView updates, see QTBUG https://bugreports.qt.io/browse/QTBUG-134741.

Building on Windows:

    %MY_CMAKE_EXE% ..\..\repos\QtSamples\TableDemo -G %MY_VS_GENERATOR% -A x64 -D CMAKE_PREFIX_PATH="%MY_QT_DIR%"

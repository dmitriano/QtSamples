cmake_minimum_required(VERSION 3.16)

project(TableDemo VERSION 0.1 LANGUAGES CXX)

set(CMAKE_AUTOMOC ON)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 6.2 COMPONENTS Core Gui Quick Qml REQUIRED)

# Suppress "Qt policy QTP0002 is not set" warning.
qt_policy(SET QTP0002 NEW)

qt_add_executable(appTableDemo
    main.cpp TableModel.cpp TableModel.h
)

qt_add_qml_module(appTableDemo
    URI TableDemo
    VERSION 1.0
    NO_RESOURCE_TARGET_PATH
    QML_FILES main.qml 
)

target_compile_definitions(appTableDemo
    PRIVATE $<$<OR:$<CONFIG:Debug>,$<CONFIG:RelWithDebInfo>>:QT_QML_DEBUG>)
target_link_libraries(appTableDemo
    PRIVATE Qt6::Core Qt6::Gui Qt6::Quick Qt6::Qml)

cmake_minimum_required(VERSION 3.16)

project(GcBug VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 23)

set(CMAKE_AUTOMOC ON)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 COMPONENTS Quick REQUIRED)

qt_add_executable(appGcBug
    main.cpp ElementModel.cpp ElementModel.h SharedGadget.h BotModel.h BotManager.cpp BotManager.h
)

qt_add_qml_module(appGcBug
    URI GcBug
    VERSION 1.0
    QML_FILES main.qml BotDialog.qml BotPage.qml
)

set_target_properties(appGcBug PROPERTIES
    MACOSX_BUNDLE_GUI_IDENTIFIER my.example.com
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(appGcBug
    PRIVATE Qt6::Quick)

install(TARGETS appGcBug
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR})

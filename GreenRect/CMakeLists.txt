cmake_minimum_required(VERSION 3.16)

project(GreenRect VERSION 0.1 LANGUAGES CXX)

set(CMAKE_AUTOMOC ON)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 6.2 COMPONENTS Quick REQUIRED)

qt_add_executable(appGreenRect
    main.cpp
)

qt_add_qml_module(appGreenRect
    URI GreenRect
    VERSION 1.0
    QML_FILES main.qml 
)

target_compile_definitions(appGreenRect
    PRIVATE $<$<OR:$<CONFIG:Debug>,$<CONFIG:RelWithDebInfo>>:QT_QML_DEBUG>)
target_link_libraries(appGreenRect
    PRIVATE Qt6::Quick)

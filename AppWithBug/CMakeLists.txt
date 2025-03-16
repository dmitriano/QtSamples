cmake_minimum_required(VERSION 3.19.1)

project(AppWithBug LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

if ("${CMAKE_CXX_COMPILER_ID}" STREQUAL "Clang")
    # using Clang
    #add_definitions("-Wall -Wextra -Wno-unused-function -pedantic -pthread")
    add_definitions("-Wall -Wextra -pedantic")
    #link_libraries("-fsanitize=address")
    #set(CMAKE_EXE_LINKER_FLAGS "-fuse-ld=gold")
elseif ("${CMAKE_CXX_COMPILER_ID}" STREQUAL "GNU")
    # using GCC
    #add_definitions("-Wall -Wextra -pedantic)
    #add_definitions("-Wall -Wextra -pedantic -pthread")
    #add_definitions("-fsanitize=thread -fno-omit-frame-pointer")
    #link_libraries("-fsanitize=thread")
    #add_definitions("-fsanitize=undefined -fno-omit-frame-pointer")
    #link_libraries("-fsanitize=undefined")
    #add_definitions("-fsanitize=address -fno-omit-frame-pointer")
    #link_libraries("-fsanitize=address")
    #set(CMAKE_EXE_LINKER_FLAGS "-fuse-ld=gold")
elseif ("${CMAKE_CXX_COMPILER_ID}" STREQUAL "Intel")
    # using Intel C++
elseif ("${CMAKE_CXX_COMPILER_ID}" STREQUAL "MSVC")
    # using Visual Studio C++
    add_compile_options("/Zc:__cplusplus")
    add_compile_options("/W4")
    add_definitions(-D_UNICODE)
    add_definitions(-MP)
    add_definitions(-D_CRT_SECURE_NO_WARNINGS -DNOMINMAX)
endif()

set(CMAKE_AUTOUIC ON)
# Tell CMake to run moc when necessary:
set(CMAKE_AUTOMOC ON)
# As moc files are generated in the binary dir, tell CMake
# to always look for includes there:
set(CMAKE_INCLUDE_CURRENT_DIR ON)
#The rcc tool is used to embed resources into a Qt application during the build process.
set(CMAKE_AUTORCC ON)

find_package(Qt6 COMPONENTS Core Gui Quick Qml Multimedia LinguistTools Svg REQUIRED)

file(GLOB CPP_FILES
    ${CMAKE_SOURCE_DIR}/*.cpp ${CMAKE_SOURCE_DIR}/*.h)

file(GLOB_RECURSE RESOURCE_FILES ${CMAKE_SOURCE_DIR}/*.qrc)

qt_add_executable(${PROJECT_NAME} ${CPP_FILES} ${RESOURCE_FILES})

if(ANDROID)
    set_property(TARGET ${PROJECT_NAME} APPEND PROPERTY QT_ANDROID_PACKAGE_SOURCE_DIR
        ${CMAKE_CURRENT_SOURCE_DIR}/platform/android/)
endif()

set_target_properties(${PROJECT_NAME} PROPERTIES
    WIN32_EXECUTABLE TRUE
    MACOSX_BUNDLE TRUE
)

target_link_libraries(${PROJECT_NAME}
  PRIVATE Qt6::Core Qt6::Gui Qt6::Quick Qt6::Qml Qt6::Multimedia Qt6::Svg)

cmake_minimum_required(VERSION 2.8.11)

project(HelloQt)

set(CMAKE_INSTALL_PREFIX ${CMAKE_BINARY_DIR})
set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} ${${PROJECT_NAME}_SOURCE_DIR}/cmake)

message(STATUS "PROJECT_NAME=${PROJECT_NAME}")
message(STATUS "CMAKE_MODULE_PATH=${CMAKE_MODULE_PATH}")

#set mac os x
set(CMAKE_OSX_ARCHITECTURES "i386")
set(CMAKE_OSX_DEPLOYMENT_TARGET "10.9")
set(CMAKE_OSX_SYSROOT "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX${CMAKE_OSX_DEPLOYMENT_TARGET}.sdk")
set(CMAKE_SYSROOT "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX${CMAKE_OSX_DEPLOYMENT_TARGET}.sdk")

set(MACOSX_BUNDLE_BUNDLE_NAME "${PROJECT_NAME}")
set(MACOSX_BUNDLE_BUNDLE_VERSION "1.0")
set(MACOSX_BUNDLE_LONG_VERSION_STRING "1.0")
set(MACOSX_BUNDLE_SHORT_VERSION_STRING "1.0")
set(MACOSX_BUNDLE_COPYRIGHT "Copyright (c) 2015 MeMySelfAndI.")
set(MACOSX_BUNDLE_GUI_IDENTIFIER "com.memyselfandi.${PROJECT_NAME}")
#set(MACOSX_BUNDLE_ICON_FILE AppIcon.icns)

#force 32-bit build
set(CMAKE_CFLAGS "-m32")
set(CMAKE_CXX_FLAGS "-m32")
set(CMAKE_LFLAGS "-m32")

# Find includes in corresponding build directories
set(CMAKE_INCLUDE_CURRENT_DIR ON)

# Instruct CMake to run moc automatically when needed.
set(CMAKE_AUTOMOC ON)

# Find the QtWidgets library
find_package(Qt5Widgets)

message(STATUS "CMAKE_OSX_SYSROOT=${CMAKE_OSX_SYSROOT}")
message(STATUS "CMAKE_OSX_DEPLOYMENT_TARGET=${CMAKE_OSX_DEPLOYMENT_TARGET}")
message(STATUS "MACOSX_DEPLOYMENT_TARGET=${MACOSX_DEPLOYMENT_TARGET}")

FIND_LIBRARY(APP_SERVICES_LIBRARY NAMES ApplicationServices
       NO_DEFAULT_PATH
       NO_CMAKE_ENVIRONMENT_PATH
       NO_CMAKE_PATH
       NO_SYSTEM_ENVIRONMENT_PATH
       NO_CMAKE_SYSTEM_PATH
       PATHS "${CMAKE_OSX_SYSROOT}/System/Library/Frameworks/"
)
FIND_LIBRARY(COCOA_LIBRARY NAMES Cocoa
       NO_DEFAULT_PATH
       NO_CMAKE_ENVIRONMENT_PATH
       NO_CMAKE_PATH
       NO_SYSTEM_ENVIRONMENT_PATH
       NO_CMAKE_SYSTEM_PATH
       PATHS "${CMAKE_OSX_SYSROOT}/System/Library/Frameworks/"
)

#find_library( COREFOUNDATION_FRAMEWORK NAMES CoreFoundation
#       NO_DEFAULT_PATH
#       NO_CMAKE_ENVIRONMENT_PATH
#       NO_CMAKE_PATH
#       NO_SYSTEM_ENVIRONMENT_PATH
#       NO_CMAKE_SYSTEM_PATH
#       PATHS "${CMAKE_OSX_SYSROOT}/System/Library/Frameworks/"
#   )
#message(STATUS "framework: ${COREFOUNDATION_FRAMEWORK}" )


message(STATUS "found framework Cocoa at \"${COCOA_LIBRARY}\"")
message(STATUS "found framework ApplicationServices at \"${APP_SERVICES_LIBRARY}\"")

qt5_wrap_ui(UI_HEADERS mainwindow.ui)

#not necessary (actually not allowed) when AUTOMOC is turned on
#qt5_wrap_cpp(MOC_HEADERS
#            # mainwindow.cpp wrapper.mm main.cpp
#             mainwindow.h wrapper.h)

message(STATUS "UI_HEADERS=${UI_HEADERS}")
message(STATUS "MOC_HEADERS=${MOC_HEADERS}")

# Tell CMake to create the executable
add_executable(${PROJECT_NAME}
	       WIN32
	       MACOSX_BUNDLE           #create an .app bundle on Mac
               ${UI_HEADERS}
               ${MOC_HEADERS}
               main.cpp
               mainwindow.cpp
               mainwindow.h
)

# Use the Widgets module from Qt 5.
target_link_libraries(${PROJECT_NAME}
                      Qt5::Widgets
                      ${APP_SERVICE_LIBRARY}
                      ${COCOA_LIBRARY}
#                      ${COREFOUNDATION_FRAMEWORK}
                     )

include(DeployQt5)

install_qt5_executable(${PROJECT_NAME}.app)

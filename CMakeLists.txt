cmake_minimum_required(VERSION 3.16)

project(PredatorBlue VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(QML_IMPORT_PATH ${QML_IMPORT_PATH} ${CMAKE_SOURCE_DIR}/qml)

find_package(Qt6 REQUIRED COMPONENTS Quick)

# find_path(NVML_INCLUDE_DIR nvml.h PATHS /usr/include /usr/local/include /opt/cuda/include)
# find_library(NVML_LIB nvidia-ml PATHS /usr/lib /usr/local/lib /opt/cuda/lib64)

set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)
set(CMAKE_AUTOUIC ON)

qt_add_executable(appPredatorBlue
    src/main.cpp
)

qt_add_qml_module(appPredatorBlue
    URI PredatorBlue
    VERSION 1.0
    QML_FILES qml/Main.qml
    QML_FILES qml/CyberButton.qml
    QML_FILES qml/SpeedoMeter.qml
    QML_FILES qml/CyberLabel.qml
    QML_FILES qml/CyberNavbar.qml
    QML_FILES qml/CyberSelectButton.qml
    QML_FILES qml/CyberSlider.qml
    QML_FILES qml/modules/ArcItem.qml
    QML_FILES qml/modules/EllipseItem.qml
    RESOURCES assets/assets.qrc
    SOURCES headers/sysfswriter.h src/sysfswriter.cpp
    QML_FILES
    QML_FILES qml/CyberToggleLeft.qml
    QML_FILES qml/CyberToggleRight.qml
    QML_FILES qml/CyberToggleCenter.qml
    QML_FILES qml/CyberToggleGroup.qml
    QML_FILES qml/CyberToggleButton.qml
    QML_FILES qml/CyberMiscItem.qml
    QML_FILES qml/CyberModeButton.qml
)

# Qt for iOS sets MACOSX_BUNDLE_GUI_IDENTIFIER automatically since Qt 6.1.
# If you are developing for iOS or macOS you should consider setting an
# explicit, fixed bundle identifier manually though.
set_target_properties(appPredatorBlue PROPERTIES
    #    MACOSX_BUNDLE_GUI_IDENTIFIER com.example.appPredatorBlue
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)



# if (NVML_INCLUDE_DIR AND NVML_LIB)
#     include_directories(${NVML_INCLUDE_DIR})
#     target_link_libraries(appPredatorBlue
#         PRIVATE Qt6::Quick
#         ${NVML_LIB}
#     )
# else()
#     message(FATAL_ERROR "NVML not found. Please install NVIDIA NVML.")
# endif()

target_link_libraries(appPredatorBlue
    PRIVATE Qt6::Quick
)

include(GNUInstallDirs)
install(TARGETS appPredatorBlue
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)

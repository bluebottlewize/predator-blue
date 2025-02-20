cmake_minimum_required(VERSION 3.16)

project(PredatorBlue VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(QML_IMPORT_PATH ${QML_IMPORT_PATH})

find_package(Qt6 REQUIRED COMPONENTS Quick Concurrent)

# qt_standard_project_setup()

set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)
set(CMAKE_AUTOUIC ON)

qt_add_executable(appPredatorBlue
    main.cpp
)

qt_add_qml_module(appPredatorBlue
    URI PredatorBlue
    VERSION 1.0
    QML_FILES
        Main.qml
        RESOURCES assets.qrc
        SOURCES sysfswriter.h sysfswriter.cpp
        QML_FILES CyberButton.qml
        QML_FILES SpeedoMeter.qml
        QML_FILES CyberLabel.qml
        QML_FILES CyberNavbar.qml
        QML_FILES CyberSelectButton.qml
        QML_FILES CyberSlider.qml
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

target_link_libraries(appPredatorBlue
    PRIVATE Qt6::Quick
    PRIVATE Qt6::Concurrent
)

include(GNUInstallDirs)
install(TARGETS appPredatorBlue
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)

cmake_minimum_required(VERSION 3.16)

project(qmlListView VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

set(BIN_NAME appqmlListView)

find_package(Qt6 6.4 REQUIRED COMPONENTS Quick Qml)

qt_standard_project_setup()

qt_add_executable(${BIN_NAME}
    main.cpp
)

qt_add_qml_module(${BIN_NAME}
    URI qmlListview
    VERSION 1.0
    QML_FILES Main.qml
    QML_FILES ListView1.qml
    SOURCES itemspagemodel.h itemspagemodel.cpp
)

# Qt for iOS sets MACOSX_BUNDLE_GUI_IDENTIFIER automatically since Qt 6.1.
# If you are developing for iOS or macOS you should consider setting an
# explicit, fixed bundle identifier manually though.
set_target_properties(${BIN_NAME} PROPERTIES
#    MACOSX_BUNDLE_GUI_IDENTIFIER com.example.appqmlListView
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(${BIN_NAME}
    PRIVATE Qt6::Quick Qt::Qml
)

include(GNUInstallDirs)
install(TARGETS ${BIN_NAME}
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)

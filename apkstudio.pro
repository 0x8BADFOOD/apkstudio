QT += core gui widgets

TARGET = ApkStudio
TEMPLATE = app

CONFIG += c++11

HEADERS += \
    sources/adbinstallworker.h \
    sources/apkdecompiledialog.h \
    sources/apkdecompileworker.h \
    sources/apkrecompileworker.h \
    sources/apksignworker.h \
    sources/binarysettingsdialog.h \
    sources/binarysettingswidget.h \
    sources/findreplacedialog.h \
    sources/mainwindow.h \
    sources/processutils.h \
    sources/signingconfigdialog.h \
    sources/signingconfigwidget.h \
    sources/sourcecodeedit.h \
    sources/splashwindow.h \
    sources/versionresolveworker.h

SOURCES += \
    sources/main.cpp \
    sources/adbinstallworker.cpp \
    sources/apkdecompiledialog.cpp \
    sources/apkdecompileworker.cpp \
    sources/apkrecompileworker.cpp \
    sources/apksignworker.cpp \
    sources/binarysettingsdialog.cpp \
    sources/binarysettingswidget.cpp \
    sources/findreplacedialog.cpp \
    sources/mainwindow.cpp \
    sources/processutils.cpp \
    sources/signingconfigdialog.cpp \
    sources/signingconfigwidget.cpp \
    sources/sourcecodeedit.cpp \
    sources/splashwindow.cpp \
    sources/versionresolveworker.cpp

RESOURCES += \
    resources/all.qrc

macx:ICON = resources/icon.icns
win32:RC_ICONS += resources/icon.ico

QMAKE_TARGET_COMPANY = Vaibhav Pandey -aka- VPZ
QMAKE_TARGET_COPYRIGHT = Vaibhav Pandey
QMAKE_TARGET_DESCRIPTION = Open-source, cross-platform Qt based IDE for reverse-engineering Android application packages.
QMAKE_TARGET_PRODUCT = APK Studio

win32 {
    NULL_DEVICE = NUL
} else {
    NULL_DEVICE = /dev/null
}

GIT_CMD_BASE = git --git-dir $$PWD/.git --work-tree $$PWD
GIT_BRANCH = $$system($$GIT_CMD_BASE rev-parse --abbrev-ref HEAD 2> $$NULL_DEVICE)
GIT_COMMIT_FULL = $$system($$GIT_CMD_BASE rev-parse HEAD 2> $$NULL_DEVICE)
GIT_COMMIT_NUMBER = $$system($$GIT_CMD_BASE rev-list HEAD --count 2> $$NULL_DEVICE)
GIT_COMMIT_SHORT = $$system($$GIT_CMD_BASE rev-parse --short HEAD 2> $$NULL_DEVICE)
GIT_TAG = $$system($$GIT_CMD_BASE tag -l --points-at HEAD 2> $$NULL_DEVICE)

DEFINES += GIT_BRANCH=\\\"$$GIT_BRANCH\\\" \
    GIT_COMMIT_FULL=\\\"$$GIT_COMMIT_FULL\\\" \
    GIT_COMMIT_NUMBER=\\\"$$GIT_COMMIT_NUMBER\\\" \
    GIT_COMMIT_SHORT=\\\"$$GIT_COMMIT_SHORT\\\" \
    GIT_TAG=\\\"$$GIT_TAG\\\"

!isEmpty(GIT_TAG) {
    win32 {
        VERSION = $${GIT_TAG}.$${GIT_COMMIT_NUMBER}
    } else {
        VERSION = $$GIT_TAG
    }
    macx {
        INFO_PLIST_PATH = $$shell_quote($${OUT_PWD}/$${TARGET}.app/Contents/Info.plist)
        QMAKE_POST_LINK += /usr/libexec/PlistBuddy -c \"Set :CFBundleShortVersionString $${VERSION}\" $${INFO_PLIST_PATH}
    }
}

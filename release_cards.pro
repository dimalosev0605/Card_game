QT += quick
QT += svg

CONFIG += c++11

# The following define makes your compiler emit warnings if you use
# any Qt feature that has been marked deprecated (the exact warnings
# depend on your compiler). Refer to the documentation for the
# deprecated API to know how to port your code away from it.
DEFINES += QT_DEPRECATED_WARNINGS

# You can also make your code fail to compile if it uses deprecated APIs.
# In order to do so, uncomment the following line.
# You can also select to disable deprecated APIs only up to a certain version of Qt.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0

SOURCES += \
        models/base_model.cpp \
        models/human_model.cpp \
        models/bot_model.cpp \
        models/referee_model.cpp \
        card.cpp \
        main.cpp

RESOURCES += qml.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Additional import path used to resolve QML modules just for Qt Quick Designer
QML_DESIGNER_IMPORT_PATH =

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

DISTFILES += \
    cards/backs/back.svg \
    cards/backs/back_1.png \
    cards/backs/four_backs.png \
    cards/backs/rotated_back.png \
    cards/backs/three_backs.png \
    cards/backs/two_backs.png \
    cards/clubs/10.svg \
    cards/clubs/6.svg \
    cards/clubs/7.svg \
    cards/clubs/8.svg \
    cards/clubs/9.svg \
    cards/clubs/ace.svg \
    cards/clubs/jack.svg \
    cards/clubs/king.svg \
    cards/clubs/queen.svg \
    cards/diamonds/10.svg \
    cards/diamonds/6.svg \
    cards/diamonds/7.svg \
    cards/diamonds/8.svg \
    cards/diamonds/9.svg \
    cards/diamonds/ace.svg \
    cards/diamonds/jack.svg \
    cards/diamonds/king.svg \
    cards/diamonds/queen.svg \
    cards/hearts/10.svg \
    cards/hearts/6.svg \
    cards/hearts/7.svg \
    cards/hearts/8.svg \
    cards/hearts/9.svg \
    cards/hearts/ace.svg \
    cards/hearts/jack.svg \
    cards/hearts/king.svg \
    cards/hearts/queen.svg \
    cards/spades/10.svg \
    cards/spades/6.svg \
    cards/spades/7.svg \
    cards/spades/8.svg \
    cards/spades/9.svg \
    cards/spades/ace.svg \
    cards/spades/jack.svg \
    cards/spades/king.svg \
    cards/spades/queen.svg

HEADERS += \
    models/base_model.h \
    models/human_model.h \
    models/bot_model.h \
    models/referee_model.h \
    card.h \
    Constants.h

import QtQuick 2.10
import QtQuick.Controls 2.3
//import ah 1.0

ApplicationWindow {
    id: window
    visible: true
    width: 640
    height: 480
    title: qsTr("Stack")

    //    myBack {

    //    }
    Rectangle {
        id: _btn1
        anchors.top: parent.top
        anchors.horizontalCenter: parent.horizontalCenter
        width: 40
        height: 20
        color: "green"
        MouseArea {
            anchors.fill: parent
            onPressed: _load.sourceComponent = _comp
        }
    }

    Rectangle {
        anchors.top: _btn1.top
        anchors.topMargin: 10
        anchors.horizontalCenter: parent.horizontalCenter
        width: 40
        height: 20
        color: "red"
        MouseArea {
            onPressed: myBack.trigInd(1)
anchors.fill: parent
        }
    }

    Loader {
        id: _load
        anchors.centerIn: parent
    }

    Component {
        id: _comp
        ComboBox {
            anchors.centerIn: parent
            currentIndex: myBack.ind
            model: myBack.cont

            property int _lastValid: -1    // index to be set after model is ready
            property bool _fakeZero: false // skip spurious qml init index after it had been already inited
            property int _prevSize: -1     // whether we're interested in changes of model size


            onCurrentIndexChanged: {
                // proper index from backend comes before model, it MUST be stored for the time when model is ready and MUST NOT trigger index change
                console.log("00000", currentIndex, model);
                if ( model.length <= 0 ) {
                    _lastValid = currentIndex;
                    _fakeZero = true;
                    console.log("11111", currentIndex, model);

                    return;
                }
                // after premature backend index goes qml initialization which MUST be skipped
                if( _fakeZero ) {
                    _fakeZero = false;
                    console.log("22222", currentIndex, model);

                    return;
                }
                // once model is ready, we set proper index (stored earlier on line 86) and SHOULD NOT trigger changes
                if( _prevSize !== -1 && _lastValid !== -1) {
                    _lastValid = -1;
                    _prevSize = -1;
                    console.log("33333", currentIndex, model);

                    return;
                }
                // sometimes qml goes crazy
                if(currentIndex === -1 ) {
                    console.log("44444", currentIndex, model);

                    return;
                }
                console.log("55555", currentIndex, model);

                //_root.setCurrentIndex(_comboBox.currentIndex);
            }

            onModelChanged: {
                console.log(model.length, model);

                // again, model is received after index, such we MUST set index ourselves and not trigger changes
                if ( _lastValid !== -1 && _prevSize === -1 && model.length > 0) {
                    _prevSize = model.length;
                    console.log("into model");

                    // 2nd type of behaviour - if currentIndex from backend is 0 then no additional signal
                    // onCurrentIndexChanded is emitted
                    if (_fakeZero) {
                        console.log("stop fake");

                        _fakeZero = false;
                        _lastValid = -1;
                        _prevSize = -1;
                        return;
                    }
                    console.log("set index from model");

                    currentIndex = _lastValid;
                }
            }
        }
    }
}

import QtQuick 2.0
import Ubuntu.Components 1.1
import "jsonparser.js" as API
import "jsonpath.js" as JSONPath

/*!
    \brief MainView with a Label and Button elements.
*/

MainView {
    id: main
    // objectName for functional testing purposes (autopilot-qt5)
    objectName: "mainView"

    // Note! applicationName needs to match the "name" field of the click manifest
    applicationName: "readjsonfile.liu-xiao-guo"

    /*
     This property enables the application to change orientation
     when the device is rotated. The default is false.
    */
    //automaticOrientation: true

    // Removes the old toolbar and enables new features of the new header.
    useDeprecatedToolbar: false

    width: units.gu(60)
    height: units.gu(85)

    function update(json) {
        console.log("it is called in update!");
        // we can start to interpret the returned json
        var authors = JSONPath.jsonPath(json, "$.store.book[*].author");

        console.log("length: " + authors.length);

        for (var i in authors ) {
            console.log("author[" + i +"] " + authors[i]);
            mymodel.append( { "content": authors[i],
                               "type": "Authors"
                           });
        }

        // Get all of the books
        var books = JSONPath.jsonPath(json, "$.store.book[*].title");
        console.log("length: " + books.length);
        for (var j in books ) {
            console.log("author[" + j +"] " + books[j]);
            mymodel.append( { "content": books[j],
                               "type": "Books"
                           });
        }

    }

    Page {
        id: mainPage
        title: i18n.tr("Read Json File")


        ListModel {
            id: mymodel
        }

        Component {
            id: sectionHeading
            Rectangle {
                width: mainPage.width
                height: childrenRect.height
                color: "lightsteelblue"

                Text {
                    text: section
                    font.bold: true
                    font.pixelSize: 20
                }
            }
        }

        ListView {
            id: listview
            anchors.fill: parent
            model: mymodel
            delegate: Text {
                text: content
            }

            section.property: "type"
            section.criteria: ViewSection.FullString
            section.delegate: sectionHeading
        }

        Component.onCompleted: {
            console.log("Start to read JSON file");
            API.readJsonFile("sample.json", main)
        }
    }
}


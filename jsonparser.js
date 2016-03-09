/* Based on:
 * JSONListModel - a QML ListModel with JSON and JSONPath support
 *
 * Copyright (c) 2012 Romain Pokrzywka (KDAB) (romain@kdab.com)
 * Licensed under the MIT licence
 * (http://opensource.org/licenses/mit-license.php)
 * https://github.com/s3u/JSONPath
 */

//Qt.include("jsonpath.js")

function readJsonFile(source, callback) {

    var xhr = new XMLHttpRequest;
    xhr.open("GET", source);
    xhr.onreadystatechange = function() {
        if (xhr.readyState == XMLHttpRequest.DONE) {
            var doc = xhr.responseText;
//            console.log("JSON: " + json)
            var json = JSON.parse(doc);
            callback.update(json);
        }
    }

   xhr.send();
}



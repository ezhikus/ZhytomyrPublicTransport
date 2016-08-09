Qt.include("API.js")
Qt.include("Settings.js")

WorkerScript.onMessage = function(message) {
    function onOk(buses, trolleybuses) {
        WorkerScript.sendMessage({'type': 'clear'})

        for (var i = 0; i < buses.length; ++i) {
            WorkerScript.sendMessage({
                                        'type': 'addBus',
                                        'shortName': buses[i].shortName,
                                        'name': buses[i].name,
                                        'id': buses[i].id
                                     })
        }

        for (var i = 0; i < trolleybuses.length; ++i) {
            WorkerScript.sendMessage({
                                        'type': 'addTrolleybus',
                                        'shortName': trolleybuses[i].shortName,
                                        'name': trolleybuses[i].name,
                                        'id': trolleybuses[i].id
                                     })
        }

        WorkerScript.sendMessage({'type': 'updateCompleted'})
    }

    function onFail(buses, trolleybuses) {
        WorkerScript.sendMessage({'type': 'fail'})
    }

    updateTransportInfo(message.url, onOk, onFail);
}

function makeRequst(request, okCallback, errCallback) {
    var doc = new XMLHttpRequest()

    doc.onreadystatechange = function() {
        if (doc.readyState === XMLHttpRequest.DONE) {
            var resObj = {}
            if (doc.status == 200) {
                if (doc.getResponseHeader("Content-Length") === getCachedTransportInfoSize())
                    okCallback(getCachedTransportInfo);
                else
                    makeForcedRequest(request, okCallback, errCallback);
            } else { // Error
                errCallback(doc.responseText)
            }
        }
    }

    doc.open("HEAD", request)
    doc.setRequestHeader("Cookie:", "gts.web.guid=-1")
    doc.send()
}

function makeForcedRequest(request, okCallback, errCallback) {
    var doc = new XMLHttpRequest()

    doc.onreadystatechange = function() {
        if (doc.readyState === XMLHttpRequest.DONE) {
            var resObj = {}
            if (doc.status == 200) {
                setCachedTransportInfoSize(doc.getResponseHeader("Content-Length"));
                setCachedTransportInfo(doc.responseText);
                okCallback(doc.responseText);
            } else { // Error
                errCallback(doc.responseText)
            }
        }
    }

    doc.open("GET", request)
    doc.setRequestHeader("Cookie:", "gts.web.guid=-1")
    doc.send()
}


function updateTransportInfo(url, okCallback, failCallback) {
    var buses = [];
    var trolleybusses = [];
    makeRequst(url,
               function(result) {
                    var data = JSON.parse(result)
                    for (var i = 0; i < data.data.length; ++i) {
                        if (data.data[i]["inf"] === "{1}" && data.data[i]["sNm"].length !== 0) {
                            buses.push({shortName: data.data[i]["sNm"],
                                              name: data.data[i]["nm"],
                                              id: data.data[i]["id"]});
                        } else if (data.data[i]["inf"] === "{2}" && data.data[i]["sNm"].length !== 0) {
                            trolleybusses.push({shortName: data.data[i]["sNm"],
                                              name: data.data[i]["nm"],
                                              id: data.data[i]["id"]});
                        }
                    }
                    okCallback(buses, trolleybusses)
               },
               function(result) {
                   failCallback()
               });
}



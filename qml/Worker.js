Qt.include("API.js")

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

function updateTransportInfo(url, okCallback, failCallback) {
    var buses = []
    var trolleybusses = []
    makeRequst(url,
               function(result) {
                    var data = JSON.parse(result)
                    for (var i = 0; i < data.values.length; ++i) {
                        if (data.values[i]["inf"] === "{1}" && data.values[i]["sNm"].length !== 0) {
                            buses.push({shortName: data.values[i]["sNm"],
                                              name: data.values[i]["nm"],
                                              id: data.values[i]["id"]});
                        } else if (data.values[i]["inf"] === "{2}" && data.values[i]["sNm"].length !== 0) {
                            trolleybusses.push({shortName: data.values[i]["sNm"],
                                              name: data.values[i]["nm"],
                                              id: data.values[i]["id"]});
                        }
                    }
                    okCallback(buses, trolleybusses)
               },
               function(result) {
                   failCallback()
               });
}

function makeRequst(request, okCallback, errCallback) {
    var doc = new XMLHttpRequest()

    doc.onreadystatechange = function() {
        if (doc.readyState === XMLHttpRequest.DONE) {
            var resObj = {}
            if (doc.status == 200) {
                okCallback(doc.responseText)
            } else { // Error
                errCallback(doc.responseText)
            }
        }
    }

    doc.open("GET", request)
    doc.setRequestHeader("Cookie:", "gts.web.guid=-1")
    doc.send()
}

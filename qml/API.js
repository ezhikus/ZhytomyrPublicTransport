var testApiEndpoints = {
    transportInfoURL: "https://raw.githubusercontent.com/ezhikus/ZhytomyrPublicTransport/master/testData/2.0/1.txt",
}

var productinEndpoints = {
    transportInfoURL: "http://city.dozor.tech/data?t=1",
}

var apiEndpoints = testApiEndpoints

//////////////////////////////////////////////////////////////////////////////

function onTransportInfoError() {
     dataUpdateWorker.sendMessage({'type': 'fail'})
}

function processCurrentTransportInfo(transportInfo) {
    Settings.setCachedTransportInfo(transportInfo);
    Settings.setCachedTransportInfoHashsum(transportInfo.substring(0, 1000));

    var buses = [];
    var trolleybuses = [];
    var data = JSON.parse(transportInfo)
    for (var i = 0; i < data.data.length; ++i) {
        if (data.data[i]["inf"] === "{1}" && data.data[i]["sNm"].length !== 0) {
            buses.push({shortName: data.data[i]["sNm"],
                              name: data.data[i]["nm"][0],
                              id: data.data[i]["id"]});
        } else if (data.data[i]["inf"] === "{2}" && data.data[i]["sNm"].length !== 0) {
            trolleybuses.push({shortName: data.data[i]["sNm"],
                              name: data.data[i]["nm"][0],
                              id: data.data[i]["id"]});
        }
    }

    dataUpdateWorker.sendMessage({'type': 'clear'})
    for (var i = 0; i < buses.length; ++i) {
        dataUpdateWorker.sendMessage({
                                    'type': 'addBus',
                                    'shortName': buses[i].shortName,
                                    'name': buses[i].name,
                                    'id': buses[i].id
                                 })
    }

    for (var i = 0; i < trolleybuses.length; ++i) {
        dataUpdateWorker.sendMessage({
                                    'type': 'addTrolleybus',
                                    'shortName': trolleybuses[i].shortName,
                                    'name': trolleybuses[i].name,
                                    'id': trolleybuses[i].id
                                 })
    }

    dataUpdateWorker.sendMessage({'type': 'updateCompleted'})
}

function onHashSumReceived(hashSum) {
    var cachedHashsum = Settings.getCachedTransportInfoHashsum();
    if (cachedHashsum.length > 0 && cachedHashsum === hashSum) {
        processCurrentTransportInfo(Settings.getCachedTransportInfo());
    } else {
        fileDownloader.transportInfoReceived.connect(processCurrentTransportInfo);
        fileDownloader.transportInfoError.connect(onTransportInfoError);
        fileDownloader.getTransportInfo(API.apiEndpoints.transportInfoURL);
    }
}

function onHashSumError() {
     dataUpdateWorker.sendMessage({'type': 'fail'})
}

function updateTransportInfo() {
    fileDownloader.hashSumReceived.connect(onHashSumReceived);
    fileDownloader.hashSumError.connect(onHashSumError);
    fileDownloader.getHashsum(API.apiEndpoints.transportInfoURL);
}

//////////////////////////////////////////////////////////////////////////////


function updateRouteInfo(routeId, okCallback, failCallback) {
    routeInfoModel.clear()
    var data = JSON.parse(Settings.getCachedTransportInfo());

    for (var i = 0; i < data.data.length; ++i) {
        if (data.data[i]["id"] === routeId) {
            for (var j = 0; j < data.data[i]["zns"].length; ++j) {
                routeInfoModel.append({
                                busStopId: data.data[i]["zns"][j]["id"],
                                routeId: routeId,
                                name: data.data[i]["zns"][j]["nm"][0]
                                });
            }
        }
    }

    if (routeInfoModel.count > 0)
        okCallback();
    else
        failCallback();
}


function updateBusStopInfo(busStopParamString, okCallback, failCallback) {
    function updateBusStopInfo_(result) {
        var data = JSON.parse(result);

        for (var i = 0; i < data.values.length; ++i) {
            busStopInfo.append({
                                arrivalTime: data.values[i].arrivalIntervalTime
                             })
        }

        okCallback()
    }

    busStopInfo.clear()

    makeRequst(apiEndpoints.arrivalInfoURL + busStopParamString,
               updateBusStopInfo_,
               failCallback)
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

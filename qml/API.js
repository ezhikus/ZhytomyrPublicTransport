var testApiEndpoints = {
    transportInfoURL: "https://raw.githubusercontent.com/ezhikus/ZhytomyrPublicTransport/master/testData/TransportInfo.txt",
    busStopsGraphURL: "https://raw.githubusercontent.com/ezhikus/ZhytomyrPublicTransport/master/testData/BusStopsGraph.txt",
    routeInfoURL: "https://raw.githubusercontent.com/ezhikus/ZhytomyrPublicTransport/master/testData/RouteInfo.txt",
    arrivalInfoURL: "https://raw.githubusercontent.com/ezhikus/ZhytomyrPublicTransport/master/testData/Arrivallnfo.txt?param=",
    arrivalInfoEmptyStubURL: "https://raw.githubusercontent.com/ezhikus/ZhytomyrPublicTransport/master/testData/ArrivalnfoEmptyStub.txt?param="
}

var productinEndpoints = {
    transportInfoURL: "http://zhytomyr.dozor-gps.com.ua/get_data?type=6",
    busStopsGraphURL: "http://zhytomyr.dozor-gps.com.ua/get_data?type=11",
    routeInfoURL: "http://zhytomyr.dozor-gps.com.ua/get_data?type=7",
    arrivalInfoURL: "http://zhytomyr.dozor-gps.com.ua/get_data?type=12&param="
}

var apiEndpoints = productinEndpoints

function updateTransportInfo(okCallback, failCallback) {
    busesList.clear()
    trolleybusesList.clear()
    makeRequst(apiEndpoints.transportInfoURL,
               function(result) {
                    var data = JSON.parse(result)
                    busesList.clear()
                    trolleybusesList.clear()
                    for (var i = 0; i < data.values.length; ++i) {
                        if (data.values[i]["countDevicesGroups"] === 1 && data.values[i]["shortName"].length !== 0) {
                            busesList.append({shortName: data.values[i]["shortName"],
                                              name: data.values[i]["name"],
                                              id: data.values[i]["id"]});
                        } else if (data.values[i]["countDevicesGroups"] === 0 && data.values[i]["shortName"].length !== 0) {
                            trolleybusesList.append({shortName: data.values[i]["shortName"],
                                              name: data.values[i]["name"],
                                              id: data.values[i]["id"]});
                        }
                    }
                    okCallback()
               },
               function(result) {
                   failCallback()
               });
}

function updateRouteInfo(routeId, okCallback, failCallback) {
    function updateRoutesInfo_(result) {
        var data = JSON.parse(result);
        var routesInfo = []

        for (var i = 0; i < data.values.length; ++i) {
            routesInfo.push({
                             id: data.values[i]["id"],
                             routeId: data.values[i]["routeId"],
                             internalNumber: data.values[i]["internalNumber"],
                             name: data.values[i]["name"]
                         });
        }

        var routeInfo = []
        for (i = 0; i < routesInfo.length; ++i) {
            if (routesInfo[i].routeId !== routeId)
                continue;
            routeInfo.push(routesInfo[i]);
        }

        routeInfo.sort(function(a,b) { return a.internalNumber - b.internalNumber});
        routeInfoModel.clear();
        for (i = 0; i < routeInfo.length; ++i) {
            var paramString = ''
            if (i === 0)
                paramString = routeInfo[i].id;
            else if (i === 1)
                paramString = routeInfo[i - 1].id + '-' + routeInfo[i].id;
            else
                paramString = routeInfo[i - 2].id + '-' +routeInfo[i - 1].id + '-' + routeInfo[i].id;

            routeInfoModel.append({
                            busStopId: routeInfo[i].id,
                            routeId: routeInfo[i].routeId,
                            internalNumber: routeInfo[i].internalNumber,
                            name: routeInfo[i].name,
                            busStopParamString: paramString.toString()
                        })
        }
        okCallback();
    };

    routeInfoModel.clear()

    makeRequst(apiEndpoints.routeInfoURL,
               updateRoutesInfo_,
               failCallback);
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

    doc.open("GET", request, true)
    doc.setRequestHeader("Cookie:", "gts.web.guid=-1")
    doc.send()
}

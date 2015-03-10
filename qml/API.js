var testApiEndpoints = {
    transportInfoURL: "https://raw.githubusercontent.com/ezhikus/ZhytomyrPublicTransport/master/testData/TransportInfo.txt",
    busStopsGraphURL: "https://raw.githubusercontent.com/ezhikus/ZhytomyrPublicTransport/master/testData/BusStopsGraph.txt",
    routeInfoURL: "https://raw.githubusercontent.com/ezhikus/ZhytomyrPublicTransport/master/testData/RouteInfo.txt",
    arrivalInfoURL: "https://raw.githubusercontent.com/ezhikus/ZhytomyrPublicTransport/master/testData/Arrivallnfo.txt"
}

var productinEndpoints = {
    transportInfoURL: "http://zhytomyr.dozor-gps.com.ua/get_data?type=6",
    busStopsGraphURL: "http://zhytomyr.dozor-gps.com.ua/get_data?type=11",
    routeInfoURL: "http://zhytomyr.dozor-gps.com.ua/get_data?type=7",
    arrivalInfoURL: "http://zhytomyr.dozor-gps.com.ua/get_data?type=12&param="
}

var apiEndpoints = testApiEndpoints
var routesInfo = []
var currentRouteId = -1

function updateTransportInfo() {
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
                mainStackView.pop();
               },
               function(result) {console.log(result)})
}

function updateRouteInfo(routeId) {
    function updateCurrentRouteInfo_() {
        var tmpRouteInfo = []
        for (var i = 0; i < routesInfo.length; ++i) {
            if (routesInfo[i].routeId !== currentRouteId)
                continue;
            tmpRouteInfo.push(routesInfo[i]);
        }

        tmpRouteInfo.sort(function(a,b) { return a.internalNumber - b.internalNumber});
        routeInfo.clear();
        for (var i = 0; i < tmpRouteInfo.length; ++i) {
            routeInfo.append({
                            id: tmpRouteInfo[i].id,
                            routeId: tmpRouteInfo[i].routeId,
                            internalNumber: tmpRouteInfo[i].internalNumber,
                            name: tmpRouteInfo[i].name
                        });
        }
    };

    function updateRoutesInfo_(result) {
        var data = JSON.parse(result);
        routesInfo = [];
        for (var i = 0; i < data.values.length; ++i) {
            routesInfo.push({
                             id: data.values[i]["id"],
                             routeId: data.values[i]["routeId"],
                             internalNumber: data.values[i]["internalNumber"],
                             name: data.values[i]["name"]
                         });
        }
        updateCurrentRouteInfo_();
    };

    currentRouteId = routeId;

    if (routesInfo.length == 0) {
        makeRequst(apiEndpoints.routeInfoURL,
                   updateRoutesInfo_,
                   function(result) {console.log(result)})
    }else{
        updateCurrentRouteInfo_();
    }
}


function updateBusStopInfo() {
    busStopInfo.clear()
    busStopInfo.append({arrivalTime: 55})
    busStopInfo.append({arrivalTime: 158})
    busStopInfo.append({arrivalTime: 300})
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
    doc.setRequestHeader("gts.web.guid", "-1")
    doc.send()
}

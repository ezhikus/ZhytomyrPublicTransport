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

function updateRouteInfo() {
    routeInfo.clear()
    routeInfo.append({stopName: "Малікова"})
    routeInfo.append({stopName: "Новопівнічна"})
    routeInfo.append({stopName: "Дастор"})
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

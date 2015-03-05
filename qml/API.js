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
    busesList.clear()
    busesList.append({shortName: "37"})
    busesList.append({shortName: "40"})
    busesList.append({shortName: "53"})

    trolleybusesList.clear()
    trolleybusesList.append({shortName: "1"})
    trolleybusesList.append({shortName: "2"})
    trolleybusesList.append({shortName: "3"})
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

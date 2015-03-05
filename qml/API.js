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

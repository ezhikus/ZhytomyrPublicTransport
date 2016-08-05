
function getCachedTransportInfoSize() {
    return settings.value("CachedTransportInfoSize", 0)
}

function setCachedTransportInfoSize(size) {
    settings.setValue("CachedTransportInfoSize", size)
}

function getCachedTransportInfo() {
    return settings.value("CachedTransportInfo", "")
}

function setCachedTransportInfo(info) {
    settings.setValue("CachedTransportInfo", info)
}

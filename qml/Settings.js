
function getCachedTransportInfoHashsum() {
    return settings.value("CachedTransportInfoHashsum", "")
}

function setCachedTransportInfoHashsum(hashsum) {
    settings.setValue("CachedTransportInfoHashsum", hashsum)
}

function getCachedTransportInfo() {
    return settings.value("CachedTransportInfo", "")
}

function setCachedTransportInfo(info) {
    settings.setValue("CachedTransportInfo", info)
}

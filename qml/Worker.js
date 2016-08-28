Qt.include("API.js")
Qt.include("Settings.js")

WorkerScript.onMessage = function(message) {
     WorkerScript.sendMessage(message);
}

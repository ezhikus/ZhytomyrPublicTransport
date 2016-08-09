#include "settings.h"

Settings::~Settings() {
}

QVariant Settings::value(const QString &key, const QVariant &defaultValue = QVariant()) {
  return QSettings::value(key, defaultValue);
}

bool Settings::boolValue(const QString &key, bool defaultValue) {
  return QSettings::value(key, defaultValue).toBool();
}

void Settings::setValue(const QString &key, const QVariant &value) {

  // change the setting and emit a changed signal
  // (we are not checking if the value really changed before emitting for simplicity)
  QSettings::setValue(key, value);
  emit settingChanged(key);
}

void Settings::setValueIfNotSet(const QString &key, const QVariant &value) {

  // change the setting and emit a changed signal
  if( !QSettings::contains(key) ) {
    QSettings::setValue(key, value);
    // (we are not checking if the value really changed before emitting for simplicity)
    emit settingChanged(key);
  }
}

void Settings::initToDefaults() {
  setValueIfNotSet("test", true);
}

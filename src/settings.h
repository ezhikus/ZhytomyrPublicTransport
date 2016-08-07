#ifndef SETTINGS_H
#define SETTINGS_H

#include <QObject>
#include <QSettings>

class Settings : public QSettings {
  Q_OBJECT

public:
  Settings(const QString & organization, const QString & application = QString(), QObject * parent = 0);
  virtual ~Settings();

  Q_INVOKABLE
  void setValue(const QString &key, const QVariant &value);

  Q_INVOKABLE
  void setValueIfNotSet(const QString &key, const QVariant &value);

  Q_INVOKABLE
  QVariant value(const QString &key, const QVariant &defaultValue);

  Q_INVOKABLE
  bool boolValue(const QString &key, const bool defaultValue);

  Q_INVOKABLE
  void initToDefaults();

signals:
  void settingChanged(const QString& key);
};

#endif // SETTINGS_H

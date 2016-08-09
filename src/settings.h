#ifndef SETTINGS_H
#define SETTINGS_H

#include <QObject>
#include <QSettings>
#include <QCoreApplication>

class Settings : public QSettings {
  Q_OBJECT

public:
  explicit Settings(QObject *parent = 0) : QSettings(QSettings::UserScope,
    QCoreApplication::instance()->organizationName(), QCoreApplication::instance()->applicationName(), parent) {}

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

Q_DECLARE_METATYPE(Settings*)

#endif // SETTINGS_H

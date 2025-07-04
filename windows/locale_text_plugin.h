#ifndef FLUTTER_PLUGIN_LOCALE_TEXT_PLUGIN_H_
#define FLUTTER_PLUGIN_LOCALE_TEXT_PLUGIN_H_

#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>

#include <memory>

namespace locale_text {

class LocaleTextPlugin : public flutter::Plugin {
 public:
  static void RegisterWithRegistrar(flutter::PluginRegistrarWindows *registrar);

  LocaleTextPlugin();

  virtual ~LocaleTextPlugin();

  // Disallow copy and assign.
  LocaleTextPlugin(const LocaleTextPlugin&) = delete;
  LocaleTextPlugin& operator=(const LocaleTextPlugin&) = delete;

  // Called when a method is called on this plugin's channel from Dart.
  void HandleMethodCall(
      const flutter::MethodCall<flutter::EncodableValue> &method_call,
      std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result);
};

}  // namespace locale_text

#endif  // FLUTTER_PLUGIN_LOCALE_TEXT_PLUGIN_H_

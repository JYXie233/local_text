#include "include/locale_text/locale_text_plugin_c_api.h"

#include <flutter/plugin_registrar_windows.h>

#include "locale_text_plugin.h"

void LocaleTextPluginCApiRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar) {
  locale_text::LocaleTextPlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarManager::GetInstance()
          ->GetRegistrar<flutter::PluginRegistrarWindows>(registrar));
}

//
//  Generated file. Do not edit.
//

// clang-format off

#include "generated_plugin_registrant.h"

#include <locale_text/locale_text_plugin.h>

void fl_register_plugins(FlPluginRegistry* registry) {
  g_autoptr(FlPluginRegistrar) locale_text_registrar =
      fl_plugin_registry_get_registrar_for_plugin(registry, "LocaleTextPlugin");
  locale_text_plugin_register_with_registrar(locale_text_registrar);
}

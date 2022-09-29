
import 'map_plugin_platform_interface.dart';

class MapPlugin {
  Future<String?> getPlatformVersion() {
    return MapPluginPlatform.instance.getPlatformVersion();
  }
}

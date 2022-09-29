import 'package:flutter_test/flutter_test.dart';
import 'package:map_plugin/map_plugin.dart';
import 'package:map_plugin/map_plugin_platform_interface.dart';
import 'package:map_plugin/map_plugin_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockMapPluginPlatform
    with MockPlatformInterfaceMixin
    implements MapPluginPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final MapPluginPlatform initialPlatform = MapPluginPlatform.instance;

  test('$MethodChannelMapPlugin is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelMapPlugin>());
  });

  test('getPlatformVersion', () async {
    MapPlugin mapPlugin = MapPlugin();
    MockMapPluginPlatform fakePlatform = MockMapPluginPlatform();
    MapPluginPlatform.instance = fakePlatform;

    expect(await mapPlugin.getPlatformVersion(), '42');
  });
}

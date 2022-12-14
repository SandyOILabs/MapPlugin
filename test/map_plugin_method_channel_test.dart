import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:map_plugin/map_plugin_method_channel.dart';

void main() {
  MethodChannelMapPlugin platform = MethodChannelMapPlugin();
  const MethodChannel channel = MethodChannel('map_plugin');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.getPlatformVersion(), '42');
  });
}

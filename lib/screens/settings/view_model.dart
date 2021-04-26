import 'dart:io';

import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';
import 'package:rxdart/rxdart.dart';

class SettingsViewModel extends ChangeNotifier {
  SettingsViewModel() {
    // Get application version
    if (Platform.isIOS || Platform.isAndroid) {
      PackageInfo.fromPlatform().then((PackageInfo packageInfo) {
        _appVersion.add('${packageInfo.version}(${packageInfo.buildNumber})');
      });
    } else {
      _appVersion.add('0.0.1');
    }
  }

  // Applications version Stream
  final _appVersion = BehaviorSubject<String>.seeded('');
  Stream<String> get getAppVersion => _appVersion.stream;
}

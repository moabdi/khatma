import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class DeviceInfoService {
  static final DeviceInfoService _instance = DeviceInfoService._internal();
  factory DeviceInfoService() => _instance;
  DeviceInfoService._internal();

  final DeviceInfoPlugin _deviceInfoPlugin = DeviceInfoPlugin();

  PackageInfo? _packageInfo;
  DeviceInformation? _cachedDeviceInfo;
  DateTime? _cacheTimestamp;

  static const Duration _cacheDuration = Duration(minutes: 5);

  Future<DeviceInformation> getDeviceInfo({
    bool useCache = true,
    bool includeSensitiveInfo = false,
    BuildContext? context,
  }) async {
    if (useCache && _cachedDeviceInfo != null && _isCacheValid()) {
      return _cachedDeviceInfo!;
    }

    try {
      _packageInfo ??= await PackageInfo.fromPlatform();

      late DeviceInformation deviceInfo;

      if (kIsWeb) {
        deviceInfo = await _getWebInfo(includeSensitiveInfo);
      } else if (Platform.isAndroid) {
        deviceInfo = await _getAndroidInfo(includeSensitiveInfo);
      } else if (Platform.isIOS) {
        deviceInfo = await _getIOSInfo(includeSensitiveInfo);
      } else if (Platform.isMacOS) {
        deviceInfo = await _getMacOSInfo(includeSensitiveInfo);
      } else if (Platform.isWindows) {
        deviceInfo = await _getWindowsInfo(includeSensitiveInfo);
      } else if (Platform.isLinux) {
        deviceInfo = await _getLinuxInfo(includeSensitiveInfo);
      } else {
        deviceInfo = _getFallbackInfo();
      }

      // enrich with screen + network info if context is available
      if (context != null) {
        final mq = MediaQuery.of(context);
        deviceInfo = deviceInfo.copyWith(additionalInfo: {
          ...deviceInfo.additionalInfo,
          'screenWidth': mq.size.width.toStringAsFixed(1),
          'screenHeight': mq.size.height.toStringAsFixed(1),
          'devicePixelRatio': mq.devicePixelRatio.toStringAsFixed(2),
          'orientation': mq.orientation.toString(),
        });
      }

      final connectivityResult = await Connectivity().checkConnectivity();
      deviceInfo = deviceInfo.copyWith(additionalInfo: {
        ...deviceInfo.additionalInfo,
        'networkStatus': connectivityResult.toString(),
      });

      if (useCache) {
        _cachedDeviceInfo = deviceInfo;
        _cacheTimestamp = DateTime.now();
      }

      return deviceInfo;
    } catch (e, stackTrace) {
      debugPrint('Error getting device info: $e');
      debugPrint('Stack trace: $stackTrace');
      return _getFallbackInfo();
    }
  }

  bool _isCacheValid() {
    if (_cacheTimestamp == null) return false;
    return DateTime.now().difference(_cacheTimestamp!) < _cacheDuration;
  }

  Future<DeviceInformation> _getWebInfo(bool includeSensitiveInfo) async {
    final webInfo = await _deviceInfoPlugin.webBrowserInfo;

    return DeviceInformation(
      platform: 'Web',
      deviceModel:
          '${webInfo.browserName} ${webInfo.appVersion?.split(' ').first ?? ''}',
      osVersion: webInfo.platform ?? 'Unknown',
      appVersion: _packageInfo!.version,
      buildNumber: _packageInfo!.buildNumber,
      appName: _packageInfo!.appName,
      isPhysicalDevice: false,
      locale: _getSafeLocale(),
      flutterVersion: _getFlutterVersion(),
      dartVersion: _getDartVersion(),
      flutterSdkVersion: _getFlutterSdkVersion(),
      timeZone: _getTimezone(),
      additionalInfo: {
        'browser': webInfo.browserName.name,
        'userAgent': includeSensitiveInfo
            ? (webInfo.userAgent ?? 'Unknown')
            : '[Hidden for privacy]',
      },
    );
  }

  Future<DeviceInformation> _getAndroidInfo(bool includeSensitiveInfo) async {
    final androidInfo = await _deviceInfoPlugin.androidInfo;

    return DeviceInformation(
      platform: 'Android',
      deviceModel: '${androidInfo.brand} ${androidInfo.model}',
      osVersion:
          'Android ${androidInfo.version.release} (API ${androidInfo.version.sdkInt})',
      appVersion: _packageInfo!.version,
      buildNumber: _packageInfo!.buildNumber,
      appName: _packageInfo!.appName,
      isPhysicalDevice: androidInfo.isPhysicalDevice,
      locale: _getSafeLocale(),
      flutterVersion: _getFlutterVersion(),
      dartVersion: _getDartVersion(),
      flutterSdkVersion: _getFlutterSdkVersion(),
      timeZone: _getTimezone(),
      additionalInfo: {
        'manufacturer': androidInfo.manufacturer,
        'androidId':
            includeSensitiveInfo ? androidInfo.id : '[Hidden for privacy]',
        'securityPatch': androidInfo.version.securityPatch ?? 'Unknown',
      },
    );
  }

  Future<DeviceInformation> _getIOSInfo(bool includeSensitiveInfo) async {
    final iosInfo = await _deviceInfoPlugin.iosInfo;

    return DeviceInformation(
      platform: 'iOS',
      deviceModel: iosInfo.model,
      osVersion: '${iosInfo.systemName} ${iosInfo.systemVersion}',
      appVersion: _packageInfo!.version,
      buildNumber: _packageInfo!.buildNumber,
      appName: _packageInfo!.appName,
      isPhysicalDevice: iosInfo.isPhysicalDevice,
      locale: _getSafeLocale(),
      flutterVersion: _getFlutterVersion(),
      dartVersion: _getDartVersion(),
      flutterSdkVersion: _getFlutterSdkVersion(),
      timeZone: _getTimezone(),
      additionalInfo: {
        'deviceName':
            includeSensitiveInfo ? iosInfo.name : '[Hidden for privacy]',
        'localizedModel': iosInfo.localizedModel,
        'identifierForVendor': includeSensitiveInfo
            ? (iosInfo.identifierForVendor ?? 'Unknown')
            : '[Hidden for privacy]',
        'systemInfo': iosInfo.utsname.machine,
      },
    );
  }

  Future<DeviceInformation> _getMacOSInfo(bool includeSensitiveInfo) async {
    final macInfo = await _deviceInfoPlugin.macOsInfo;

    return DeviceInformation(
      platform: 'macOS',
      deviceModel: macInfo.model,
      osVersion:
          '${macInfo.majorVersion}.${macInfo.minorVersion}.${macInfo.patchVersion}',
      appVersion: _packageInfo!.version,
      buildNumber: _packageInfo!.buildNumber,
      appName: _packageInfo!.appName,
      isPhysicalDevice: true,
      locale: _getSafeLocale(),
      flutterVersion: _getFlutterVersion(),
      dartVersion: _getDartVersion(),
      flutterSdkVersion: _getFlutterSdkVersion(),
      timeZone: _getTimezone(),
      additionalInfo: {
        'computerName': includeSensitiveInfo
            ? macInfo.computerName
            : '[Hidden for privacy]',
        'arch': macInfo.arch,
        'activeCPUs': macInfo.activeCPUs.toString(),
        'memorySize':
            '${(macInfo.memorySize / (1024 * 1024 * 1024)).toStringAsFixed(1)} GB',
      },
    );
  }

  Future<DeviceInformation> _getWindowsInfo(bool includeSensitiveInfo) async {
    final windowsInfo = await _deviceInfoPlugin.windowsInfo;

    return DeviceInformation(
      platform: 'Windows',
      deviceModel:
          includeSensitiveInfo ? windowsInfo.computerName : 'Windows PC',
      osVersion:
          'Windows ${windowsInfo.displayVersion} (Build ${windowsInfo.buildNumber})',
      appVersion: _packageInfo!.version,
      buildNumber: _packageInfo!.buildNumber,
      appName: _packageInfo!.appName,
      isPhysicalDevice: true,
      locale: _getSafeLocale(),
      flutterVersion: _getFlutterVersion(),
      dartVersion: _getDartVersion(),
      flutterSdkVersion: _getFlutterSdkVersion(),
      timeZone: _getTimezone(),
      additionalInfo: {
        'userName': includeSensitiveInfo
            ? windowsInfo.userName
            : '[Hidden for privacy]',
        'numberOfCores': windowsInfo.numberOfCores.toString(),
        'systemMemory':
            '${(windowsInfo.systemMemoryInMegabytes / 1024).toStringAsFixed(1)} GB',
        'productName': windowsInfo.productName,
      },
    );
  }

  Future<DeviceInformation> _getLinuxInfo(bool includeSensitiveInfo) async {
    final linuxInfo = await _deviceInfoPlugin.linuxInfo;

    return DeviceInformation(
      platform: 'Linux',
      deviceModel: linuxInfo.prettyName,
      osVersion: '${linuxInfo.name} ${linuxInfo.version ?? ''}',
      appVersion: _packageInfo!.version,
      buildNumber: _packageInfo!.buildNumber,
      appName: _packageInfo!.appName,
      isPhysicalDevice: true,
      locale: _getSafeLocale(),
      flutterVersion: _getFlutterVersion(),
      dartVersion: _getDartVersion(),
      flutterSdkVersion: _getFlutterSdkVersion(),
      timeZone: _getTimezone(),
      additionalInfo: {
        'distribution': linuxInfo.id,
        'versionCodename': linuxInfo.versionCodename ?? 'Unknown',
        'machineId': includeSensitiveInfo
            ? (linuxInfo.machineId ?? 'Unknown')
            : '[Hidden for privacy]',
      },
    );
  }

  DeviceInformation _getFallbackInfo() {
    return DeviceInformation(
      platform: 'Unknown',
      deviceModel: 'Unknown Device',
      osVersion: 'Unknown OS',
      appVersion: _packageInfo?.version ?? 'Unknown',
      buildNumber: _packageInfo?.buildNumber ?? 'Unknown',
      appName: _packageInfo?.appName ?? 'Unknown App',
      isPhysicalDevice: true,
      locale: _getSafeLocale(),
      flutterVersion: _getFlutterVersion(),
      dartVersion: _getDartVersion(),
      flutterSdkVersion: _getFlutterSdkVersion(),
      timeZone: _getTimezone(),
      additionalInfo: {},
    );
  }

  String _getSafeLocale() {
    try {
      return Platform.localeName;
    } catch (e) {
      return 'Unknown';
    }
  }

  String _getFlutterVersion() {
    return kDebugMode
        ? 'Debug Mode'
        : kProfileMode
            ? 'Profile Mode'
            : 'Release Mode';
  }

  String _getDartVersion() => Platform.version.split(" ").first;
  String _getFlutterSdkVersion() =>
      const String.fromEnvironment("FLUTTER_VERSION", defaultValue: "Unknown");

  String _getTimezone() {
    final now = DateTime.now();
    return "${now.timeZoneName} (UTC${now.timeZoneOffset.inHours})";
  }

  void clearCache() {
    _cachedDeviceInfo = null;
    _cacheTimestamp = null;
  }

  Future<Map<String, dynamic>> reportError(
    Object error,
    StackTrace stack, {
    bool includeSensitive = false,
    BuildContext? context,
  }) async {
    final deviceInfo = await getDeviceInfo(
      includeSensitiveInfo: includeSensitive,
      context: context,
    );

    return {
      'error': error.toString(),
      'stacktrace': stack.toString(),
      'deviceInfo': deviceInfo.toJson(),
    };
  }

  bool get isCacheValid => _isCacheValid();
  DateTime? get cacheTimestamp => _cacheTimestamp;
}

class DeviceInformation {
  final String platform;
  final String deviceModel;
  final String osVersion;
  final String appVersion;
  final String buildNumber;
  final String appName;
  final bool isPhysicalDevice;
  final String locale;
  final String flutterVersion;
  final String dartVersion;
  final String flutterSdkVersion;
  final String timeZone;
  final Map<String, String> additionalInfo;

  const DeviceInformation({
    required this.platform,
    required this.deviceModel,
    required this.osVersion,
    required this.appVersion,
    required this.buildNumber,
    required this.appName,
    required this.isPhysicalDevice,
    required this.locale,
    required this.flutterVersion,
    required this.dartVersion,
    required this.flutterSdkVersion,
    required this.timeZone,
    required this.additionalInfo,
  });

  DeviceInformation copyWith({
    Map<String, String>? additionalInfo,
  }) {
    return DeviceInformation(
      platform: platform,
      deviceModel: deviceModel,
      osVersion: osVersion,
      appVersion: appVersion,
      buildNumber: buildNumber,
      appName: appName,
      isPhysicalDevice: isPhysicalDevice,
      locale: locale,
      flutterVersion: flutterVersion,
      dartVersion: dartVersion,
      flutterSdkVersion: flutterSdkVersion,
      timeZone: timeZone,
      additionalInfo: additionalInfo ?? this.additionalInfo,
    );
  }

  String toSupportString() {
    final buffer = StringBuffer();

    buffer.writeln('Bug Report Details:');
    buffer.writeln('- Platform: $platform');
    buffer.writeln('- Device: $deviceModel');
    buffer.writeln('- OS Version: $osVersion');
    buffer.writeln(
        '- Physical Device: ${isPhysicalDevice ? 'Yes' : 'No (Emulator/Simulator)'}');
    buffer.writeln('- Locale: $locale');
    buffer.writeln('- Timezone: $timeZone');
    buffer.writeln('- App Name: $appName');
    buffer.writeln('- Version: $appVersion');
    buffer.writeln('- Build: $buildNumber');
    buffer.writeln('- Flutter Mode: $flutterVersion');
    buffer.writeln('- Dart Version: $dartVersion');
    buffer.writeln('- Flutter SDK Version: $flutterSdkVersion');
    if (additionalInfo.isNotEmpty) {
      additionalInfo.forEach((key, value) {
        buffer.writeln('- $key: $value');
      });
      buffer.writeln();
    }

    buffer.writeln('- Generated: ${DateTime.now().toIso8601String()}');

    return buffer.toString();
  }

  Map<String, dynamic> toJson() {
    return {
      'platform': platform,
      'deviceModel': deviceModel,
      'osVersion': osVersion,
      'appVersion': appVersion,
      'buildNumber': buildNumber,
      'appName': appName,
      'isPhysicalDevice': isPhysicalDevice,
      'locale': locale,
      'flutterVersion': flutterVersion,
      'dartVersion': dartVersion,
      'flutterSdkVersion': flutterSdkVersion,
      'timeZone': timeZone,
      'additionalInfo': additionalInfo,
      'timestamp': DateTime.now().toIso8601String(),
    };
  }
}

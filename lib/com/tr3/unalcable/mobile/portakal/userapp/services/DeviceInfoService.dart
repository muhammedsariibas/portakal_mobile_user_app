import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';

class DeviceInfoService {
  final DeviceInfoPlugin _deviceInfoPlugin = DeviceInfoPlugin();

  Future<Map<String, dynamic>> getDeviceInfo() async {
    Map<String, dynamic> deviceData = <String, dynamic>{};

    try {
      if (Platform.isAndroid) {
        AndroidDeviceInfo androidInfo = await _deviceInfoPlugin.androidInfo;
        deviceData['platform'] = 'Android';
        deviceData['id'] = androidInfo.id; // Android ID
        // Diğer istenilen bilgileri ekleyin
      } else if (Platform.isIOS) {
        IosDeviceInfo iosInfo = await _deviceInfoPlugin.iosInfo;
        deviceData['platform'] = 'iOS';
        deviceData['id'] = iosInfo.identifierForVendor; // iOS ID
        // Diğer istenilen bilgileri ekleyin
      }
    } catch (e) {
      print('Cihaz bilgisi alınırken hata: $e');
    }

    return deviceData;
  }


}

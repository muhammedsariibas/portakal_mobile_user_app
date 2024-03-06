import 'dart:math';

import 'package:grock/grock.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:portakal_mobile_user_app/com/tr3/unalcable/mobile/portakal/userapp/services/NotificationService.dart';
import 'package:portakal_mobile_user_app/com/tr3/unalcable/mobile/portakal/userapp/services/RestApiService.dart';
import 'package:url_launcher/url_launcher.dart';

class PackageInfoService {
  static final PackageInfoService _instance = PackageInfoService._internal();
  late PackageInfo _packageInfo;
  RestApiService restApiService = RestApiService();
  NotificationService notificationService = NotificationService();

  PackageInfoService._internal();

  factory PackageInfoService() {
    return _instance;
  }

  Future<void> init() async {
    _packageInfo = await PackageInfo.fromPlatform();
    isUpdateRequired();
  }

  String get version => _packageInfo.version;
  String get buildNumber => _packageInfo.buildNumber;
  String get packageName => _packageInfo.packageName;
  String get appName => _packageInfo.appName;
  String get buildSignature => _packageInfo.buildSignature;

  void _launchURL(Uri uri) async {
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $uri';
    }
  }

  Future<bool> isUpdateRequired() async {


    
    // var resp =
    //     await restApiService.post('/check-version', {'version': version});

    // if (resp['isUpdateRequired']) {
    //   notificationService.makeDialog(
    //       "Bildirim",
    //       "Bildirim geldi",
    //       "iptal",
    //       () {
    //         Grock.back();
    //       },
    //       "güncelle",
    //       () {
    //         _launchURL(Uri.parse(
    //             'https://play.google.com/store/apps/details?id=com.instagram.android'));
    //       });
    //   return true;
    // } else {
    //   return false;
    // }

    return true;
  }
}

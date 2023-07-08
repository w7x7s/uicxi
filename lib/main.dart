import 'package:flutter/material.dart';

import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:uicxi/home.dart';

void main() async {
  List<String>? devices = ["d6b3a49d-a702-4d7b-99fc-04a0998fbc86"];
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  RequestConfiguration requestConfiguration =
      RequestConfiguration(testDeviceIds: devices);
  MobileAds.instance.updateRequestConfiguration(requestConfiguration);
// print(MobileAds.instance.)
  runApp(MyApp());
}

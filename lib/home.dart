import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:connectivity/connectivity.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _messengerKey = GlobalKey<ScaffoldMessengerState>();

  late BannerAd _bannerAd;
  late InterstitialAd _interstitialAd;
  bool _isBannerAdReady = false;
  bool _isInterstitialAdReady = false;
  var bannerAdUnitId = "ca-app-pub-3940256099942544/6300978111";
  var interstitialAdUnitId = "ca-app-pub-3940256099942544/1033173712";
  var code = '''
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'dart:io';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late BannerAd _bannerAd;
  late InterstitialAd _interstitialAd;
  bool _isBannerAdReady = false;
  bool _isInterstitialAdReady = false;
  var bannerAdUnitId = "ca-app-pub-3940256099942544/6300978111";
  var interstitialAdUnitId = "ca-app-pub-3940256099942544/1033173712";
  var code = 'Put your code here';

  @override
  void initState() {
    super.initState();
    _loadBannerAd();
    _loadInterstitialAd();
  }

  void _loadBannerAd() {
    _bannerAd = BannerAd(
      adUnitId: bannerAdUnitId, // Use your test ad unit id here
      size: AdSize.banner,
      request: AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (_) {
          setState(() {
            _isBannerAdReady = true;
          });
        },
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
        },
      ),
    );

    _bannerAd.load();
  }

  void _loadInterstitialAd() {
    InterstitialAd.load(
      adUnitId: interstitialAdUnitId, // Use your test ad unit id here
      request: AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (InterstitialAd ad) {
          setState(() {
            _interstitialAd = ad;
            _isInterstitialAdReady = true;
          });
        },
        onAdFailedToLoad: (LoadAdError error) {
          print('InterstitialAd failed to load: \$error');
        },
      ),
    );
  }

  void _copyCodeToClipboard(String code) {
    Clipboard.setData(ClipboardData(text: code));
    _messengerKey.currentState!.showSnackBar(SnackBar(content: Text('Code copied')));

    if (_isInterstitialAdReady) {
      _interstitialAd.show();
      _loadInterstitialAd();
    }
  }

  Future<bool> _isConnectedToInternet() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    return connectivityResult != ConnectivityResult.none;
  }

  @override
  void dispose() {
    _bannerAd.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('AdMob Example'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (_isBannerAdReady)
                Container(
                  width: _bannerAd.size.width.toDouble(),
                  height: _bannerAd.size.height.toDouble(),
                  child: AdWidget(ad: _bannerAd),
                ),
              if (!_isBannerAdReady)
                CircularProgressIndicator(),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: _isBannerAdReady
                    ? () async {
                        bool isConnected = await _isConnectedToInternet();
                        if (isConnected) {
                          _copyCodeToClipboard(code);
                        } else {
                          _messengerKey.currentState!.showSnackBar(
                              SnackBar(content: Text('No internet connection')));
                        }
                      }
                    : null,
                child: Text('Copy Code'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
''';

  @override
  void initState() {
    super.initState();
    _loadBannerAd();
    _loadInterstitialAd();
  }

  void _loadBannerAd() {
    _bannerAd = BannerAd(
      adUnitId: bannerAdUnitId,
      size: AdSize.banner,
      request: AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (_) {
          setState(() {
            _isBannerAdReady = true;
          });
        },
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
        },
      ),
    );

    _bannerAd.load();
  }

  void _loadInterstitialAd() {
    InterstitialAd.load(
      adUnitId: interstitialAdUnitId,
      request: AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (InterstitialAd ad) {
          setState(() {
            _interstitialAd = ad;
            _isInterstitialAdReady = true;
          });
        },
        onAdFailedToLoad: (LoadAdError error) {
          print('InterstitialAd failed to load: $error');
        },
      ),
    );
  }

  void _copyCodeToClipboard(String code) {
    _messengerKey.currentState!
        .showSnackBar(SnackBar(content: Text('Code copied')));

    if (_isInterstitialAdReady) {
      _interstitialAd.show();
      _loadInterstitialAd();
      Clipboard.setData(ClipboardData(text: code));
    }
  }

  Future<bool> _isConnectedToInternet() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    return connectivityResult != ConnectivityResult.none;
  }

  @override
  void dispose() {
    _bannerAd.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scaffoldMessengerKey: _messengerKey,
      home: Scaffold(
        appBar: AppBar(
          title: Text('AdMob Example'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (_isBannerAdReady)
                Container(
                  width: _bannerAd.size.width.toDouble(),
                  height: _bannerAd.size.height.toDouble(),
                  child: AdWidget(ad: _bannerAd),
                ),
              if (!_isBannerAdReady) CircularProgressIndicator(),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: _isBannerAdReady
                    ? () async {
                        bool isConnected = await _isConnectedToInternet();
                        if (isConnected) {
                          _copyCodeToClipboard(code);
                        } else {
                          _messengerKey.currentState!.showSnackBar(SnackBar(
                              content: Text('No internet connection')));
                        }
                      }
                    : null,
                child: Text('Copy Code'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

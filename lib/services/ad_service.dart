import 'package:flutter/foundation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class PotioAdService {
  static bool _initialised = false;

  static Future<void> initialise() async {
    if (kIsWeb || _initialised) {
      return;
    }

    await MobileAds.instance.initialize();
    _initialised = true;
  }

  static String get bannerAdUnitId {
    // Test banner ad unit. Replace before production release.
    return 'ca-app-pub-3940256099942544/6300978111';
  }

  static String get interstitialAdUnitId {
    // Test interstitial ad unit. Replace before production release.
    return 'ca-app-pub-3940256099942544/1033173712';
  }
}

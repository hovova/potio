import 'package:flutter/foundation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'ad_service.dart';

class PotioInterstitialAdService {
  static InterstitialAd? _interstitialAd;
  static bool _isLoading = false;

  static Future<void> preloadInterstitialAd() async {
    if (kIsWeb || _isLoading || _interstitialAd != null) {
      return;
    }

    _isLoading = true;

    await PotioAdService.initialise();

    InterstitialAd.load(
      adUnitId: PotioAdService.interstitialAdUnitId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          _isLoading = false;
          _interstitialAd = ad;
        },
        onAdFailedToLoad: (_) {
          _isLoading = false;
          _interstitialAd = null;
        },
      ),
    );
  }

  static Future<void> showIfAvailable({required bool adsRemoved}) async {
    if (kIsWeb || adsRemoved) {
      return;
    }

    final ad = _interstitialAd;
    if (ad == null) {
      await preloadInterstitialAd();
      return;
    }

    _interstitialAd = null;
    ad.fullScreenContentCallback = FullScreenContentCallback(
      onAdDismissedFullScreenContent: (ad) {
        ad.dispose();
        preloadInterstitialAd();
      },
      onAdFailedToShowFullScreenContent: (ad, _) {
        ad.dispose();
        preloadInterstitialAd();
      },
    );

    await ad.show();
  }
}

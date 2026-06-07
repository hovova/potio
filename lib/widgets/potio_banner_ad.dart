import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../services/ad_service.dart';

class PotioBannerAd extends StatefulWidget {
  final bool adsRemoved;

  const PotioBannerAd({
    super.key,
    required this.adsRemoved,
  });

  @override
  State<PotioBannerAd> createState() => _PotioBannerAdState();
}

class _PotioBannerAdState extends State<PotioBannerAd> {
  BannerAd? bannerAd;
  bool isLoaded = false;

  @override
  void initState() {
    super.initState();
    loadAd();
  }

  Future<void> loadAd() async {
    if (kIsWeb || widget.adsRemoved) {
      return;
    }

    await PotioAdService.initialise();

    final ad = BannerAd(
      adUnitId: PotioAdService.bannerAdUnitId,
      size: AdSize.banner,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          if (!mounted) {
            ad.dispose();
            return;
          }
          setState(() {
            bannerAd = ad as BannerAd;
            isLoaded = true;
          });
        },
        onAdFailedToLoad: (ad, _) {
          ad.dispose();
        },
      ),
    );

    await ad.load();
  }

  @override
  void dispose() {
    bannerAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.adsRemoved || !isLoaded || bannerAd == null) {
      return const SizedBox.shrink();
    }

    return SizedBox(
      width: bannerAd!.size.width.toDouble(),
      height: bannerAd!.size.height.toDouble(),
      child: AdWidget(ad: bannerAd!),
    );
  }
}

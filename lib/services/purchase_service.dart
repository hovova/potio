import 'dart:async';

import 'package:in_app_purchase/in_app_purchase.dart';

class PotioPurchaseIds {
  static const String noAds = 'potio_no_ads';
  static const String premium = 'potio_premium';
}

class PotioPurchaseService {
  final InAppPurchase _inAppPurchase = InAppPurchase.instance;

  Stream<List<PurchaseDetails>> get purchaseStream {
    return _inAppPurchase.purchaseStream;
  }

  Future<bool> isAvailable() async {
    return _inAppPurchase.isAvailable();
  }

  Future<ProductDetailsResponse> loadProducts() async {
    return _inAppPurchase.queryProductDetails({
      PotioPurchaseIds.noAds,
      PotioPurchaseIds.premium,
    });
  }

  Future<void> buyProduct(ProductDetails product) async {
    final param = PurchaseParam(productDetails: product);
    await _inAppPurchase.buyNonConsumable(purchaseParam: param);
  }

  Future<void> restorePurchases() async {
    await _inAppPurchase.restorePurchases();
  }

  Future<void> completePurchase(PurchaseDetails purchaseDetails) async {
    if (purchaseDetails.pendingCompletePurchase) {
      await _inAppPurchase.completePurchase(purchaseDetails);
    }
  }
}

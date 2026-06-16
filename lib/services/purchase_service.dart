import 'dart:async';
import 'package:flutter/foundation.dart'; 
import 'package:in_app_purchase/in_app_purchase.dart';

class PotioPurchaseIds {
  static const String noAds = 'potio_no_ads';
  static const String premium = 'potio_premium';
}

class PotioPurchaseService {
  PotioPurchaseService._() {

    if (!kIsWeb) {
      _subscription = InAppPurchase.instance.purchaseStream.listen(
        _onPurchaseUpdate,
        onDone: () => _subscription?.cancel(),
        onError: (error) => debugPrint('Purchase stream error: $error'),
      );
    }
  }

  static final PotioPurchaseService instance = PotioPurchaseService._();

  StreamSubscription<List<PurchaseDetails>>? _subscription;

  final ValueNotifier<bool> isPremium = ValueNotifier<bool>(false);
  final ValueNotifier<bool> isNoAds = ValueNotifier<bool>(false);

  void _onPurchaseUpdate(List<PurchaseDetails> purchaseDetailsList) {
    for (var purchase in purchaseDetailsList) {
      if (purchase.status == PurchaseStatus.purchased || 
          purchase.status == PurchaseStatus.restored) {
        
        if (purchase.productID == PotioPurchaseIds.premium) {
          isPremium.value = true;
        } else if (purchase.productID == PotioPurchaseIds.noAds) {
          isNoAds.value = true;
        }

        if (purchase.pendingCompletePurchase) {
          InAppPurchase.instance.completePurchase(purchase);
        }
      }
    }
  }


  void debugUnlockPremium() {
    isPremium.value = true;
    isNoAds.value = true;
  }

  Future<bool> isAvailable() async {
    if (kIsWeb) return false;
    return InAppPurchase.instance.isAvailable();
  }

  Future<ProductDetailsResponse> loadProducts() async {
    if (kIsWeb) {

      return ProductDetailsResponse(productDetails: [], notFoundIDs: []);
    }
    return InAppPurchase.instance.queryProductDetails({
      PotioPurchaseIds.noAds,
      PotioPurchaseIds.premium,
    });
  }

  Future<void> buyProduct(ProductDetails product) async {
    if (kIsWeb) {
      debugPrint('Purchases not supported on Web. Faking purchase for testing!');
      debugUnlockPremium(); 
      return;
    }
    
    final param = PurchaseParam(productDetails: product);
    await InAppPurchase.instance.buyNonConsumable(purchaseParam: param);
  }

  Future<void> restorePurchases() async {
    if (kIsWeb) return;
    await InAppPurchase.instance.restorePurchases();
  }
}
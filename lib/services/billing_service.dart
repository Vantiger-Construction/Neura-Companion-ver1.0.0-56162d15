import 'package:in_app_purchase/in_app_purchase.dart';
import 'dart:async';
import 'package:flutter/material.dart';

class BillingService {
  final InAppPurchase _iap = InAppPurchase.instance;

  /// Initializes connection to the billing service.
  Future<void> init() async {
    try {
      final available = await _iap.isAvailable();
      if (!available) {
        debugPrint('💥 Neura says: In-app purchases not available');
        return;
      }
      // TODO: load past purchases, listen to purchase updates
    } catch (e) {
      debugPrint('💥 Neura says: Init error: $e');
      rethrow;
    }
  }

  /// Fetches product details for subscription tiers.
  Future<List<ProductDetails>> fetchProducts(List<String> ids) async {
    try {
      final response = await _iap.queryProductDetails(ids.toSet());
      return response.productDetails;
    } catch (e) {
      debugPrint('💥 Neura says: Fetch products error: $e');
      rethrow;
    }
  }

  /// Starts purchase process for a product.
  Future<void> purchase(ProductDetails product) async {
    try {
      final purchaseParam = PurchaseParam(productDetails: product);
      await _iap.buyNonConsumable(purchaseParam: purchaseParam);
    } catch (e) {
      debugPrint('💥 Neura says: Purchase error: $e');
      rethrow;
    }
  }

  /// Restores previous purchases.
  Future<void> restorePurchases() async {
    try {
      await _iap.restorePurchases();
    } catch (e) {
      debugPrint('💥 Neura says: Restore purchases error: $e');
      rethrow;
    }
  }
}

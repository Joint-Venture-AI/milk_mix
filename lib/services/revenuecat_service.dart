// ignore_for_file: avoid_print, deprecated_member_use

import 'package:milk_mix/store_config.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:get/get.dart';
import '../controllers/profile_controller.dart';

class RevenueCatService {
  static Future<void> initialize() async {
    await Purchases.setLogLevel(LogLevel.debug);

    final configuration = PurchasesConfiguration(StoreConfig.instance.apiKey)
      ..purchasesAreCompletedBy = const PurchasesAreCompletedByRevenueCat();

    await Purchases.configure(configuration);

    final profileController = Get.find<ProfileController>();
    final userId = profileController.userId.value;

    if (userId == null) {
      print('[RevenueCat] Anonymous mode - no user ID');
      return;
    }

    final currentUser = await Purchases.appUserID;
    if (currentUser != userId.toString()) {
      print('[RevenueCat] Anonymous user: $currentUser');
      final result = await Purchases.logIn(userId.toString());
      print(
        '[RevenueCat] Logged in as: ${result.created ? "new" : "existing"} user',
      );
    }

    print('[RevenueCat] Configured for user: ${await Purchases.appUserID}');
  }

  static Future<void> restorePurchases() async {
    try {
      final info = await Purchases.restorePurchases();
      print('[RevenueCat] Restored purchases: ${info.entitlements.active}');
    } catch (e) {
      print('[RevenueCat] Error restoring purchases: $e');
    }
  }

  static Future<CustomerInfo?> getCustomerInfo() async {
    try {
      return await Purchases.getCustomerInfo();
    } catch (e) {
      print('[RevenueCat] Failed to get customer info: $e');
      return null;
    }
  }

  static Future<void> purchaseDefaultPackage() async {
    try {
      final offerings = await Purchases.getOfferings();

      if (offerings.current == null) {
        print('[RevenueCat] No offerings found');
        return;
      }

      final package = offerings.current!.availablePackages.first;
      final purchaseResult = await Purchases.purchasePackage(package);

      if (purchaseResult.customerInfo.entitlements.active.isNotEmpty) {
        print('[RevenueCat] Purchase successful');
      }
    } catch (e) {
      print('[RevenueCat] Purchase failed: $e');
    }
  }

  static Future<void> purchasePackage(String offeringId) async {
    try {
      final offerings = await Purchases.getOfferings();
      print('[RevenueCat] Offerings: ${offerings.all.keys.map((k) => k)}');
      final allOfferings = offerings.all;

      if (allOfferings.containsKey(offeringId)) {
        final package = allOfferings[offeringId]!.availablePackages.first;
        await Purchases.purchasePackage(package);
        print('[RevenueCat] Purchase complete for $offeringId');
      }
    } catch (e) {
      print('[RevenueCat] Purchase failed: $e');
    }
  }

  static Future<bool> hasEntitlement(String entitlementId) async {
    final info = await getCustomerInfo();
    print(
      '[RevenueCat] Entitlements: ${info?.entitlements.all.values.map((k) => '${k.identifier}: ${k.isActive}').join(', ')}',
    );
    return info?.entitlements.all[entitlementId]?.isActive ?? false;
  }
}

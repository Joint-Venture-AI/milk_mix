import 'package:get/get.dart';
import '../services/revenuecat_service.dart';

class SubscriptionController extends GetxController {
  var hasIndividualAccess = false.obs;
  var hasAddMemberAccess = false.obs;

  Future<void> checkSubscriptionStatus() async {
    hasIndividualAccess.value = await RevenueCatService.hasEntitlement(
      'individual_access',
    );

    hasAddMemberAccess.value = await RevenueCatService.hasEntitlement(
      'add_member_access',
    );

    print(
      '[RevenueCat] hasIndividualAccess: ${hasIndividualAccess.value}, hasAddMemberAccess: ${hasAddMemberAccess.value}',
    );
  }

  Future<void> purchaseDefaultPlan() async {
    await RevenueCatService.purchaseDefaultPackage();
    await checkSubscriptionStatus();
  }

  Future<void> purchaseIndividualPlan() async {
    await RevenueCatService.purchasePackage('default');
    await checkSubscriptionStatus();
  }

  Future<void> purchaseAddMemberPlan() async {
    await RevenueCatService.purchasePackage('add_members_offering');
    await checkSubscriptionStatus();
  }
}

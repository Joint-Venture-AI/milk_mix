import 'package:get/get.dart';
import 'package:milk_mix/controllers/profile_controller.dart';
import 'package:milk_mix/data_source/api/client/trial_storage.dart';
import '../services/revenuecat_service.dart';

class SubscriptionController extends GetxController {
  var hasIndividualAccess = false.obs;
  var hasAddMemberAccess = false.obs;
  var hasConsultantAccess = false.obs;
  var isTrialAccess = false.obs;
  var hasAcknowledgedTrial = false.obs;

  Future<void> checkSubscriptionStatus() async {
    hasAcknowledgedTrial.value = await TrialStorage.isTrialAcknowledged();

    hasIndividualAccess.value = await RevenueCatService.hasEntitlement(
      'individual_access',
    );

    hasAddMemberAccess.value = await RevenueCatService.hasEntitlement(
      'add_member_access',
    );

    hasConsultantAccess.value = await RevenueCatService.hasEntitlement(
      'consultant_access',
    );

    print(
      '[RevenueCat] hasIndividualAccess: ${hasIndividualAccess.value}, hasAddMemberAccess: ${hasAddMemberAccess.value}',
    );

    // Trial Access: Grant access if trial is active
    final profileController = Get.find<ProfileController>();
    if (profileController.isTrialActive) {
      // We only flag it as "Trial Access" if they don't have a paid subscription
      // for the role they are currently using.
      // For simplicity, we flag as trial if any of the main access is missing but granted by trial.
      bool hadPaidAccess =
          hasIndividualAccess.value &&
          hasAddMemberAccess.value &&
          hasConsultantAccess.value;

      if (!hasIndividualAccess.value) hasIndividualAccess.value = true;
      if (!hasAddMemberAccess.value) hasAddMemberAccess.value = true;
      if (!hasConsultantAccess.value) hasConsultantAccess.value = true;

      isTrialAccess.value = !hadPaidAccess;
      print('[Trial] Trial is active, isTrialAccess: ${isTrialAccess.value}');
    } else {
      isTrialAccess.value = false;
      // If trial is not active, reset acknowledgment
      await TrialStorage.setTrialAcknowledged(false);
      hasAcknowledgedTrial.value = false;
    }
  }

  Future<void> setTrialAcknowledged() async {
    await TrialStorage.setTrialAcknowledged(true);
    hasAcknowledgedTrial.value = true;
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

  Future<void> purchaseConsultantPlan() async {
    await RevenueCatService.purchasePackage('consultant_offering');
    await checkSubscriptionStatus();
  }
}

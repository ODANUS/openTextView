import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class OptionPopupAdsCtl extends GetxController {
  Rxn<RewardedAd> rewardedAd = Rxn<RewardedAd>();

  @override
  void onInit() {
    _createAnchoredBanner();
    super.onInit();
  }

  Future<void> _createAnchoredBanner() async {
    rewardedAd.value = null;
    rewardedAd.refresh();
    await MobileAds.instance.initialize();
    MobileAds.instance.setAppMuted(true);
    RewardedAd.load(
        adUnitId: kDebugMode
            ? RewardedAd.testAdUnitId
            : "ca-app-pub-6280862087797110/7247357099",
        request: AdRequest(),
        rewardedAdLoadCallback: RewardedAdLoadCallback(
          onAdLoaded: (RewardedAd ad) {
            rewardedAd(ad);
          },
          onAdFailedToLoad: (LoadAdError error) {
            rewardedAd.value = null;
            rewardedAd.refresh();
          },
        ));
  }

  show() {
    if (rewardedAd.value != null) {
      rewardedAd.value!.fullScreenContentCallback = FullScreenContentCallback(
        onAdShowedFullScreenContent: (RewardedAd ad) {},
        onAdDismissedFullScreenContent: (RewardedAd ad) async {
          await ad.dispose();
          _createAnchoredBanner();
        },
        onAdFailedToShowFullScreenContent:
            (RewardedAd ad, AdError error) async {
          await ad.dispose();
          _createAnchoredBanner();
        },
        onAdImpression: (RewardedAd ad) {},
      );
      rewardedAd.value!
          .show(onUserEarnedReward: (RewardedAd ad, RewardItem rewardItem) {});
    }
  }

  @override
  void onClose() {
    super.onClose();
  }
}

class OptionPopupAds extends GetView {
  @override
  Widget build(BuildContext context) {
    var ctl = Get.put(OptionPopupAdsCtl());
    return Obx(() => ctl.rewardedAd.value == null
        ? SizedBox()
        : IconButton(
            onPressed: () {
              ctl.show();
            },
            icon: Icon(Icons.live_tv),
          ));

    // ElevatedButton(
    //     onPressed: () {
    //       ctl.show();
    //     },
    //     child: Text("광고 보기"),
    //   ));
  }
}

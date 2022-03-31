import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdBanner extends GetView {
  AdBanner({Key? key}) : super(key: key) {
    BannerAd(
      size: AdSize(width: Get.width.toInt(), height: 50),
      // size: AdSize.banner,
      request: AdRequest(),
      adUnitId: kDebugMode ? "ca-app-pub-3940256099942544/6300978111" : "ca-app-pub-6280862087797110/4612534059",
      listener: BannerAdListener(
        onAdLoaded: (Ad ad) {
          _bannerAd(ad as BannerAd);
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          print('$BannerAd failedToLoad: $error');
          ad.dispose();
        },
        onAdOpened: (Ad ad) => print('$BannerAd onAdOpened.'),
        onAdClosed: (Ad ad) => print('$BannerAd onAdClosed.'),
      ),
    ).load();
  }
  Rxn<BannerAd> _bannerAd = Rxn<BannerAd>();

  @override
  Widget build(BuildContext context) {
    // print(">>>>>>>>>>>>>>>>>>>>>>>>>");
    return Obx(() {
      // print("create = =======================");

      if (_bannerAd.value != null) {
        return Container(
          width: Get.width,
          height: 50,
          child: AdWidget(ad: _bannerAd.value!),
        );
      }
      return Container(
        width: Get.width,
        height: 50,
      );
    });
  }
}

class AdCtl {
  static AdManagerInterstitialAd? _interstitialAd;
  static RewardedAd? _rewardedAd;

  static init() {
    MobileAds.instance.initialize().then((value) {
      MobileAds.instance.setAppMuted(true);
    });
    // MobileAds.instance.setAppVolume(0);
    initInterstitialAd();
    // initRewardedAd();
    // initBannerAd();
  }

  static initInterstitialAd() {
    AdManagerInterstitialAd.load(
        adUnitId: kDebugMode ? '/6499/example/interstitial' : 'ca-app-pub-6280862087797110/4526743229',
        request: AdManagerAdRequest(),
        adLoadCallback: AdManagerInterstitialAdLoadCallback(
          onAdLoaded: (AdManagerInterstitialAd ad) {
            _interstitialAd = ad;
          },
          onAdFailedToLoad: (LoadAdError error) {
            _interstitialAd = null;
          },
        ));
  }

  static initRewardedAd() {
    // RewardedAd.load(
    //     adUnitId: kDebugMode ? '/6499/example/rewarded' : 'ca-app-pub-6280862087797110/3014109754',
    //     request: AdRequest(),
    //     rewardedAdLoadCallback: RewardedAdLoadCallback(
    //       onAdLoaded: (RewardedAd ad) {
    //         _rewardedAd = ad;
    //       },
    //       onAdFailedToLoad: (LoadAdError error) {
    //         _rewardedAd = null;
    //         print('RewardedAd failed to load: $error');
    //       },
    //     ));
  }

  static bool hasOpenRewardedAd() {
    if (_rewardedAd == null) {
      initRewardedAd();
    }
    return _rewardedAd != null;
  }

  static bool hasOpenInterstitialAd() {
    return _interstitialAd != null;
  }

  // static Future<bool> openRewardedAd() {
  //   Completer<bool> c = Completer<bool>();
  //   var rtn = false;
  //   Get.dialog(AlertDialog(
  //     content: Text("You can add one skill by viewing the ad".tr),
  //     actions: [
  //       ElevatedButton(
  //           onPressed: () {
  //             c.complete(false);
  //             Get.back();
  //           },
  //           child: Text("Cancel")),
  //       ElevatedButton(
  //           onPressed: () {
  //             Get.back();
  //             _rewardedAd?.fullScreenContentCallback = FullScreenContentCallback(
  //               onAdDismissedFullScreenContent: (RewardedAd ad) async {
  //                 await ad.dispose();
  //                 Future.delayed(Duration(seconds: 10), () {
  //                   initRewardedAd();
  //                 });
  //                 if (!rtn) {
  //                   c.complete(false);
  //                 }
  //               },
  //               onAdFailedToShowFullScreenContent: (RewardedAd ad, AdError error) async {
  //                 await ad.dispose();
  //                 Future.delayed(Duration(seconds: 10), () {
  //                   initRewardedAd();
  //                 });

  //                 c.complete(false);
  //               },
  //             );

  //             _rewardedAd?.show(onUserEarnedReward: (AdWithoutView ad, RewardItem rewardItem) {
  //               rtn = true;
  //               c.complete(true);
  //             });
  //           },
  //           child: Text("Confirm")),
  //     ],
  //   ));

  //   return c.future;
  // }

  static void openInterstitialAd() {
    // Completer<bool> c = Completer<bool>();
    Get.dialog(AlertDialog(
      content: Text("Would you like to see an ad".tr),
      actionsAlignment: MainAxisAlignment.spaceAround,
      actions: [
        ElevatedButton(
            onPressed: () {
              Get.back();
              // c.complete(false);
            },
            child: Text("Cancel")),
        ElevatedButton(
            onPressed: () {
              Get.back();
              _interstitialAd?.fullScreenContentCallback = FullScreenContentCallback(
                  onAdShowedFullScreenContent: (AdManagerInterstitialAd ad) {},
                  onAdDismissedFullScreenContent: (AdManagerInterstitialAd ad) async {
                    await ad.dispose();
                    initInterstitialAd();
                    // c.complete(true);
                  },
                  onAdFailedToShowFullScreenContent: (AdManagerInterstitialAd ad, AdError error) async {
                    await ad.dispose();
                    initInterstitialAd();
                    // c.complete(true);
                  },
                  onAdImpression: (AdManagerInterstitialAd ad) {});
              _interstitialAd?.show();
            },
            child: Text("Confirm")),
      ],
    ));

    // return c.future;
  }
}

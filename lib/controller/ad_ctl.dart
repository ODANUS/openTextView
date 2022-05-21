import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:open_textview/isar_ctl.dart';

class AdBanner extends GetView {
  String adUnitId = "";
  AdBanner({Key? key}) : super(key: key) {
    adUnitId = "ca-app-pub-3940256099942544/6300978111";
    if (Platform.isIOS && !kDebugMode) {
      adUnitId = "ca-app-pub-6280862087797110/4350253441";
    }
    if (Platform.isAndroid && !kDebugMode) {
      adUnitId = "ca-app-pub-6280862087797110/4612534059";
    }
    BannerAd(
      size: AdSize(width: Get.width.toInt(), height: 50),
      // size: AdSize.banner,
      request: AdRequest(),
      adUnitId: adUnitId,
      listener: BannerAdListener(
        onAdLoaded: (Ad ad) {
          _bannerAd(ad as BannerAd);
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          ad.dispose();
        },
      ),
    ).load();
  }
  Rxn<BannerAd> _bannerAd = Rxn<BannerAd>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
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
        // child: Text("${adUnitId}"),
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
      MobileAds.instance
          .updateRequestConfiguration(RequestConfiguration(testDeviceIds: ["0be8f77d456375460b4e3c6bb7bab25c", "5559A4CF00EDA5E61AC931F9D8F9742D"]));
    });
    // MobileAds.instance.setAppVolume(0);
    // 5559A4CF00EDA5E61AC931F9D8F9742D
    // MobileAds.instance.updateRequestConfiguration(RequestConfiguration(testDeviceIds: ["5559A4CF00EDA5E61AC931F9D8F9742D"]));
    // initInterstitialAd();
    // initRewardedAd();
    // initBannerAd();
  }

  static initInterstitialAd() async {
    Completer<bool> c = Completer<bool>();
    String adUnitId = "ca-app-pub-3940256099942544/1033173712";
    if (Platform.isIOS && !kDebugMode) {
      adUnitId = "ca-app-pub-6280862087797110/5088905450";
    }
    if (Platform.isAndroid && !kDebugMode) {
      adUnitId = "ca-app-pub-6280862087797110/4526743229";
    }
    AdManagerInterstitialAd.load(
        adUnitId: adUnitId,
        request: AdManagerAdRequest(),
        adLoadCallback: AdManagerInterstitialAdLoadCallback(
          onAdLoaded: (AdManagerInterstitialAd ad) {
            _interstitialAd = ad;
            c.complete(true);
          },
          onAdFailedToLoad: (LoadAdError error) {
            _interstitialAd = null;
            c.complete(false);
          },
        ));
    return c.future;
  }

  static initRewardedAd() {
    Completer<bool> c = Completer<bool>();
    String adUnitId = "ca-app-pub-3940256099942544/5224354917";
    if (Platform.isIOS && !kDebugMode) {
      adUnitId = "ca-app-pub-6280862087797110/3775823780";
    }
    if (Platform.isAndroid && !kDebugMode) {
      adUnitId = "ca-app-pub-6280862087797110/1667025028";
    }
    RewardedAd.load(
        adUnitId: adUnitId,
        request: AdRequest(),
        rewardedAdLoadCallback: RewardedAdLoadCallback(
          onAdLoaded: (RewardedAd ad) {
            _rewardedAd = ad;
            c.complete(true);
          },
          onAdFailedToLoad: (LoadAdError error) {
            _rewardedAd = null;
            c.complete(false);
          },
        ));
    return c.future;
  }

  static Future<bool> startInterstitialAd() async {
    if (await initInterstitialAd()) {
      _interstitialAd?.fullScreenContentCallback = FullScreenContentCallback(
          onAdShowedFullScreenContent: (AdManagerInterstitialAd ad) {},
          onAdDismissedFullScreenContent: (AdManagerInterstitialAd ad) async {
            await ad.dispose();
            _interstitialAd = null;
          },
          onAdFailedToShowFullScreenContent: (AdManagerInterstitialAd ad, AdError error) async {
            await ad.dispose();
            _interstitialAd = null;
          },
          onAdImpression: (AdManagerInterstitialAd ad) {});
      _interstitialAd?.show();
      return true;
    } else {
      return true;
      // Get.dialog(AlertDialog(
      //     content: Text("준비된 광고가 없습니다."), actions: [ElevatedButton(onPressed: () => Get.back(result: false), child: Text("confirm".tr))]));
      // return false;
    }
  }

  static Future<bool> startSaveAsInterstitialAd() async {
    Completer<bool> c = Completer<bool>();
    MobileAds.instance.setAppMuted(false);
    IsarCtl.bLoadingLib(true);
    var stat = false;
    if (await initRewardedAd()) {
      _rewardedAd?.fullScreenContentCallback = FullScreenContentCallback(
        onAdDismissedFullScreenContent: (RewardedAd ad) async {
          IsarCtl.bLoadingLib(false);
          MobileAds.instance.setAppMuted(true);
          c.complete(stat);
          await ad.dispose();
          _rewardedAd = null;
        },
        onAdFailedToShowFullScreenContent: (RewardedAd ad, AdError error) async {
          IsarCtl.bLoadingLib(false);
          MobileAds.instance.setAppMuted(true);
          await ad.dispose();
          _rewardedAd = null;
        },
      );

      _rewardedAd?.show(onUserEarnedReward: (AdWithoutView ad, RewardItem rewardItem) {
        IsarCtl.bLoadingLib(false);
        stat = true;
      });
      return c.future;
    } else {
      IsarCtl.bLoadingLib(false);
      MobileAds.instance.setAppMuted(true);
      return await Get.dialog(AlertDialog(
          content: Text("Failed to load ad"), actions: [ElevatedButton(onPressed: () => Get.back(result: false), child: Text("confirm".tr))]));
    }
    // if (await initInterstitialAd()) {
    //   _interstitialAd?.fullScreenContentCallback = FullScreenContentCallback(
    //       onAdShowedFullScreenContent: (AdManagerInterstitialAd ad) {},
    //       onAdDismissedFullScreenContent: (AdManagerInterstitialAd ad) async {
    //         IsarCtl.bLoadingLib(false);
    //         c.complete(true);
    //         await ad.dispose();
    //         _interstitialAd = null;
    //       },
    //       onAdFailedToShowFullScreenContent: (AdManagerInterstitialAd ad, AdError error) async {
    //         IsarCtl.bLoadingLib(false);
    //         c.complete(false);
    //         await ad.dispose();
    //         _interstitialAd = null;
    //       },
    //       onAdImpression: (AdManagerInterstitialAd ad) {});
    //   _interstitialAd?.show();

    //   return c.future;
    // } else {
    //   IsarCtl.bLoadingLib(false);
    //   return await Get.dialog(AlertDialog(
    //       content: Text("Failed to load ad"), actions: [ElevatedButton(onPressed: () => Get.back(result: false), child: Text("confirm".tr))]));
    // }
  }
  // static Future<bool> startRewardedAd() async {
  //   if (await initRewardedAd()) {
  //     _rewardedAd?.fullScreenContentCallback = FullScreenContentCallback(
  //       onAdDismissedFullScreenContent: (RewardedAd ad) async {
  //         await ad.dispose();
  //         _rewardedAd = null;
  //       },
  //       onAdFailedToShowFullScreenContent: (RewardedAd ad, AdError error) async {
  //         await ad.dispose();
  //         _rewardedAd = null;
  //       },
  //     );

  //     _rewardedAd?.show(onUserEarnedReward: (AdWithoutView ad, RewardItem rewardItem) {});
  //     return true;
  //   } else {
  //     return await startInterstitialAd();
  //   }
  // }

  static Future<bool> openInterstitialAdNewLine() async {
    IsarCtl.bLoadingLib(true);
    if (await initInterstitialAd()) {
      _interstitialAd?.fullScreenContentCallback = FullScreenContentCallback(
          onAdShowedFullScreenContent: (AdManagerInterstitialAd ad) {},
          onAdDismissedFullScreenContent: (AdManagerInterstitialAd ad) async {
            await ad.dispose();
            _interstitialAd = null;
          },
          onAdFailedToShowFullScreenContent: (AdManagerInterstitialAd ad, AdError error) async {
            await ad.dispose();
            _interstitialAd = null;
          },
          onAdImpression: (AdManagerInterstitialAd ad) {});
      _interstitialAd?.show();
      IsarCtl.bLoadingLib(false);
      return true;
      //  Get.back(result: true);
    } else {
      IsarCtl.bLoadingLib(false);
      return true;
      // return await Get.dialog(
      //     AlertDialog(content: Text("준비된 광고가 없습니다."), actions: [ElevatedButton(onPressed: () => Get.back(result: true), child: Text("confirm".tr))]));
    }
  }

  static Future<bool> openInterstitialAdEpubConv() async {
    // Completer<bool> c = Completer<bool>();
    IsarCtl.bLoadingLib(true);
    if (await initInterstitialAd()) {
      _interstitialAd?.fullScreenContentCallback = FullScreenContentCallback(
          onAdShowedFullScreenContent: (AdManagerInterstitialAd ad) {},
          onAdDismissedFullScreenContent: (AdManagerInterstitialAd ad) async {
            await ad.dispose();
            _interstitialAd = null;
          },
          onAdFailedToShowFullScreenContent: (AdManagerInterstitialAd ad, AdError error) async {
            await ad.dispose();
            _interstitialAd = null;
          },
          onAdImpression: (AdManagerInterstitialAd ad) {});
      IsarCtl.bLoadingLib(false);
      _interstitialAd?.show();
      return true;
      // Get.back(result: true);
    } else {
      // Get.back(result: false);
      IsarCtl.bLoadingLib(false);
      return true;
      // return await Get.dialog(
      //     AlertDialog(content: Text("준비된 광고가 없습니다."), actions: [ElevatedButton(onPressed: () => Get.back(result: true), child: Text("confirm".tr))]));
    }
  }

  static Future<bool> openInterstitialAdPDFConv() async {
    // Completer<bool> c = Completer<bool>();
    IsarCtl.bLoadingLib(true);
    if (await initInterstitialAd()) {
      _interstitialAd?.fullScreenContentCallback = FullScreenContentCallback(
          onAdShowedFullScreenContent: (AdManagerInterstitialAd ad) {},
          onAdDismissedFullScreenContent: (AdManagerInterstitialAd ad) async {
            await ad.dispose();
            _interstitialAd = null;
          },
          onAdFailedToShowFullScreenContent: (AdManagerInterstitialAd ad, AdError error) async {
            await ad.dispose();
            _interstitialAd = null;
          },
          onAdImpression: (AdManagerInterstitialAd ad) {});
      await _interstitialAd?.show();
      IsarCtl.bLoadingLib(false);
      return true;
      // Get.back(result: true);
    } else {
      IsarCtl.bLoadingLib(false);
      return true;
      // return await Get.dialog(
      //     AlertDialog(content: Text("준비된 광고가 없습니다."), actions: [ElevatedButton(onPressed: () => Get.back(result: true), child: Text("confirm".tr))]));
    }
  }
}

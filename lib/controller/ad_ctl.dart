import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

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
      if (_bannerAd.value != null && !kDebugMode) {
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
            print('RewardedAd failed to load: $error');
            c.complete(false);
          },
        ));
    return c.future;
  }

  // static bool hasOpenRewardedAd() {
  //   if (_rewardedAd == null) {
  //     initRewardedAd();
  //   }
  //   return _rewardedAd != null;
  // }

  // static bool hasOpenInterstitialAd() {
  //   if (_interstitialAd == null) {
  //     initInterstitialAd();
  //   }
  //   return _interstitialAd != null;
  // }

  // static Future<bool> openSaveAsAd() async {
  //   Completer<bool> c = Completer<bool>();
  //   await Get.dialog(AlertDialog(
  //     title: Text("save as".tr),
  //     actionsAlignment: MainAxisAlignment.spaceAround,
  //     content: Column(
  //       mainAxisSize: MainAxisSize.min,
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Text("You can export".tr),
  //       ],
  //     ),
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
  //                 onAdShowedFullScreenContent: (RewardedAd ad) {},
  //                 onAdDismissedFullScreenContent: (RewardedAd ad) async {
  //                   await ad.dispose();

  //                   c.complete(true);
  //                   initInterstitialAd();
  //                 },
  //                 onAdFailedToShowFullScreenContent: (RewardedAd ad, AdError error) async {
  //                   await ad.dispose();
  //                   c.complete(true);
  //                   initInterstitialAd();
  //                 },
  //                 onAdImpression: (RewardedAd ad) {
  //                   print("onAdImpression");
  //                 });
  //             _interstitialAd?.show();
  //           },
  //           child: Text("Confirm")),
  //     ],
  //   ));

  //   return c.future;
  // }

  static void openInterstitialAd() {
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
            onPressed: () async {
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
              } else {
                Get.dialog(AlertDialog(
                    content: Text("준비된 광고가 없습니다."), actions: [ElevatedButton(onPressed: () => Get.back(result: false), child: Text("confirm".tr))]));
              }
              Get.back();
            },
            child: Text("Confirm")),
      ],
    ));
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
      Get.dialog(AlertDialog(
          content: Text("준비된 광고가 없습니다."), actions: [ElevatedButton(onPressed: () => Get.back(result: false), child: Text("confirm".tr))]));
      return false;
    }
  }

  static Future<bool> startRewardedAd() async {
    if (await initRewardedAd()) {
      _rewardedAd?.fullScreenContentCallback = FullScreenContentCallback(
        onAdDismissedFullScreenContent: (RewardedAd ad) async {
          await ad.dispose();
          _rewardedAd = null;
        },
        onAdFailedToShowFullScreenContent: (RewardedAd ad, AdError error) async {
          await ad.dispose();
          _rewardedAd = null;
        },
      );

      _rewardedAd?.show(onUserEarnedReward: (AdWithoutView ad, RewardItem rewardItem) {});
      return true;
    } else {
      return await startInterstitialAd();
    }
  }

  static Future<bool> openInterstitialAdNewLine() async {
    // Completer<bool> c = Completer<bool>();
    return await Get.dialog(AlertDialog(
      title: Text("개행정리"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("한글 개행 패턴을 19 가지로 나눠보았습니다."),
          Text("파일의 모든 문자를 여러 패턴으로 붙이고 개행 처리를 합니다."),
          Text("무작위로 개행된 파일을 임의로 수정 하는 기능입니다."),
          Text("수정된 파일은 (newline_[기존 파일명](시각).txt) 으로 생성됩니다."),
          Text("개행 수정은 5초 광고(전면광고) 가 실행 되며."),
          Text("광고를 시정하는 동안에 백그라운드에서 개행/파일생성 작업을 동시에 처리합니다."),
        ],
      ),
      actionsAlignment: MainAxisAlignment.spaceAround,
      actions: [
        ElevatedButton(
            onPressed: () {
              Get.back(result: false);
            },
            child: Text("Cancel")),
        ElevatedButton(
            onPressed: () async {
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
                Get.back(result: true);
              } else {
                Get.back(result: false);
                Get.dialog(AlertDialog(
                    content: Text("준비된 광고가 없습니다."), actions: [ElevatedButton(onPressed: () => Get.back(result: false), child: Text("confirm".tr))]));
              }
            },
            child: Text("Confirm")),
      ],
    ));

    // return c.future;
  }

  static Future<bool> openInterstitialAdEpubConv() async {
    // Completer<bool> c = Completer<bool>();
    return await Get.dialog(AlertDialog(
      title: Text("epub -> txt"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("epub 파일을 텍스트로 변환합니다."),
          Text("변환후 파일의 모든 문자를 여러 패턴으로 붙이고 개행 처리를 합니다."),
          Text("수정된 파일은 (epub_[기존 파일명].txt) 으로 생성됩니다."),
          Text("변환/개행 수정은 5초 광고(전면광고) 가 실행 되며."),
          Text("광고를 시정하는 동안에 백그라운드에서 개행/파일생성 작업을 동시에 처리합니다."),
        ],
      ),
      actionsAlignment: MainAxisAlignment.spaceAround,
      actions: [
        ElevatedButton(
            onPressed: () {
              Get.back(result: false);
            },
            child: Text("Cancel")),
        ElevatedButton(
            onPressed: () async {
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
                Get.back(result: true);
              } else {
                Get.back(result: false);
                Get.dialog(AlertDialog(
                    content: Text("준비된 광고가 없습니다."), actions: [ElevatedButton(onPressed: () => Get.back(result: false), child: Text("confirm".tr))]));
              }
            },
            child: Text("Confirm")),
      ],
    ));

    // return c.future;
  }

  static Future<bool> openInterstitialAdPDFConv() async {
    // Completer<bool> c = Completer<bool>();
    return await Get.dialog(AlertDialog(
      title: Text("pdf -> txt"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("PDF 파일을 텍스트로 변환합니다."),
          Text("변환후 파일의 모든 문자를 여러 패턴으로 붙이고 개행 처리를 합니다."),
          Text("수정된 파일은 (pdf_[기존 파일명].txt) 으로 생성됩니다."),
          Text("변환/개행 수정은 5초 광고 가 실행 되며. "),
          Text("광고를 시정하는 동안에 백그라운드에서 개행/파일생성 작업을 동시에 처리합니다."),
        ],
      ),
      actionsAlignment: MainAxisAlignment.spaceAround,
      actions: [
        ElevatedButton(
            onPressed: () {
              Get.back(result: false);
            },
            child: Text("Cancel")),
        ElevatedButton(
            onPressed: () async {
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
                Get.back(result: true);
              } else {
                Get.back(result: false);
                Get.dialog(AlertDialog(
                    content: Text("준비된 광고가 없습니다."), actions: [ElevatedButton(onPressed: () => Get.back(result: false), child: Text("confirm".tr))]));
              }
            },
            child: Text("Confirm")),
      ],
    ));

    // return c.future;
  }
}

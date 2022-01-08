import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdsCtl extends GetxController {
  late BannerAd anchoredBanner;
  final isLoadAd = false.obs;
  final widthSize = 350.0.obs;
  @override
  void onInit() {
    ever(widthSize, (double width) {
      _createAnchoredBanner(width);
    });
    super.onInit();
  }

  Future<void> _createAnchoredBanner(double width) async {
    await MobileAds.instance.initialize();

    final BannerAd banner = BannerAd(
      size: AdSize(width: width.toInt(), height: 50),
      // size: AdSize.banner,
      request: AdRequest(),
      adUnitId: kDebugMode
          ? BannerAd.testAdUnitId
          : "ca-app-pub-6280862087797110/4612534059",
      listener: BannerAdListener(
        onAdLoaded: (Ad ad) {
          anchoredBanner = ad as BannerAd;
          isLoadAd(true);

          // update();
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          print('$BannerAd failedToLoad: $error');
          ad.dispose();
        },
        onAdOpened: (Ad ad) => print('$BannerAd onAdOpened.'),
        onAdClosed: (Ad ad) => print('$BannerAd onAdClosed.'),
      ),
    );
    return banner.load();
  }

  @override
  void onClose() {
    super.onClose();
  }
}

class AdsComp extends GetView<AdsCtl> {
  AdsComp() {
    Get.create(() => AdsCtl());
  }

  @override
  Widget build(BuildContext context) {
    var ctl = Get.find<AdsCtl>();

    return LayoutBuilder(builder: (context, constraints) {
      // ctl.widthSize.update((v) {
      //   double w = constraints.maxWidth == double.infinity
      //       ? context.width
      //       : constraints.maxWidth;
      //   ctl.widthSize.value = w;
      // });

      return Obx(() {
        if (ctl.isLoadAd.value) {
          return Container(
            // color: Colors.red,
            width: context.width,
            height: 50,
            child: AdWidget(ad: ctl.anchoredBanner),
          );
        }
        return SizedBox(
          height: 50,
        );
      });
    });
    // Obx(() {
    //   if (ctl.isLoadAd.value) {
    //     return Container(
    //       color: Colors.red,
    //       width: context.width,
    //       height: 50,
    //       child: AdWidget(ad: ctl.anchoredBanner),
    //     );
    //   }
    //   return SizedBox();
    // });
  }
}


// import 'package:flutter/foundation.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/widgets.dart';
// import 'package:get/get.dart';
// import 'package:google_mobile_ads/google_mobile_ads.dart';

// class AdsCtl extends GetxController {
//   late BannerAd anchoredBanner;
//   final isLoadAd = false.obs;

//   @override
//   void onInit() {
//     _createAnchoredBanner();
//     super.onInit();
//   }

//   Future<void> _createAnchoredBanner() async {
//     // print("kDebugMode : $kDebugMode");
//     await MobileAds.instance.initialize();
//     final BannerAd banner = BannerAd(
//       // size: AdSize(width: Get.width.toInt() - 10, height: 50),
//       size: AdSize.banner,
//       request: AdRequest(),
//       adUnitId: kDebugMode
//           ? 'ca-app-pub-3940256099942544/6300978111'
//           : "ca-app-pub-6280862087797110/5463785600",
//       listener: BannerAdListener(
//         onAdLoaded: (Ad ad) {
//           anchoredBanner = ad as BannerAd;
//           isLoadAd.value = true;
//           update();
//         },
//         onAdFailedToLoad: (Ad ad, LoadAdError error) {
//           print('$BannerAd failedToLoad: $error');
//           ad.dispose();
//         },
//         onAdOpened: (Ad ad) => print('$BannerAd onAdOpened.'),
//         onAdClosed: (Ad ad) => print('$BannerAd onAdClosed.'),
//       ),
//     );
//     return banner.load();
//   }
// }

// class AdsComp extends GetView<AdsCtl> {
//   AdsComp() {
//     Get.put(AdsCtl());
//   }
//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     return GetBuilder<AdsCtl>(builder: (ctl) {
//       print(ctl.isLoadAd.value);
//       if (ctl.isLoadAd.value) {
//         return AdWidget(ad: ctl.anchoredBanner);
//       }
//       return Center(
//         child: Text("광고 준비중..."),
//       );
//     });
//   }
// }

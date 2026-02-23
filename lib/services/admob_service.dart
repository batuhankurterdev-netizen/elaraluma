import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdMobService {
  static String? get bannerAdUnitId {
    if (kIsWeb) return null;
    
    try {
      if (Platform.isAndroid) {
        return 'ca-app-pub-1661750317640188/8363450297';
      } else if (Platform.isIOS) {
        return 'ca-app-pub-3940256099942544/2934735716';
      }
    } catch (e) {
      return null;
    }
    return null;
  }

  static String? get interstitialAdUnitId {
    if (kIsWeb) return null;
    
    try {
      if (Platform.isAndroid) {
        return 'ca-app-pub-1661750317640188/6607515496';
      } else if (Platform.isIOS) {
        return 'ca-app-pub-3940256099942544/4411468910';
      }
    } catch (e) {
      return null;
    }
    return null;
  }

  static String? get rewardedAdUnitId {
    if (kIsWeb) return null;
    
    try {
      if (Platform.isAndroid) {
        return 'ca-app-pub-1661750317640188/6085964255';
      } else if (Platform.isIOS) {
        return 'ca-app-pub-3940256099942544/1712485313';
      }
    } catch (e) {
      return null;
    }
    return null;
  }
}

class AdMobManager {
  InterstitialAd? _interstitialAd;
  RewardedAd? _rewardedAd;
  bool _isInterstitialAdReady = false;
  bool _isRewardedAdReady = false;

  BannerAd? createBannerAd() {
    if (kIsWeb || AdMobService.bannerAdUnitId == null) return null;
    
    return BannerAd(
      adUnitId: AdMobService.bannerAdUnitId!,
      size: AdSize.banner,
      request: AdRequest(
        keywords: ['game', 'kids', 'children', 'educational'],
      ),
      listener: BannerAdListener(
        onAdLoaded: (ad) => print('Banner reklam yüklendi'),
        onAdFailedToLoad: (ad, error) {
          print('Banner reklam yüklenemedi: $error');
          ad.dispose();
        },
      ),
    );
  }

  void loadInterstitialAd({Function? onAdLoaded}) {
    if (kIsWeb || AdMobService.interstitialAdUnitId == null) return;
    
    InterstitialAd.load(
      adUnitId: AdMobService.interstitialAdUnitId!,
      request: AdRequest(
        keywords: ['game', 'kids', 'children', 'educational'],
      ),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          _interstitialAd = ad;
          _isInterstitialAdReady = true;
          
          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (ad) {
              ad.dispose();
              _isInterstitialAdReady = false;
              loadInterstitialAd();
            },
            onAdFailedToShowFullScreenContent: (ad, error) {
              ad.dispose();
              _isInterstitialAdReady = false;
              loadInterstitialAd();
            },
          );
          
          if (onAdLoaded != null) onAdLoaded();
          print('Interstitial reklam yüklendi');
        },
        onAdFailedToLoad: (error) {
          print('Interstitial reklam yüklenemedi: $error');
          _isInterstitialAdReady = false;
        },
      ),
    );
  }

  void showInterstitialAd() {
    if (_isInterstitialAdReady && _interstitialAd != null) {
      _interstitialAd!.show();
    } else {
      print('Interstitial reklam hazır değil');
      loadInterstitialAd();
    }
  }

  void loadRewardedAd({Function? onAdLoaded}) {
    if (kIsWeb || AdMobService.rewardedAdUnitId == null) return;
    
    RewardedAd.load(
      adUnitId: AdMobService.rewardedAdUnitId!,
      request: AdRequest(
        keywords: ['game', 'kids', 'children', 'educational'],
      ),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (ad) {
          _rewardedAd = ad;
          _isRewardedAdReady = true;
          
          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (ad) {
              ad.dispose();
              _isRewardedAdReady = false;
              loadRewardedAd();
            },
            onAdFailedToShowFullScreenContent: (ad, error) {
              ad.dispose();
              _isRewardedAdReady = false;
              loadRewardedAd();
            },
          );
          
          if (onAdLoaded != null) onAdLoaded();
          print('Rewarded reklam yüklendi');
        },
        onAdFailedToLoad: (error) {
          print('Rewarded reklam yüklenemedi: $error');
          _isRewardedAdReady = false;
        },
      ),
    );
  }

  void showRewardedAd({required Function(int amount) onRewarded}) {
    if (_isRewardedAdReady && _rewardedAd != null) {
      _rewardedAd!.show(
        onUserEarnedReward: (ad, reward) {
          print('Kullanıcı ödül kazandı: ${reward.amount}');
          onRewarded(reward.amount.toInt());
        },
      );
    } else {
      print('Rewarded reklam hazır değil');
      loadRewardedAd();
    }
  }

  void dispose() {
    _interstitialAd?.dispose();
    _rewardedAd?.dispose();
  }

  bool get isInterstitialAdReady => _isInterstitialAdReady;
  bool get isRewardedAdReady => _isRewardedAdReady;
}

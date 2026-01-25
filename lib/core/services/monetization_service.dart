import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Interface para serviços de monetização
/// Facilita testes e troca de provedores de anúncios
abstract class MonetizationService {
  Future<void> initialize();
  void showBannerAd();
  void showInterstitialAd();
  bool get isPremium;
}

// Provider placeholder implementation
final monetizationServiceProvider = Provider<MonetizationService>((ref) {
  return MonetizationServiceImpl();
});

class MonetizationServiceImpl implements MonetizationService {
  @override
  Future<void> initialize() async {
    // TODO: Init Google Mobile Ads
    debugPrint('Monetization Service Initialized');
  }

  @override
  void showBannerAd() {
    // TODO: Load and show banner
  }

  @override
  void showInterstitialAd() {
    // TODO: Load and show interstitial
  }

  @override
  bool get isPremium => false; // Conectar com In-App Purchase logic
}

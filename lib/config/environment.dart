sealed class Environment {
  static const env = String.fromEnvironment('ENV');
  static const appTitle = String.fromEnvironment('APP_TITLE');
  static const appId = String.fromEnvironment('APP_ID');
  static const apiBaseUrl = String.fromEnvironment('API_BASE_URL');
  // AdMob Config
  static const admobAppId = String.fromEnvironment('ADMOB_APP_ID');
  static const admobBannerId = String.fromEnvironment('ADMOB_BANNER_ID');
  static const admobInterstitialId = String.fromEnvironment('ADMOB_INTERSTITIAL_ID');
}
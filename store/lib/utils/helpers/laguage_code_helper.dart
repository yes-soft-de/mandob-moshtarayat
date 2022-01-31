class LanguageCodeHelper {
  static String getLanguageName(String lanCode) {
    switch (lanCode) {
      case 'ar':
        return 'ar';
      case 'en':
        return 'en';
      case 'ur':
        return 'urdu';
      default:
        return 'العربية';
    }
  }
}

class LanguageCodeHelper {
  static String getLanguageName(String lanCode) {
    switch (lanCode) {
      case 'ar':
        return 'العربية';
      case 'en':
        return 'English';
      case 'urdu':
        return 'Urdu';
      default:
        return 'العربية';
    }
  }
}

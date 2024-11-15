extension LanguageDetector on String {
  static final RegExp _russianRegExp = RegExp(r'[\u0400-\u04FF]+');
  static final RegExp _englishRegExp = RegExp(r'[a-zA-Z]+');

  String getLanguage() {
    int russianWords = 0;
    int englishWords = 0;

    for (String word in split(" ")) {
      if (_russianRegExp.hasMatch(word)) {
        russianWords += word.length;
      } else if (_englishRegExp.hasMatch(word)) {
        englishWords += word.length;
      }
    }

    return russianWords > englishWords ? "ru" : "en";
  }
}

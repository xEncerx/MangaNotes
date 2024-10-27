extension TagRemover on String {
  String removeTags() {
    final RegExp htmlTagRegExp =
        RegExp(r'<[^>]*>', multiLine: true, caseSensitive: false);
    final RegExp specialCharsRegExp =
        RegExp(r'&.*?;', multiLine: true, caseSensitive: false);
    final RegExp remangaHyperLink = RegExp(r'\[\/?character(=[^\]]+)?\]',
        multiLine: true, caseSensitive: false);

    return replaceAll(htmlTagRegExp, "")
        .replaceAll(specialCharsRegExp, "")
        .replaceAll(remangaHyperLink, "")
        .trim()
        .replaceAll('"', "");
  }
}

class MangaNotesConst {
  static const String readSection = "Прочитано";
  static const String readingSection = "Читаю";
  static const String plannedSection = "На будущие";
  static const String notReadSection = "Не читаю";
  static const String developerTG = "https://t.me/xEncerx";
  static const String projectGitHub = "https://github.com/xEncerx/MangaNotes";
}

class SettingKeysConst {
  static const String themeKey = "theme";
  static const String buttonStyleKey = "buttonStyle";
  static const String sortedIndexKey = "sortedIndex";
  static const String sorterOrderKey = "sorterOrder";
}

class MangaStatusConst {
  // All statuses must be in lowercase
  static const List<String> releasedStatus = [
    "закончен",
    "released",
    "done",
  ];
  static const List<String> ongoingStatus = [
    "продолжается",
    "лицензировано",
    "ongoing",
  ];
  static const List<String> frozenStatus = [
    "заморожен",
  ];
  static const List<String> otherStatus = [
    "нет переводчика",
  ];

  // Get int value from current manga status
  // released = 1 -> ongoing = 2 -> frozen = 3 -> other status = 4
  static int getProperty(String? mangaStatus) {
    if (mangaStatus == null) return 2;
    mangaStatus = mangaStatus.toLowerCase();
    if (releasedStatus.contains(mangaStatus)) return 1;
    if (ongoingStatus.contains(mangaStatus)) return 2;
    if (frozenStatus.contains(mangaStatus)) return 3;
    if (otherStatus.contains(mangaStatus)) return 4;

    return 2;
  }
}

part of 'sorter_repository.dart';

enum SorterMethod {
  byName, // По названию
  byTimeAsc, // Старые записи -> Новые записи
  byTimeDesc, // Новые записи -> Старые записи
  byChaptersAsc, // Меньше глав -> Больше глав
  byChaptersDesc, // Больше глав -> Меньше глав
  byRatingAsc, // Низкий рейтинг -> Высокий рейтинг
  byRatingDesc // Высокий рейтинг -> Низкий рейтинг
}

final List<Map<String, dynamic>> sorterOptions = const [
  {
    "label": "Старые записи -> Новые записи",
    "method": SorterMethod.byTimeAsc,
  },
  {
    "label": "Новые записи -> Старые записи",
    "method": SorterMethod.byTimeDesc,
  },
  {
    "label": "Меньше глав -> Больше глав",
    "method": SorterMethod.byChaptersAsc,
  },
  {
    "label": "Больше глав -> Меньше глав",
    "method": SorterMethod.byChaptersDesc,
  },
  {
    "label": "Низкий рейтинг -> Высокий рейтинг",
    "method": SorterMethod.byRatingAsc,
  },
  {
    "label": "Высокий рейтинг -> Низкий рейтинг",
    "method": SorterMethod.byRatingDesc,
  },
];

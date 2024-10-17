part of 'filter_repository.dart';

enum FilterMethod {
  byName, // По названию
  byTimeAsc, // Старые записи -> Новые записи
  byTimeDesc, // Новые записи -> Старые записи
  byChaptersAsc, // Меньше глав -> Больше глав
  byChaptersDesc, // Больше глав -> Меньше глав
  byRatingAsc, // Низкий рейтинг -> Высокий рейтинг
  byRatingDesc // Высокий рейтинг -> Низкий рейтинг
}

final List<Map<String, dynamic>> filterOptions = const [
  {
    "label": "Старые записи -> Новые записи",
    "method": FilterMethod.byTimeAsc,
  },
  {
    "label": "Новые записи -> Старые записи",
    "method": FilterMethod.byTimeDesc,
  },
  {
    "label": "Меньше глав -> Больше глав",
    "method": FilterMethod.byChaptersAsc,
  },
  {
    "label": "Больше глав -> Меньше глав",
    "method": FilterMethod.byChaptersDesc,
  },
  {
    "label": "Низкий рейтинг -> Высокий рейтинг",
    "method": FilterMethod.byRatingAsc,
  },
  {
    "label": "Высокий рейтинг -> Низкий рейтинг",
    "method": FilterMethod.byRatingDesc,
  },
];

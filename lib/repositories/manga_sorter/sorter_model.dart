part of 'sorter_repository.dart';

enum SorterMethod {
  byNameMatching,
  byName,
  byStatus,
  byTime,
  byChapters,
  byRating,
}

enum SorterOrder {
  asc,
  desc,
}

class SorterSettings {
  final SorterMethod sorterMethod;
  final SorterOrder sorterOrder;

  SorterSettings({required this.sorterMethod, required this.sorterOrder});
}

class SorterLabels {
  final SorterMethod sorterMethod;
  final String label;

  SorterLabels({required this.sorterMethod, required this.label});
}

final List<SorterLabels> sorterOptions = [
  SorterLabels(sorterMethod: SorterMethod.byName, label: "По названию (А-Я)"),
  SorterLabels(sorterMethod: SorterMethod.byTime, label: "По дате чтения"),
  SorterLabels(sorterMethod: SorterMethod.byStatus, label: "По статусу"),
  SorterLabels(sorterMethod: SorterMethod.byChapters, label: "По кол-ву глав"),
  SorterLabels(sorterMethod: SorterMethod.byRating, label: "По рейтингу"),
];

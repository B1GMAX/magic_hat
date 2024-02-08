class ScoreModel {
  final int totalValue;
  final int successValue;
  final int failedValue;

  ScoreModel({
    required this.failedValue,
    required this.successValue,
    required this.totalValue,
  });

  ScoreModel copyWith({
    int? totalValue,
    int? successValue,
    int? failedValue,
  }) {
    return ScoreModel(
      totalValue: totalValue ?? this.totalValue,
      successValue: successValue ?? this.successValue,
      failedValue: failedValue ?? this.failedValue,
    );
  }
}

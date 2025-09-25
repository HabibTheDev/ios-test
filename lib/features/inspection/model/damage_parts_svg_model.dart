class DamagePartsSvgModel {
  final String? part;
  final String? svgImage;
  final List<String> severity;

  DamagePartsSvgModel({required this.part, required this.svgImage, required this.severity});

  DamagePartsSvgModel copyWith({
    String? part,
    String? svgImage,
    List<String>? severity,
  }) {
    return DamagePartsSvgModel(
      part: part ?? this.part,
      svgImage: svgImage ?? this.svgImage,
      severity: severity ?? this.severity,
    );
  }
}

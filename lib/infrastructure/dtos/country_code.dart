class CountryCode {
  final String countryName;
  final String countryCode;
  final String countryLogo;

  const CountryCode({
    required this.countryName,
    required this.countryCode,
    required this.countryLogo,
  });

  Map<String, dynamic> toJson() => {
        'countryName': countryName,
        'countryCode': countryCode,
        'countryLogo': countryLogo,
      };

  factory CountryCode.fromJson(Map<String, dynamic> json) => CountryCode(
        countryName: json['countryName'] as String? ?? '',
        countryCode: json['countryCode'] as String? ?? '',
        countryLogo: json['countryLogo'] as String? ?? '',
      );
}

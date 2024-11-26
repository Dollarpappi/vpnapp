class IpInfo {
  late final String countryName;
  late final String regionName;
  late final String cityName;
  late final String zipCode;
  late final String timezone;
  late final String internetServiceProvider;
  late final String query;

  IpInfo(
      {required this.cityName,
      required this.countryName,
      required this.internetServiceProvider,
      required this.query,
      required this.regionName,
      required this.timezone,
      required this.zipCode});

      IpInfo.fromJson(Map<String, dynamic> jsonData){
        countryName = jsonData["country"] ?? "";
        regionName = jsonData["regionName"] ?? "";
        cityName = jsonData["city"] ?? "";
        zipCode = jsonData["zip"] ?? " **** ";
        timezone = jsonData["timezone"] ?? "unknown";
        internetServiceProvider = jsonData["isp"] ?? "unknown";
        query = jsonData["query"] ?? "Not available";
      }
}

class VpnConfiguration {
  final String username;
  final String password;
  final String countryName;
  final String config;
  

  VpnConfiguration({
    required this.config,
    required this.countryName,
    required this.password,
    required this.username
  });
}
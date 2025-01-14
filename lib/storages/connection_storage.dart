import 'package:shared_preferences/shared_preferences.dart';

class ConnectionStorage {
  // Create SharedPreferences
  final Future<SharedPreferences> _connectionPrefs =
      SharedPreferences.getInstance();

  void setIpAddress({required String ip}) async {
    SharedPreferences connectionPrefs = await _connectionPrefs;
    connectionPrefs.setString('ipAddress', ip);
  }

  Future<String?> getIpAddress({String ip = '159.223.41.198:8970'}) async {
    SharedPreferences connectionPrefs = await _connectionPrefs;
    return connectionPrefs.getString('ipAddress') ?? ip;
  }

  void clearIpAddress() async {
    SharedPreferences connectionPrefs = await _connectionPrefs;
    connectionPrefs.remove('ipAddress');
  }
}

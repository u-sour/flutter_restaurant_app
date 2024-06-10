import 'package:shared_preferences/shared_preferences.dart';

class ConnectionStorage {
  // Create SharedPreferences
  final Future<SharedPreferences> _connectionPrefs =
      SharedPreferences.getInstance();

  void setIpAddress({required String? ip}) async {
    SharedPreferences connectionPrefs = await _connectionPrefs;
    if (ip != null) {
      connectionPrefs.setString('ipAddress', ip);
    }
  }

  Future<String?> getIpAddress() async {
    SharedPreferences connectionPrefs = await _connectionPrefs;
    return connectionPrefs.getString('ipAddress');
  }

  void clearIpAddress() async {
    SharedPreferences connectionPrefs = await _connectionPrefs;
    connectionPrefs.remove('ipAddress');
  }
}

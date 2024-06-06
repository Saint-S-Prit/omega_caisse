import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  static late SharedPreferences _preferences;

  static Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  static String? getFirstOpenAppStorage() => _preferences.getString("firstOpenAppStorage");

  static Future<void> setFirstOpenAppStorage(String firstOpenAppStorage) async {
    await _preferences.setString("firstOpenAppStorage", firstOpenAppStorage);
  }

  static String? getId() => _preferences.getString("id");

  static Future<void> setId(String id) async {
    await _preferences.setString("id", id);
  }

  static String? getFullName() => _preferences.getString("fullName");

  static Future<void> setFullName(String fullName) async {
    await _preferences.setString("fullName", fullName);
  }

  static String? getPhoneNumber() => _preferences.getString("phoneNumber");

  static Future<void> setPhoneNumber(String phoneNumber) async {
    await _preferences.setString("phoneNumber", phoneNumber);
  }


  static String? getProfile() => _preferences.getString("profile");

  static Future<void> setProfile(String profile) async {
    await _preferences.setString("profile", profile);
  }
  static String? getTeam() => _preferences.getString("team");

  static Future<void> setTeam(String team) async {
    await _preferences.setString("team", team);
  }

  static String? getCategory() => _preferences.getString("category");

  static Future<void> setCategory(String category) async {
    await _preferences.setString("category", category);
  }

  static String? getIsSubscribed() => _preferences.getString("isSubscribed");

  static Future<void> setIsSubscribed(String isSubscribed) async {
    await _preferences.setString("isSubscribed", isSubscribed);
  }

  static String? getIsNotified() => _preferences.getString("isNotified");

  static Future<void> setIsNotified(String isNotified) async {
    await _preferences.setString("isNotified", isNotified);
  }

  static String? getPassword() => _preferences.getString("password");

  static Future<void> setPassword(String password) async {
    await _preferences.setString("password", password);
  }

  static String? getToken() => _preferences.getString("token");

  static Future<void> setToken(String token) async {
    await _preferences.setString("token", token);
  }


  static int? getOtp() => _preferences.getInt("otp");

  static Future<void> setOtp(int otp) async {
    await _preferences.setInt("otp", otp);
  }

  static String? getImagePathForProfile() => _preferences.getString("imagePath");

  static Future<void> setImagePathForProfile(String imagePath) async {
    await _preferences.setString("imagePath", imagePath);
  }

  static Future<void> clearImagePathForProfile() async {
    await _preferences.remove("imagePath");
  }


  static String? getAddress() => _preferences.getString("address");

  static Future<void> setAddress(String address) async {
    await _preferences.setString("address", address);
  }




  static Future<void> clearOtp() async {
    await _preferences.remove("otp");
  }

  static String? getDateSendOpt() => _preferences.getString("dateSendOpt");

  static Future<void> setDateSendOpt(String dateSendOpt) async {
    await _preferences.setString("dateSendOpt", dateSendOpt);
  }

  // static Future<void> clearDateSendOpt() async {
  //   await _preferences.remove("dateSendOpt");
  // }



  static Future<void> clearAllExceptFirstOpenAppStorage() async {
    final firstOpenAppStorage = getFirstOpenAppStorage(); // Conserver la valeur de firstOpenAppStorage
    final imagePath = getImagePathForProfile(); // Conserver la valeur de firstOpenAppStorage
    await _preferences.clear(); // Effacer toutes les données
    if (firstOpenAppStorage != null && imagePath != null ) {
      await setFirstOpenAppStorage(firstOpenAppStorage); // Restaurer la valeur de firstOpenAppStorage
      await setImagePathForProfile(imagePath); // Restaurer la valeur de imagePath
    }
  }
}

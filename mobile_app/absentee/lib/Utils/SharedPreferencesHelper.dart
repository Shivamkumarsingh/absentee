import 'package:shared_preferences/shared_preferences.dart';
class SharedPreferencesHelper {
  ///
  /// Instantiation of the SharedPreferences library
  ///
  static final String _kschoolName = "SchoolName";
  static final String _kUser = "User";
  static final String _kUserName = "UserName";
  static final String _kUserEmail = "UserEmail";
  static final String _kapi_key = "api_key";
  static final String _krole_code = "role_code";
  static final String _kauth_Token = "auth_Token";
  static final String _kSiteId = "SiteId";
  static final String _kCompanySubdomain = "Company_Subdomain";

  static Future<String> getschoolName() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString(_kschoolName) ?? '';
  }

  static Future<bool> setschoolName(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.setString(_kschoolName, value);
  }

  static Future<String> getUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString(_kUser) ?? '';
  }

  static Future<bool> setUser(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.setString(_kUser, value);
  }

  static Future<String> getUserName() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString(_kUserName) ?? '';
  }

  static Future<bool> setUserName(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.setString(_kUserName, value);
  }

  static Future<String> getEmail() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString(_kUserEmail) ?? '';
  }

  static Future<bool> setEmail(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.setString(_kUserEmail, value);
  }

  static Future<String> getApi_key() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString(_kapi_key) ?? '';
  }

  static Future<bool> setApi_key(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.setString(_kapi_key, value);
  }

  static Future<String> getRole_code() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString(_krole_code) ?? '';
  }

  static Future<bool> setRole_code(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.setString(_krole_code, value);
  }

  static Future<String> getAuth_Token() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString(_kauth_Token) ?? '';
  }

  static Future<bool> setAuth_Token(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.setString(_kauth_Token, value);
  }

  static Future<String> getSiteId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString(_kSiteId) ?? '';
  }

  static Future<bool> setSiteId(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.setString(_kSiteId, value);
  }

  static Future<String> getCompany_Subdomain() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString(_kCompanySubdomain) ?? '';
  }

  static Future<bool> setCompany_Subdomain(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.setString(_kCompanySubdomain, value);
  }
  static Future<String> getDevice_token() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString(_kCompanySubdomain) ?? '';
  }

  static Future<bool> setDevice_token(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.setString(_kCompanySubdomain, value);
  }
  static Future<bool> removeUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.clear();
  }
}
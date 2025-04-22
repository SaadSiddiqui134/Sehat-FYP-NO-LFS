import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiConstants {
  // Change this one line to switch environments
  static const String baseUrl = 'http://10.0.2.2:8000'; // emulator
  static final String baseUrlDevice = dotenv.env['DEVICE_IP'] ??
      'http://10.0.2.2:8000/user/login/'; // real device

  // ---------------- USER MODULE ----------------
  static const String createUser = '$baseUrl/user/create/';
  static const String loginUser = '$baseUrl/user/login/';
  static const String updateUser = '$baseUrl/user/update/';
  static const String deleteUser = '$baseUrl/user/delete/';
  static const String getUserDetails = '$baseUrl/user/details/';

  static final String createUser2 = '$baseUrlDevice/user/create/';
  static final String loginUser2 = '$baseUrlDevice/user/login/';
  static final String updateUser2 = '$baseUrlDevice/user/update/';
  static final String deleteUser2 = '$baseUrlDevice/user/delete/';
  static final String getUserDetails2 = '$baseUrlDevice/user/details/';

  // ---------------- SLEEP TRACKER MODULE ----------------
  static const String logSleep = '$baseUrl/sleep/sleepadd/';
  // static const String getSleepLogs = '$baseUrl/sleep/sleepGetByUser/$id';
  static String getSleepLogsUserChart(int userIDForSleepChart) =>
      '$baseUrl/sleep/sleepLineChart/$userIDForSleepChart';
  static String getSleepLogsUser(int userIDForSleepLogs) =>
      '$baseUrl/sleep/sleepGetByUser/$userIDForSleepLogs';

  static final String logSleep2 = '$baseUrlDevice/sleep/log/';
  static final String getSleepLogs2 = '$baseUrlDevice/sleep/all/';
  static final String getSleepStats2 = '$baseUrlDevice/sleep/stats/';

  // ---------------- DISEASE MODULE ----------------
  static const String predictDisease = '$baseUrl/disease/predict/';
  static const String diseaseHistory = '$baseUrl/disease/history/';

  static final String predictDisease2 = '$baseUrlDevice/disease/predict/';
  static final String diseaseHistory2 = '$baseUrlDevice/disease/history/';

  // ---------------- HEALTH MODULE ----------------
  static final String logVitals = '$baseUrl/health/log/';
  static final String getVitals = '$baseUrl/health/data/';
  static final String getHealthStats = '$baseUrl/health/stats/';

  static final String logVitals2 = '$baseUrlDevice/health/log/';
  static final String getVitals2 = '$baseUrlDevice/health/data/';
  static final String getHealthStats2 = '$baseUrlDevice/health/stats/';
}

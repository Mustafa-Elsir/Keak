import 'api_provider.dart';

class Repository {

  final apiProvider = ApiProvider();

  String get baseUrl => apiProvider.baseUrl;

  void close() => apiProvider.close();

  Future<Map<String , dynamic>> auth(String phone) => apiProvider.auth(phone);

  Future<Map<String , dynamic>> weeks(String ambergrisId) => apiProvider.lookups("weeks.php", {
    "ambergris_id": ambergrisId,
  });

  Future<Map<String , dynamic>> days(String ambergrisId, String initCount, String fromDate, String toDate) =>
      apiProvider.lookups("days.php", {
        "ambergris_id": ambergrisId,
        "init_count": initCount,
        "from_date": fromDate,
        "to_date": toDate,
      });

  Future<Map<String , dynamic>> registerDead(String ambergrisId, String dateTime, String qty) =>
      apiProvider.registerData("register_dead.php", {
        "ambergris_id": ambergrisId,
        "dead_date_time": dateTime,
        "qty": qty
      });

  Future<Map<String , dynamic>> registerWeight(String ambergrisId, String dateTime, String weight) =>
      apiProvider.registerData("register_weight.php", {
        "ambergris_id": ambergrisId,
        "date_time": dateTime,
        "weight": weight,
      });

  Future<Map<String , dynamic>> registerNote(String ambergrisId, String dateTime, String note) =>
      apiProvider.registerData("register_notes.php", {
        "ambergris_id": ambergrisId,
        "date_time": dateTime,
        "note": note,
      });
}

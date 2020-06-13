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
}

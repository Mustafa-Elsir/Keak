import 'api_provider.dart';

class Repository {

  final apiProvider = ApiProvider();

  String get baseUrl => apiProvider.baseUrl;

  void close() => apiProvider.close();


}

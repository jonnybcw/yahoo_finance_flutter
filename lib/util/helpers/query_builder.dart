import 'dart:developer';

class QueryBuilder {
  static String generateQueryWithMap({required Map<String, dynamic> params}) {
    List<String> formattedParams = [];
    String query = '';
    params.forEach((key, value) {
      if (value is List<dynamic>) {
        value.map((item) {
          formattedParams.add('$key=$item');
        }).toList();
      } else {
        if (value != null) {
          formattedParams.add('$key=$value');
        }
      }
    });

    query = formattedParams.join('&');
    log(query);
    return query;
  }
}

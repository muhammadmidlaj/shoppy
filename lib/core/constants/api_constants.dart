class ApiConstants {
  static const String baseUrl = "http://143.198.61.94:8000/api";
  static const String baseImageUrl = "http://143.198.61.94:8000";
  static headers() => {'Content-Type': 'application/json'};

  static const String products = "/products/";
  static const String customers = "/customers/";
  static const String orders = "/orders/";

  static searchCustomer({required String name}) =>
      "/customers/?search_query=$name";
}

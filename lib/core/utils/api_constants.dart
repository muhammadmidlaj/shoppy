class ApiConstants {
  static const String baseUrl = "http://143.198.61.94:8000/api";
  static const String imageUrl = "http://143.198.61.94:8000";
  static headers() => {'Content-Type': 'application/json'};

  static const String products = "/products/";
  static const String customers = "/customers/";

  static searchCustomer({required String name}) =>
      "/customers/?search_query=$name";
}

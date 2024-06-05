class ApiConstants {
  static const String baseUrl = "YOUR_API_BASE_URL";
  static const String baseImageUrl = "YOUR_IMAGE_URL";
  static headers() => {'Content-Type': 'application/json'};

  static const String products = "/products/";
  static const String customers = "/customers/";
  static const String orders = "/orders/";

  static searchCustomer({required String name}) =>
      "/customers/?search_query=$name";
}

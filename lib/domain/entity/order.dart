class OrderResult {
    final int errorCode;
    final Data data;
    final String message;

    OrderResult({
        required this.errorCode,
        required this.data,
        required this.message,
    });

  

    // Map<String, dynamic> toJson() => {
    //     "error_code": errorCode,
    //     "data": data.toJson(),
    //     "message": message,
    // };
}

class Data {
    Data();

    
}
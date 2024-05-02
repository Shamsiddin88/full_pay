class NetworkResponse {
  String errorText;
  String errorCode;
  dynamic data;

  NetworkResponse({
    this.errorText = "",
    this.data,
    this.errorCode = "",
  });
}

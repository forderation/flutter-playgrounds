class HttpError implements Exception {
  final String message;
  HttpError(this.message);

  @override
  String toString() {
    // TODO: implement toString
    // return super.toString();
    return message;
  }
}

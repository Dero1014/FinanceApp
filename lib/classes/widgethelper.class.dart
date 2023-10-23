class WidgetHelper {
  // Singleton // +
  static final WidgetHelper _singleton = WidgetHelper._internal();

  factory WidgetHelper() {
    return _singleton;
  }

  WidgetHelper._internal();
  // Singleton // -

  String maxStringAllowed(String text) {
    String result = text;
    int maxStringLength = 12;


    if (result.length >= maxStringLength) {
      result = result.substring(0, maxStringLength);
      result += "...";
    }

    return result;
  }
}
import 'package:hive/hive.dart';

class Boxes {
  List<Box> boxes = [];

 // Singleton // +
  static final Boxes _singleton = Boxes._internal();

  factory Boxes() {
    return _singleton;
  }

  Boxes._internal();
  // Singleton // -

  void BoxesInit()
  {
    // Get the directory where it saves the data
    // List all of hive elements
    // Get the boxes names of the elements
    
  }
}
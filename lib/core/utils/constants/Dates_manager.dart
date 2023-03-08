import 'package:intl/intl.dart';
class DatesManager{
  static String currentTime = DateFormat("HH:mm").format(DateTime.now());
  static String currentDate = DateFormat("MMM, EEE, yyyy").format(DateTime.now());
}
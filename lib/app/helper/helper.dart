import 'package:intl/intl.dart';

class Helper {
  Helper._();

  static String generateId() {
    final now = DateTime.now();
    final formatter = DateFormat('yyyy-MM-dd-HH-mm-ss-SSS');
    final formattedDate = formatter.format(now);

    return formattedDate; // output: 2024-12-11-23-59-59-123
  }
}

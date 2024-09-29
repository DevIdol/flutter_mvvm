import 'package:intl/intl.dart';

extension DateExtensionTimestamp on DateTime {
  String toYMD() {
    final formattedDate = DateFormat('yyyy年M月d日').format(this);
    return formattedDate;
  }

  String toYMDHM() {
    final formattedDate = DateFormat('yyyy年M月d日 HH:mm').format(this);
    return formattedDate;
  }

  String convertYMD() {
    final formattedDate = DateFormat('yyy-MM-dd').format(this);
    return formattedDate;
  }
}

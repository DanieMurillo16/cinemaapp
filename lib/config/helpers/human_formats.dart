

import 'package:intl/intl.dart';

class HumanFormats {
  static String number(double number){
    final formateerNumber = NumberFormat.compactCurrency(
      decimalDigits: 3,
      symbol: '',
      locale: 'en'
    ).format(number);
    return formateerNumber;
  }
}
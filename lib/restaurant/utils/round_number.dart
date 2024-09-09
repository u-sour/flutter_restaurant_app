import 'package:big_dart/big_dart.dart';

class RoundNumber {
  final int decimalNumber;
  const RoundNumber({required this.decimalNumber});

  /// Format ក្រោយក្បៀល ៧ខ្ទង
  // static format number by 7 digits
  num numberDigit(num value) {
    int countDecimalPrecision =
        value.runtimeType == double ? value.toString().split('.')[1].length : 0;
    return countDecimalPrecision >= 7
        ? Big(value).selfRound(7).toNumber()
        : value;
  }

  /// សំរាប់ round តម្លៃបោះទៅកាន់ server ។
  /// Round តម្លៃទៅតាម decimal number ដែល company បានកំណត់
  double round(
      {required dynamic value,
      int? decimalNumber,
      RoundingMode? roundingMode}) {
    decimalNumber ??= this.decimalNumber;
    return Big(value).selfRound(decimalNumber, roundingMode).toNumber();
  }
}

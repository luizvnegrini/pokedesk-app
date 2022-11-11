import 'package:intl/intl.dart';

extension StringExtensions on String {
  String toCapitalized({bool allWords = false}) {
    if (length == 0) {
      return '';
    }

    if (allWords) {
      return split(' ')
          .map((w) => toBeginningOfSentenceCase(w))
          .join(' ')
          //Considering split by dots too. Mainly used for bank names, for example:
          //banco genial s.a.
          //=>
          //Banco Genial S.A.
          .split('.')
          .map((w) => toBeginningOfSentenceCase(w))
          .join('.');
    }

    return toBeginningOfSentenceCase(this) ?? '';
  }
}

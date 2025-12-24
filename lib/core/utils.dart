import 'package:intl/intl.dart';

String toShortDate(int dateTime) => DateFormat('dd MMM, yyyy').format(DateTime.fromMicrosecondsSinceEpoch(dateTime));

String toLongDate(int dateTime) => DateFormat('dd MMMM, yyyy hh:mm a').format(DateTime.fromMicrosecondsSinceEpoch(dateTime));
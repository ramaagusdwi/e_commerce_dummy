import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';

class UtilsWidget {
  static showDatePicker(
      BuildContext context, Function(String value) onConfirm) {
    DatePicker.showDatePicker(context,
        showTitleActions: true,
        minTime: DateTime(2018, 3, 5),
        maxTime: DateTime(2050, 6, 7),
        theme: const DatePickerTheme(
            headerColor: Colors.white,
            backgroundColor: Colors.white,
            itemStyle: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
            doneStyle: TextStyle(color: Colors.black, fontSize: 16)),
        onChanged: (date) {
      print('change $date in time zone ' +
          date.timeZoneOffset.inHours.toString());
    }, onConfirm: (date) {
      onConfirm(DateFormat("dd MMMM yyyy", "id_ID").format(date));
    }, currentTime: DateTime.now(), locale: LocaleType.id
        // locale: const Locale("id", "ID"),
        );
  }
}

import 'package:flutter/material.dart';
import 'package:fogsi/controller/events/events_controller.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:get/get.dart';

import 'colors.dart';


parseDateMonth(String date) {
  if (date == "" || date == "NA") {
    return "";
  } else {
    DateTime tempDate = DateFormat("yyyy-MM-ddThh:mm:ss").parse(date);
    String formattedDate = DateFormat("dd/MM/yyyy").format(tempDate);
    return formattedDate;
  }
}

String parseToDay(String date) {
  if (date == "" || date == "NA") {
    return "";
  } else {
    DateTime tempDate = DateFormat("yyyy-MM-ddTHH:mm:ss").parse(date);
    int day = tempDate.day;
    String weekday = DateFormat('E').format(tempDate); // Get weekday name

    String formattedDate = '$day $weekday';
    return formattedDate;
  }
}


parseToMonth(String dateString) {
  try {
    DateTime dateTime = DateTime.parse(dateString);
    String month = DateFormat('MMMM').format(dateTime);

    return month;
  } catch (e) {
    print('Error parsing date: $e');
    return '';
  }
}


isToday(String date){
  DateTime currentDate = DateTime.now();
  DateTime givenDate = DateTime.parse(date);

  return currentDate.year == givenDate.year && currentDate.month == givenDate.month && currentDate.day == givenDate.day;

}

isUpComing(String date){
  DateTime currentDate = DateTime.now();
  DateTime givenDate = DateTime.parse(date);

  return givenDate.isAfter(currentDate);
}

bool isInThisMonth(String monthName, String startDateString) {
  final Map<String, int> monthMap = {'January': 1, 'February': 2, 'March': 3, 'April': 4, 'May': 5, 'June': 6,
        'July': 7, 'August': 8, 'September': 9, 'October': 10, 'November': 11, 'December': 12,};

  DateTime startDate;
  try {
    startDate = DateTime.parse(startDateString);
  } catch (e) {
    print('Error parsing start date: $e');
    return false;
  }

  final int givenMonth = monthMap[monthName] ?? 0;

  return startDate.month == givenMonth;
}


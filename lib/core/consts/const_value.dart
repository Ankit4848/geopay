// Spacing
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../core.dart';

const double kSpaceS = 8.0;
const double kSpaceM = 16.0;
const double kSpaceLoginFormM = 180.0;
const double kSpaceLoginFormS = 120.0;

const int timeoutDuration = 60;




DateTime addMonths(int monthsToAdd) {
  int newYear = DateTime.now().year;
  int newMonth = DateTime.now().month + monthsToAdd;


  while (newMonth > 12) {
    newMonth -= 12;
    newYear += 1;
  }

  while (newMonth < 1) {
    newMonth += 12;
    newYear -= 1;
  }

  // Handle overflow days for months with fewer days (like February)
  int newDay = DateTime.now().day;
  int lastDayOfNewMonth =
      DateTime(newYear, newMonth + 1, 0).day; // Last day of the new month

  if (newDay > lastDayOfNewMonth) {
    newDay = lastDayOfNewMonth;
  }

  return DateTime(newYear, newMonth, newDay);
}

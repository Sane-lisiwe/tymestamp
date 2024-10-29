import 'package:intl/intl.dart';

class DateTimeService {
  // Method to get the full month name
  String getMonth() {
    DateTime now = DateTime.now();
    String fullMonth = DateFormat('MMMM').format(now); // Returns full month name
    return fullMonth;
  }

  // Method to get the date in dd-MM-YYYY format
  String getDate() {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('dd-MM-yyyy').format(now); // Date in dd-MM-YYYY format
    return formattedDate;
  }

  // Method to get the day in full format
  String getDay() {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('EEEE').format(now); // Date in dd-MM-YYYY format
    return formattedDate;
  }

  // Method to get the date in dd-MM-YYYY format
  String getTodayDate() {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('EEE, d MMM').format(now); // Date in dd-MM-YYYY format
    return formattedDate;
  }

  // Method to get the time in HH:mm:ss format
  String getTime() {
    DateTime now = DateTime.now();
    String formattedTime = DateFormat('HH:mm:ss').format(now); // Time in HH:mm:ss format
    return formattedTime;
  }
}

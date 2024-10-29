import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:tymstamp/views/leave/annual.dart';

import '../../models/constants/theme.dart';
import '../../models/core/inputField.dart';

class Calendar extends StatefulWidget{
  const Calendar({super.key});

  @override
  State<StatefulWidget> createState() {
    return CalendarState();
  }
}

class CalendarState extends State<Calendar>{

  ///--->   CALENDAR VARIABLES  <---///
  late CalendarFormat _calendarFormat = CalendarFormat.month;
  late DateTime _selectedDay = DateTime.now();
  late DateTime _focusedDay = DateTime.now();

  final _leaveEndDate = TextEditingController();
  final _leaveStartDate = TextEditingController();

  @override
  void dispose() {
    _leaveStartDate.dispose();
    _leaveEndDate.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          Positioned(
            width: MediaQuery.of(context).size.width * 1.7,
            left: 0,
            bottom: -100,
            child: Image.asset(
              "assets/logo/logo.png",
            ),
          ),
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 40, sigmaY: 40),
              child: const SizedBox(),
            ),
          ),
          AnimatedPositioned(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            duration: const Duration(milliseconds: 260),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 42),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    TableCalendar(
                        firstDay: DateTime.utc(2020, 10, 16),
                        lastDay: DateTime.utc(2030, 3, 14),
                        focusedDay: _focusedDay,
                        calendarFormat: _calendarFormat,
                        calendarStyle: const CalendarStyle(
                          weekendTextStyle: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                        ),
                        daysOfWeekStyle: DaysOfWeekStyle(
                          weekendStyle: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                          weekdayStyle: TextStyle(
                            color: CustomColors.backgroundColor2,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        selectedDayPredicate: (day) {
                          return isSameDay(_selectedDay, day);
                        },
                        onDaySelected: (selectedDay, focusedDay) {
                          setState(() {
                            _selectedDay = selectedDay;
                            _focusedDay = focusedDay;
                          });
                          //_showLeaveFormDialog(context, selectedDay);
                        },
                        onFormatChanged: (format) {
                          if (_calendarFormat != format) {
                            setState(() {
                              _calendarFormat = format;
                            });
                          }
                        },
                        onPageChanged: (focusedDay) {
                          _focusedDay = focusedDay;
                        },
                        calendarBuilders: CalendarBuilders(
                          defaultBuilder: (context, day, focusedDay){
                            if (day.weekday == DateTime.saturday || day.weekday == DateTime.sunday) {
                              return Center(
                                child: Text(
                                  day.day.toString(),
                                  style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                                ),
                              );
                            }
                            return null;
                          },
                          todayBuilder: (context, day, focusedDay) {
                            return Container(
                              margin: const EdgeInsets.all(4.0),
                              decoration: const BoxDecoration(
                                color: Colors.deepOrange,
                                shape: BoxShape.circle,
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                day.day.toString(),
                                style: GoogleFonts.carterOne(
                                    fontSize: 18.0,
                                    color: CustomColors.primaryColor,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                            );
                          },
                          selectedBuilder: (context, date, events) {
                            return Container(
                              margin: const EdgeInsets.all(4.0),
                              decoration: BoxDecoration(
                                color: CustomColors.backgroundColor2,
                                shape: BoxShape.circle,
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                date.day.toString(),
                                style: GoogleFonts.carterOne(
                                    fontSize: 18.0,
                                    color: CustomColors.primaryColor,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                            );
                          },
                        )
                    ),
                    const SizedBox(height: 30),
                    const SingleChildScrollView(
                      ///---> Leaves from the database
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){_leaveTypeModal(context);},
        backgroundColor: CustomColors.backgroundColor2,
        child: Icon(Icons.calendar_month, color: CustomColors.primaryColor),
      ),
    );
  }

  void _leaveTypeModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    const Text(
                      'Leave Type',
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'SansSerif',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 45),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            GestureDetector(
                              onTap: () {
                                _annualModal(context);
                              },
                              child: SizedBox(
                                width: 140, // Fixed width for the card
                                height: 140, // Fixed height for the card
                                child: Card(
                                  elevation: 5,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Image.asset(
                                        'assets/leave/annual_leave.png',
                                        height: 80,
                                        fit: BoxFit.fill,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8),
                                        child: Text(
                                          'Annual Leave',
                                          style: TextStyle(
                                            fontSize: 15,
                                            fontFamily: 'SansSerif',
                                            color: CustomColors.backgroundColor2,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {},
                              child: SizedBox(
                                width: 140,
                                height: 140,
                                child: Card(
                                  elevation: 5,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Image.asset(
                                        'assets/leave/sick_leave.png',
                                        height: 80,
                                        fit: BoxFit.fill,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8),
                                        child: Text(
                                          'Sick Leave',
                                          style: TextStyle(
                                            fontSize: 15,
                                            fontFamily: 'SansSerif',
                                            color: CustomColors.backgroundColor2,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {},
                              child: SizedBox(
                                width: 140,
                                height: 140,
                                child: Card(
                                  elevation: 5,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Image.asset(
                                        'assets/leave/study_leave.png',
                                        height: 80,
                                        fit: BoxFit.fill,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8),
                                        child: Text(
                                          'Study Leave',
                                          style: TextStyle(
                                            fontSize: 15,
                                            fontFamily: 'SansSerif',
                                            color: CustomColors.backgroundColor2,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            GestureDetector(
                              onTap: () {},
                              child: SizedBox(
                                width: 140,
                                height: 140,
                                child: Card(
                                  elevation: 5,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Image.asset(
                                        'assets/leave/parental_leave.png',
                                        height: 80,
                                        fit: BoxFit.fill,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8),
                                        child: Text(
                                          'Parental Leave',
                                          style: TextStyle(
                                            fontSize: 15,
                                            fontFamily: 'SansSerif',
                                            color: CustomColors.backgroundColor2,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {},
                              child: SizedBox(
                                width: 140,
                                height: 140,
                                child: Card(
                                  elevation: 5,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Image.asset(
                                        'assets/leave/emergency_leave.png',
                                        height: 80,
                                        fit: BoxFit.fill,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8),
                                        child: Text(
                                          'Care Leave',
                                          style: TextStyle(
                                            fontSize: 15,
                                            fontFamily: 'SansSerif',
                                            color: CustomColors.backgroundColor2,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {},
                              child: SizedBox(
                                width: 140,
                                height: 140,
                                child: Card(
                                  elevation: 5,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Image.asset(
                                        'assets/leave/unpaid.png',
                                        height: 80,
                                        fit: BoxFit.fill,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8),
                                        child: Text(
                                          'Unpaid Leave',
                                          style: TextStyle(
                                            fontSize: 15,
                                            fontFamily: 'SansSerif',
                                            color: CustomColors.backgroundColor2,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void _annualModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true, // Allows the modal to resize when the keyboard appears
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.8, // Adjust the height as needed
          decoration: const BoxDecoration(
            color: Colors.white, // Set your desired background color
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0),
            ),
          ),
          child: Stack(
            children: [
              // Background image
              Positioned(
                width: MediaQuery.of(context).size.width * 1.7,
                left: 0,
                bottom: -100,
                child: Image.asset(
                  "assets/logo/logo.png",
                ),
              ),
              // Blur effect
              Positioned.fill(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 40, sigmaY: 40),
                  child: const SizedBox(),
                ),
              ),
              // Content
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      InputField(
                        title: "From",
                        hint: 'Leave start date',
                        controller: _leaveStartDate,
                        iconData: null,
                        obscure: false,
                        onTap: () async {
                          DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2101),
                          );
                          if (pickedDate != null) {
                            setState(() {
                              _leaveStartDate.text = pickedDate.toString().split(' ')[0];
                            });
                          }
                        }, widget: null,
                      ),
                      InputField(
                        title: "Until",
                        hint: 'Leave end date',
                        controller: _leaveEndDate,
                        iconData: null,
                        obscure: false,
                        onTap: () async {
                          DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2101),
                          );
                          if (pickedDate != null) {
                            setState(() {
                              _leaveEndDate.text = pickedDate.toString().split(' ')[0];
                            });
                          }
                        }, widget: null,
                      ),
                      // Add a submit button or any additional widgets here
                      ElevatedButton(
                        onPressed: () {
                          // Handle form submission
                        },
                        child: const Text('Submit'),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

}
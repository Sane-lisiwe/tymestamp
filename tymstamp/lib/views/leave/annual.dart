import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tymstamp/models/core/inputField.dart';

import '../../models/constants/theme.dart';

class Annual extends StatefulWidget{
  const Annual({super.key});

  @override
  State<StatefulWidget> createState() {
    return _AnnualState();
  }
}

class _AnnualState extends State<Annual>{

  final _leaveEndDate = TextEditingController();
  final _leaveStartDate = TextEditingController();

  DateTime _selectedDate = DateTime.now();
  DateTime _selectedEndDate = DateTime.now();

  getDate() async {
    DateTime? pickDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2030)
    );

    if(pickDate != null)
    {
      setState(() {
        _selectedDate = pickDate;
      });
    }
  }

  getEndDate() async {
    DateTime? pickDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2030)
    );

    if(pickDate != null)
    {
      setState(() {
        _selectedEndDate = pickDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Annual Leave',
          style: TextStyle(
              fontFamily: 'CarterOne',
              color: CustomColors.backgroundColor1
          ),
        ),
        centerTitle: true,
        backgroundColor: CustomColors.clockOutline,
        leading: GestureDetector(
          onTap: (){
            Navigator.pop(context);
          },
          child: Icon(CupertinoIcons.back, color: CustomColors.backgroundColor2),
        ),
      ),
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
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      InputField(
                        title: "From",
                        hint: 'Leave start date',
                        controller: _leaveStartDate,
                        widget: widget,
                        iconData: null,
                        obscure: false
                      ),
                      InputField(
                          title: "Until",
                          hint: 'Leave end date',
                          controller: _leaveEndDate,
                          widget: widget,
                          iconData: null,
                          obscure: false
                      ),
                    ],
                  ),
                )
              ),
            )
        ],
      ),
    );
  }
}
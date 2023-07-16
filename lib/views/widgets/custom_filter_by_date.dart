import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:leen_alkhier_store/utils/Shared.dart';
import 'package:leen_alkhier_store/utils/colors.dart';
import 'package:table_calendar/table_calendar.dart';

class CustomCalendar extends StatefulWidget {
  final bool? from;
  final String? end_date;
  final String? start_date;
  CustomCalendar({this.from,this.end_date,this.start_date});
  @override
  _CustomCalendarState createState() => _CustomCalendarState();
}

class _CustomCalendarState extends State<CustomCalendar> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  List<String>? listOfDatesOfMonth;
  late var totalDaysOfMonth;
  var month_value;
  var today;

  var date_clickable;

  @override
  void initState() {
    var now = new DateTime.now();
    var formatter = new DateFormat('dd/MM/yyyy');
    today = formatter.format(now);
   // from_day = today;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final kToday = DateTime.now();
    final kFirstDay = DateTime(kToday.year, kToday.month - 3, kToday.day);
    final kLastDay = DateTime(kToday.year, kToday.month + 3, kToday.day);
    return    InkWell(
      onTap: () {
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return Dialog(
                backgroundColor: Theme.of(context).primaryColor,
                elevation: 20,
                child: Container(
                    height: MediaQuery.of(context).size.height * 0.7,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20)),
                    child: Scaffold(
                      appBar: AppBar(
                        backgroundColor: CustomColors.GREY_COLOR,
                        automaticallyImplyLeading: false,
                        leading: InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Icon(Icons.close),
                        ),
                      ),
                      body: TableCalendar(
                        firstDay: kFirstDay,
                        lastDay: kLastDay,
                        focusedDay: _focusedDay,
                        calendarFormat: _calendarFormat,
                        selectedDayPredicate: (day) {
                          return isSameDay(_selectedDay, day);
                        },

                        onDaySelected: (selectedDay, focusedDay) {
                          if (!isSameDay(_selectedDay, selectedDay)) {
                            setState(() {
                              _selectedDay = selectedDay;
                              _focusedDay = focusedDay;
                              var formatter = new DateFormat('dd/MM/yyyy');
                              if(widget.from!){
                                Shared.from_day = formatter.format(_selectedDay!);
                              }else{
                                Shared.to_day = formatter.format(_selectedDay!);
                              }

                              Navigator.pop(context);
                            });
                          }
                        },
                        onFormatChanged: (format) {
                          if (_calendarFormat != format) {
                            // Call `setState()` when updating calendar format
                            setState(() {
                              _calendarFormat = format;
                            });
                          }
                        },
                        onPageChanged: (focusedDay) {
                          // No need to call `setState()` here
                          _focusedDay = focusedDay;
                        },
                      ),
                    )),
              );
            });
      },
      child: Container(
            padding: EdgeInsets.symmetric(horizontal: 5),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colors.grey)
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("${widget.from!?Shared.from_day?? widget.start_date
                    :Shared.to_day??widget.end_date}",
                  style: TextStyle(color: CustomColors.PRIMARY_GREEN),),
                SizedBox(width: 5,),
                Icon(Icons.date_range)
              ],
            )
        ),

    );
  }

  void get_all_dates_of_month({required var month}) {
    // Take the input year, month number, and pass it inside DateTime()

    month_value = month.substring(1, 3);
    var year = month.substring(4, 8);
    var now = DateTime(int.parse(year), int.parse(month_value));
    totalDaysOfMonth = daysInMonth(now);
    // Stroing all the dates till the last date
    // since we have found the last date using generate
    var listOfDates = new List<int>.generate(totalDaysOfMonth, (i) => i + 1);
    listOfDatesOfMonth = new List<String>.generate(totalDaysOfMonth + 1,
            (i) => "${(i + 1) < 10 ? '0${i + 1}' : i}$month");
  }


  // this returns the last date of the month using DateTime
  int daysInMonth(DateTime date) {
    var firstDayThisMonth = new DateTime(date.year, date.month, date.day);
    var firstDayNextMonth = new DateTime(firstDayThisMonth.year,
        firstDayThisMonth.month + 1, firstDayThisMonth.day);
    return firstDayNextMonth.difference(firstDayThisMonth).inDays;
  }
}
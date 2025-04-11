import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarWidget extends StatefulWidget {
  const CalendarWidget({super.key});

  @override
  _CalendarWidgetState createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  
  // Define some example events
  final Map<DateTime, List<dynamic>> _events = {};
  
  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
    
    // Add some example events
    final today = DateTime.now();
    final meetingDay = DateTime(today.year, today.month, today.day + 2);
    _events[meetingDay] = ['Team Meeting', 'Project Review'];
  }
  
  List<dynamic> _getEventsForDay(DateTime day) {
    return _events[DateTime(day.year, day.month, day.day)] ?? [];
  }
  
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF1F2638),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'GENERAL 10:00 AM TO 7:00 PM',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          
          // Calendar container
          Container(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8), // Reduced horizontal padding
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            // Add width constraint to avoid overflow
            width: double.infinity,
            child: Column(
              children: [
                // Table Calendar with adjusted properties to prevent overflow
                TableCalendar(
                  firstDay: DateTime.utc(2020, 1, 1),
                  lastDay: DateTime.utc(2030, 12, 31),
                  focusedDay: _focusedDay,
                  calendarFormat: _calendarFormat,
                  eventLoader: _getEventsForDay,
                  
                  // Style the calendar
                  calendarStyle: CalendarStyle(
                    // Selected day
                    selectedDecoration: const BoxDecoration(
                      color: Color(0xFFFF9FB3),
                      shape: BoxShape.circle,
                    ),
                    selectedTextStyle: const TextStyle(color: Colors.white),
                    
                    // Today
                    todayDecoration: const BoxDecoration(
                      color: Color(0xFF5C5EDB),
                      shape: BoxShape.circle,
                    ),
                    todayTextStyle: const TextStyle(color: Colors.white),
                    
                    // Normal days
                    defaultTextStyle: const TextStyle(color: Colors.black),
                    
                    // Weekend days
                    weekendTextStyle: const TextStyle(color: Colors.black87),
                    
                    // Outside days
                    outsideTextStyle: TextStyle(color: Colors.grey.shade400),
                    outsideDecoration: const BoxDecoration(shape: BoxShape.circle),
                    
                    // Marker style (for days with events)
                    markerDecoration: const BoxDecoration(
                      color: Color(0xFF5C5EDB),
                      shape: BoxShape.circle,
                    ),
                    markerSize: 5.0,
                    markersMaxCount: 3,
                    
                    // Add cellMargin to adjust cell spacing
                    cellMargin: const EdgeInsets.all(4.0), // Reduced margin
                  ),
                  
                  // Header style
                  headerStyle: HeaderStyle(
                    titleCentered: true,
                    formatButtonVisible: false,
                    leftChevronIcon: Icon(
                      Icons.chevron_left,
                      color: Colors.indigo[400],
                      size: 18, // Smaller icon
                    ),
                    rightChevronIcon: Icon(
                      Icons.chevron_right,
                      color: Colors.indigo[400],
                      size: 18, // Smaller icon
                    ),
                    titleTextStyle: const TextStyle(
                      color: Colors.black87,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    headerPadding: const EdgeInsets.symmetric(vertical: 4.0),
                    leftChevronPadding: const EdgeInsets.all(0),
                    rightChevronPadding: const EdgeInsets.all(0),
                    // Add headerMargin to control spacing
                    headerMargin: const EdgeInsets.only(bottom: 8.0),
                  ),
                  
                  // Days of week style
                  daysOfWeekStyle: DaysOfWeekStyle(
                    weekdayStyle: TextStyle(
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                    ),
                    weekendStyle: TextStyle(
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                    ),
                    // Add padding to adjust days of week spacing
                    decoration: const BoxDecoration(
                      border: Border(bottom: BorderSide(color: Colors.transparent, width: 0))
                    ),
                  ),
                  
                  // Make the calendar more compact
                  rowHeight: 40, // Reduced row height
                  availableCalendarFormats: const {
                    CalendarFormat.month: 'Month',
                  },
                  
                  // Calendar builders for customization
                  calendarBuilders: CalendarBuilders(
                    // Customize the header
                    headerTitleBuilder: (context, day) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min, // Use min size
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(4.0), // Reduced padding
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4), // Reduced padding
                              decoration: BoxDecoration(
                                color: const Color(0xFFEEF0FF),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min, // Use min size
                                children: [
                                  Text(
                                    _getMonthString(day.month),
                                    style: const TextStyle(
                                      color: Color(0xFF5C5EDB),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13, // Slightly smaller font
                                    ),
                                  ),
                                  const SizedBox(width: 2),
                                  Icon(
                                    Icons.keyboard_arrow_down,
                                    color: Colors.indigo[400],
                                    size: 16, // Smaller icon
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(width: 4), // Reduced spacing
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4), // Reduced padding
                            decoration: BoxDecoration(
                              color: const Color(0xFFEEF0FF),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min, // Use min size
                              children: [
                                Text(
                                  day.year.toString(),
                                  style: const TextStyle(
                                    color: Color(0xFF5C5EDB),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13, // Slightly smaller font
                                  ),
                                ),
                                const SizedBox(width: 1),
                                Icon(
                                  Icons.keyboard_arrow_down,
                                  color: Colors.indigo[400],
                                  size: 14,
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                    
                    // Optional: Customize marker display
                    markerBuilder: (context, date, events) {
                      if (events.isNotEmpty) {
                        return Positioned(
                          bottom: 1,
                          child: Container(
                            height: 2,
                            width: 2,
                            decoration: const BoxDecoration(
                              color: Color(0xFF5C5EDB),
                              shape: BoxShape.circle,
                            ),
                          ),
                        );
                      }
                      return null;
                    },
                  ),
                  
                  // Calendar interaction
                  selectedDayPredicate: (day) {
                    return isSameDay(_selectedDay, day);
                  },
                  onDaySelected: (selectedDay, focusedDay) {
                    setState(() {
                      _selectedDay = selectedDay;
                      _focusedDay = focusedDay;
                    });
                  },
                  onFormatChanged: (format) {
                    setState(() {
                      _calendarFormat = format;
                    });
                  },
                  onPageChanged: (focusedDay) {
                    _focusedDay = focusedDay;
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  // Helper method to get abbreviated month name
  String _getMonthString(int month) {
    const months = ['JAN', 'FEB', 'MAR', 'APR', 'MAY', 'JUN', 'JUL', 'AUG', 'SEP', 'OCT', 'NOV', 'DEC'];
    return months[month - 1];
  }
}
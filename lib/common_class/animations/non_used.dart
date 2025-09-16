// import 'package:flutter/material.dart';
// import 'package:table_calendar/table_calendar.dart';

// class StatusAl extends StatefulWidget {
//   const StatusAl({super.key});

//   @override
//   State<StatusAl> createState() => _StatusAlState();
// }

// class _StatusAlState extends State<StatusAl> {
//   DateTime selectedDate = DateTime.now();
//   DateTime focusedDate = DateTime.now();

//   // Dummy data (appointments per date)
//   final Map<String, List<String>> appointments = {
//     "2025-08-20": ["Doctor Visit at 10:00 AM", "Team Meeting 2:00 PM"],
//     "2025-08-21": ["Gym Session at 7:00 AM", "Dinner with Friends 8:00 PM"],
//     "2025-08-22": ["Work Presentation 11:00 AM"],
//     "2025-08-23": ["Shopping 3:00 PM", "Call with Manager 5:00 PM"],
//   };

//   late final PageController _pageController;
//   late final List<DateTime> _allDates;

//   @override
//   void initState() {
//     super.initState();

//     // Generate full year dates
//     _allDates = List.generate(
//       365,
//       (index) => DateTime(2025, 1, 1).add(Duration(days: index)),
//     );

//     final todayIndex = _allDates.indexWhere((d) =>
//         d.year == selectedDate.year &&
//         d.month == selectedDate.month &&
//         d.day == selectedDate.day);

//     _pageController = PageController(initialPage: todayIndex);
//   }

//   String _formatDate(DateTime date) =>
//       "${date.year}-${date.month.toString().padLeft(2, "0")}-${date.day.toString().padLeft(2, "0")}";

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Appointments"),
//         backgroundColor: Colors.blue,
//         foregroundColor: Colors.white,
//       ),
//       body: Column(
//         children: [
//           // Table Calendar (sync with PageView)
//           TableCalendar(
//             firstDay: DateTime(2025, 1, 1),
//             lastDay: DateTime(2025, 12, 31),
//             focusedDay: focusedDate,
//             calendarFormat: CalendarFormat.week, // like Teams horizontal feel
//             selectedDayPredicate: (day) =>
//                 day.year == selectedDate.year &&
//                 day.month == selectedDate.month &&
//                 day.day == selectedDate.day,
//             onDaySelected: (selected, focused) {
//               setState(() {
//                 selectedDate = selected;
//                 focusedDate = focused;
//               });

//               final pageIndex = _allDates.indexWhere((d) =>
//                   d.year == selected.year &&
//                   d.month == selected.month &&
//                   d.day == selected.day);
//               if (pageIndex != -1) {
//                 _pageController.jumpToPage(pageIndex);
//               }
//             },
//             headerStyle: const HeaderStyle(
//               formatButtonVisible: false,
//               titleCentered: true,
//             ),
//             calendarStyle: const CalendarStyle(
//               todayDecoration:
//                   BoxDecoration(color: Colors.blue, shape: BoxShape.circle),
//               selectedDecoration:
//                   BoxDecoration(color: Colors.blue, shape: BoxShape.circle),
//               selectedTextStyle: TextStyle(color: Colors.white),
//               todayTextStyle: TextStyle(color: Colors.white),
//             ),
//           ),

//           const Divider(),

//           // Events per day (scrollable vertically, syncs with calendar)
//           Expanded(
//             child: PageView.builder(
//               controller: _pageController,
//               scrollDirection: Axis.vertical,
//               onPageChanged: (index) {
//                 setState(() {
//                   selectedDate = _allDates[index];
//                   focusedDate = selectedDate;
//                 });
//               },
//               itemCount: _allDates.length,
//               itemBuilder: (context, index) {
//                 final day = _allDates[index];
//                 final events = appointments[_formatDate(day)] ?? [];

//                 return ListView(
//                   children: events.isNotEmpty
//                       ? events
//                           .map((event) => Card(
//                                 child: ListTile(
//                                   leading: const Icon(Icons.event,
//                                       color: Colors.blue),
//                                   title: Text(event),
//                                 ),
//                               ))
//                           .toList()
//                       : [
//                           const Center(
//                             child: Padding(
//                               padding: EdgeInsets.all(20),
//                               child: Text("No events on this date"),
//                             ),
//                           )
//                         ],
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

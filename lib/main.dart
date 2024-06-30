// // // // // import 'package:flutter/material.dart';
// // // // // import 'package:get/get.dart';
// // // // // import 'package:just_audio/just_audio.dart'; // Import JustAudioPlayer
// // // // // import 'dart:async';

// // // // // void main() {
// // // // //   runApp(ArcadeManagerApp());
// // // // // }

// // // // // class ArcadeManagerApp extends StatelessWidget {
// // // // //   @override
// // // // //   Widget build(BuildContext context) {
// // // // //     return GetMaterialApp(
// // // // //       home: HomePage(),
// // // // //     );
// // // // //   }
// // // // // }

// // // // // class HomePage extends StatelessWidget {
// // // // //   final Map<String, List<Slot>> games = {
// // // // //     'Pool': List.generate(10, (_) => Slot()),
// // // // //     'Snooker': List.generate(6, (_) => Slot()),
// // // // //     'Table Tennis': List.generate(3, (_) => Slot()),
// // // // //     'PS-5': List.generate(5, (_) => Slot()),
// // // // //     'PS-4': List.generate(5, (_) => Slot()),
// // // // //     'LAN Gaming': List.generate(10, (_) => Slot()),
// // // // //     'Social Hub': List.generate(1, (_) => Slot()),
// // // // //     'Party Room': List.generate(1, (_) => Slot()),
// // // // //   };

// // // // //   final Map<String, List<int>> timeOptions = {
// // // // //     'default': [60, 30, 15, 5], // Minutes for other games
// // // // //     'Social Hub': [180, 120, 60], // 3hr, 2hr, 1hr in minutes
// // // // //     'Party Room': [180, 120, 60], // 3hr, 2hr, 1hr in minutes
// // // // //   };

// // // // //   @override
// // // // //   Widget build(BuildContext context) {
// // // // //     return Scaffold(
// // // // //       appBar: AppBar(title: Text('Arcade Game Manager')),
// // // // //       body: ListView(
// // // // //         children: games.entries.map((entry) {
// // // // //           return Column(
// // // // //             crossAxisAlignment: CrossAxisAlignment.start,
// // // // //             children: [
// // // // //               Padding(
// // // // //                 padding: const EdgeInsets.all(8.0),
// // // // //                 child: Text(
// // // // //                   entry.key,
// // // // //                   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
// // // // //                 ),
// // // // //               ),
// // // // //               Wrap(
// // // // //                 children: entry.value.map((slot) {
// // // // //                   return Obx(() => GestureDetector(
// // // // //                         onTap: () {
// // // // //                           Get.defaultDialog(
// // // // //                             title: 'Table Details',
// // // // //                             content: Column(
// // // // //                               children: [
// // // // //                                 Align(
// // // // //                                   alignment: Alignment.topRight,
// // // // //                                   child: IconButton(
// // // // //                                     icon: Icon(Icons.close),
// // // // //                                     onPressed: () {
// // // // //                                       Get.back();
// // // // //                                     },
// // // // //                                   ),
// // // // //                                 ),
// // // // //                                 Text(
// // // // //                                   'Table ${entry.value.indexOf(slot) + 1}',
// // // // //                                   style: TextStyle(fontSize: 16),
// // // // //                                 ),
// // // // //                                 if (!slot.isActive.value &&
// // // // //                                     (entry.key == 'Social Hub' || entry.key == 'Party Room'))
// // // // //                                   Obx(() => DropdownButton<int>(
// // // // //                                         hint: Text('Select Time'),
// // // // //                                         value: slot.selectedTime.value,
// // // // //                                         items: timeOptions[entry.key]!.map((int value) {
// // // // //                                           return DropdownMenuItem<int>(
// // // // //                                             value: value,
// // // // //                                             child: Text('${(value / 60).floor()} hr ${(value % 60)} min'),
// // // // //                                           );
// // // // //                                         }).toList(),
// // // // //                                         onChanged: (int? newValue) {
// // // // //                                           slot.selectedTime.value = newValue;
// // // // //                                         },
// // // // //                                       )),
// // // // //                                 if (!slot.isActive.value &&
// // // // //                                     entry.key != 'Social Hub' &&
// // // // //                                     entry.key != 'Party Room')
// // // // //                                   Obx(() => DropdownButton<int>(
// // // // //                                         hint: Text('Select Time'),
// // // // //                                         value: slot.selectedTime.value,
// // // // //                                         items: timeOptions['default']!.map((int value) {
// // // // //                                           return DropdownMenuItem<int>(
// // // // //                                             value: value,
// // // // //                                             child: Text('$value min'),
// // // // //                                           );
// // // // //                                         }).toList(),
// // // // //                                         onChanged: (int? newValue) {
// // // // //                                           slot.selectedTime.value = newValue;
// // // // //                                         },
// // // // //                                       )),
// // // // //                                 ElevatedButton(
// // // // //                                   onPressed: () {
// // // // //                                     if (slot.isActive.value) {
// // // // //                                       slot.stopTimer();
// // // // //                                     } else {
// // // // //                                       if (slot.selectedTime.value != null) {
// // // // //                                         slot.startTimer(slot.selectedTime.value!);
// // // // //                                       }
// // // // //                                     }
// // // // //                                   },
// // // // //                                   child: Text(slot.isActive.value ? 'Stop' : 'Start'),
// // // // //                                 ),
// // // // //                                 if (slot.timeRemaining.value != null)
// // // // //                                   Text(
// // // // //                                     '${formatTime(slot.timeRemaining.value!)}',
// // // // //                                     style: TextStyle(fontSize: 16, color: Colors.black),
// // // // //                                   ),
// // // // //                               ],
// // // // //                             ),
// // // // //                           );
// // // // //                         },
// // // // //                         child: Card(
// // // // //                           color: slot.isActive.value
// // // // //                               ? Colors.green
// // // // //                               : (slot.timeRemaining.value == null ? Colors.white : Colors.red),
// // // // //                           margin: EdgeInsets.all(8.0),
// // // // //                           child: Padding(
// // // // //                             padding: const EdgeInsets.all(8.0),
// // // // //                             child: Column(
// // // // //                               children: [
// // // // //                                 Text(
// // // // //                                   slot.isActive.value
// // // // //                                       ? '${formatTime(slot.timeRemaining.value!)}'
// // // // //                                       : 'Table ${entry.value.indexOf(slot) + 1}',
// // // // //                                   style: TextStyle(fontSize: 16),
// // // // //                                 ),
// // // // //                               ],
// // // // //                             ),
// // // // //                           ),
// // // // //                         ),
// // // // //                       ));
// // // // //                 }).toList(),
// // // // //               ),
// // // // //             ],
// // // // //           );
// // // // //         }).toList(),
// // // // //       ),
// // // // //     );
// // // // //   }

// // // // //   String formatTime(Duration duration) {
// // // // //     if (duration.inHours > 0) {
// // // // //       return '${duration.inHours}:${(duration.inMinutes % 60).toString().padLeft(2, '0')}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
// // // // //     } else {
// // // // //       return '${(duration.inMinutes % 60).toString().padLeft(2, '0')}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
// // // // //     }
// // // // //   }
// // // // // }

// // // // // class Slot {
// // // // //   var isActive = false.obs;
// // // // //   var timeRemaining = Rx<Duration?>(null);
// // // // //   Timer? _timer;
// // // // //   var selectedTime = Rx<int?>(null);
// // // // //   final AudioPlayer player = AudioPlayer(); // Initialize AudioPlayer

// // // // //   Future<void> startTimer(int minutes) async {
// // // // //     timeRemaining.value = Duration(minutes: minutes);
// // // // //     isActive.value = true;
// // // // //     _timer = Timer.periodic(Duration(seconds: 1), (timer) {
// // // // //       if (timeRemaining.value!.inSeconds > 0) {
// // // // //         timeRemaining.value = Duration(seconds: timeRemaining.value!.inSeconds - 1);
// // // // //       } else {
// // // // //         isActive.value = false;
// // // // //         timer.cancel();
// // // // //         playSound(); // Play sound when timer finishes
// // // // //         Get.defaultDialog(
// // // // //           title: 'Time\'s Up!',
// // // // //           content: Text('Your gaming time is over.'),
// // // // //         );
// // // // //       }
// // // // //     });
// // // // //   }

// // // // //   void stopTimer() {
// // // // //     _timer?.cancel();
// // // // //     isActive.value = false;
// // // // //     timeRemaining.value = null;
// // // // //   }

// // // // //   void playSound() async {
// // // // //     await player.setAsset('assets/alert.mp3'); // Load sound file from assets
// // // // //     await player.play(); // Play the loaded sound file
// // // // //   }
// // // // // }

// // // // import 'dart:async';
// // // // import 'package:flutter/material.dart';
// // // // import 'package:get/get.dart';
// // // // import 'package:just_audio/just_audio.dart';

// // // // void main() {
// // // //   runApp(ArcadeManagerApp());
// // // // }

// // // // class ArcadeManagerApp extends StatelessWidget {
// // // //   @override
// // // //   Widget build(BuildContext context) {
// // // //     return GetMaterialApp(
// // // //       home: HomePage(),
// // // //     );
// // // //   }
// // // // }

// // // // class HomePage extends StatelessWidget {
// // // //   final Map<String, List<Slot>> games = {
// // // //     'Pool': List.generate(10, (_) => Slot()),
// // // //     'Snooker': List.generate(6, (_) => Slot()),
// // // //     'Table Tennis': List.generate(3, (_) => Slot()),
// // // //     'PS-5': List.generate(5, (_) => Slot()),
// // // //     'PS-4': List.generate(5, (_) => Slot()),
// // // //     'LAN Gaming': List.generate(10, (_) => Slot()),
// // // //     'Social Hub': List.generate(1, (_) => Slot()),
// // // //     'Party Room': List.generate(1, (_) => Slot()),
// // // //   };

// // // //   final Map<String, List<int>> timeOptions = {
// // // //     'default': [60, 30, 15, 5], // Minutes for other games
// // // //     'Social Hub': [180, 120, 60], // 3hr, 2hr, 1hr in minutes
// // // //     'Party Room': [180, 120, 60], // 3hr, 2hr, 1hr in minutes
// // // //   };

// // // //   @override
// // // //   Widget build(BuildContext context) {
// // // //     return Scaffold(
// // // //       appBar: AppBar(title: Text('Arcade Game Manager')),
// // // //       body: ListView(
// // // //         children: games.entries.map((entry) {
// // // //           return Column(
// // // //             crossAxisAlignment: CrossAxisAlignment.start,
// // // //             children: [
// // // //               Padding(
// // // //                 padding: const EdgeInsets.all(8.0),
// // // //                 child: Text(
// // // //                   entry.key,
// // // //                   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
// // // //                 ),
// // // //               ),
// // // //               Wrap(
// // // //                 children: entry.value.map((slot) {
// // // //                   return Obx(() => GestureDetector(
// // // //                         onTap: () {
// // // //                           Get.defaultDialog(
// // // //                             title: 'Table Details',
// // // //                             content: Column(
// // // //                               children: [
// // // //                                 Align(
// // // //                                   alignment: Alignment.topRight,
// // // //                                   child: IconButton(
// // // //                                     icon: Icon(Icons.close),
// // // //                                     onPressed: () {
// // // //                                       Get.back();
// // // //                                     },
// // // //                                   ),
// // // //                                 ),
// // // //                                 Text(
// // // //                                   'Table ${entry.value.indexOf(slot) + 1}',
// // // //                                   style: TextStyle(fontSize: 16),
// // // //                                 ),
// // // //                                 if (!slot.isActive.value &&
// // // //                                     (entry.key == 'Social Hub' || entry.key == 'Party Room'))
// // // //                                   Obx(() => DropdownButton<int>(
// // // //                                         hint: Text('Select Time'),
// // // //                                         value: slot.selectedTime.value,
// // // //                                         items: timeOptions[entry.key]!.map((int value) {
// // // //                                           return DropdownMenuItem<int>(
// // // //                                             value: value,
// // // //                                             child: Text('${(value / 60).floor()} hr ${(value % 60)} min'),
// // // //                                           );
// // // //                                         }).toList(),
// // // //                                         onChanged: (int? newValue) {
// // // //                                           slot.selectedTime.value = newValue;
// // // //                                         },
// // // //                                       )),
// // // //                                 if (!slot.isActive.value &&
// // // //                                     entry.key != 'Social Hub' &&
// // // //                                     entry.key != 'Party Room')
// // // //                                   Obx(() => DropdownButton<int>(
// // // //                                         hint: Text('Select Time'),
// // // //                                         value: slot.selectedTime.value,
// // // //                                         items: timeOptions['default']!.map((int value) {
// // // //                                           return DropdownMenuItem<int>(
// // // //                                             value: value,
// // // //                                             child: Text('$value min'),
// // // //                                           );
// // // //                                         }).toList(),
// // // //                                         onChanged: (int? newValue) {
// // // //                                           slot.selectedTime.value = newValue;
// // // //                                         },
// // // //                                       )),
// // // //                                 ElevatedButton(
// // // //                                   onPressed: () {
// // // //                                     if (slot.isActive.value) {
// // // //                                       slot.stopTimer();
// // // //                                     } else {
// // // //                                       if (slot.selectedTime.value != null) {
// // // //                                         slot.startTimer(slot.selectedTime.value!);
// // // //                                       }
// // // //                                     }
// // // //                                   },
// // // //                                   child: Text(slot.isActive.value ? 'Stop' : 'Start'),
// // // //                                 ),
// // // //                                 if (slot.timeRemaining.value != null)
// // // //                                   Text(
// // // //                                     '${formatTime(slot.timeRemaining.value!)}',
// // // //                                     style: TextStyle(fontSize: 16, color: Colors.black),
// // // //                                   ),
// // // //                               ],
// // // //                             ),
// // // //                           );
// // // //                         },
// // // //                         child: Card(
// // // //                           color: slot.isActive.value
// // // //                               ? Colors.green
// // // //                               : (slot.timeRemaining.value == null ? Colors.white : Colors.red),
// // // //                           margin: EdgeInsets.all(8.0),
// // // //                           child: Padding(
// // // //                             padding: const EdgeInsets.all(8.0),
// // // //                             child: Column(
// // // //                               children: [
// // // //                                 Text(
// // // //                                   slot.isActive.value
// // // //                                       ? '${formatTime(slot.timeRemaining.value!)}'
// // // //                                       : 'Table ${entry.value.indexOf(slot) + 1}',
// // // //                                   style: TextStyle(fontSize: 16),
// // // //                                 ),
// // // //                               ],
// // // //                             ),
// // // //                           ),
// // // //                         ),
// // // //                       ));
// // // //                 }).toList(),
// // // //               ),
// // // //             ],
// // // //           );
// // // //         }).toList(),
// // // //       ),
// // // //       floatingActionButton: FloatingActionButton(
// // // //         onPressed: () {
// // // //           Get.defaultDialog(
// // // //             title: 'Advanced Booking',
// // // //             content: Container(
// // // //               width: double.maxFinite,
// // // //               child: Column(
// // // //                 mainAxisSize: MainAxisSize.min,
// // // //                 crossAxisAlignment: CrossAxisAlignment.start,
// // // //                 children: [
// // // //                   Text('Name:'),
// // // //                   TextFormField(
// // // //                     decoration: InputDecoration(
// // // //                       hintText: 'Enter your name',
// // // //                     ),
// // // //                   ),
// // // //                   SizedBox(height: 10),
// // // //                   Text('Game:'),
// // // //                   DropdownButton<String>(
// // // //                     value: 'Pool', // Default value
// // // //                     onChanged: (String? newValue) {},
// // // //                     items: games.keys.map((String game) {
// // // //                       return DropdownMenuItem<String>(
// // // //                         value: game,
// // // //                         child: Text(game),
// // // //                       );
// // // //                     }).toList(),
// // // //                   ),
// // // //                   SizedBox(height: 10),
// // // //                   Text('Table:'),
// // // //                   DropdownButton<int>(
// // // //                     hint: Text('Select Table'),
// // // //                     onChanged: (int? newValue) {},
// // // //                     items: List.generate(10, (index) {
// // // //                       return DropdownMenuItem<int>(
// // // //                         value: index + 1,
// // // //                         child: Text('Table ${index + 1}'),
// // // //                       );
// // // //                     }),
// // // //                   ),
// // // //                   SizedBox(height: 10),
// // // //                   Text('Hours:'),
// // // //                   DropdownButton<int>(
// // // //                     hint: Text('Select Hours'),
// // // //                     onChanged: (int? newValue) {},
// // // //                     items: [1, 2, 3, 4, 5].map((int value) {
// // // //                       return DropdownMenuItem<int>(
// // // //                         value: value,
// // // //                         child: Text('$value hr'),
// // // //                       );
// // // //                     }).toList(),
// // // //                   ),
// // // //                   SizedBox(height: 20),
// // // //                   Align(
// // // //                     alignment: Alignment.center,
// // // //                     child: ElevatedButton(
// // // //                       onPressed: () {
// // // //                         // Implement booking logic here
// // // //                         Get.back();
// // // //                       },
// // // //                       child: Text('Book Now'),
// // // //                     ),
// // // //                   ),
// // // //                 ],
// // // //               ),
// // // //             ),
// // // //           );
// // // //         },
// // // //         child: Icon(Icons.add),
// // // //       ),
// // // //     );
// // // //   }

// // // //   String formatTime(Duration duration) {
// // // //     if (duration.inHours > 0) {
// // // //       return '${duration.inHours}:${(duration.inMinutes % 60).toString().padLeft(2, '0')}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
// // // //     } else {
// // // //       return '${(duration.inMinutes % 60).toString().padLeft(2, '0')}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
// // // //     }
// // // //   }
// // // // }

// // // // class Slot {
// // // //   var isActive = false.obs;
// // // //   var timeRemaining = Rx<Duration?>(null);
// // // //   Timer? _timer;
// // // //   var selectedTime = Rx<int?>(null);
// // // //   final AudioPlayer player = AudioPlayer(); // Initialize AudioPlayer

// // // //   Future<void> startTimer(int minutes) async {
// // // //     timeRemaining.value = Duration(minutes: minutes);
// // // //     isActive.value = true;
// // // //     _timer = Timer.periodic(Duration(seconds: 1), (timer) {
// // // //       if (timeRemaining.value!.inSeconds > 0) {
// // // //         timeRemaining.value = Duration(seconds: timeRemaining.value!.inSeconds - 1);
// // // //       } else {
// // // //         isActive.value = false;
// // // //         timer.cancel();
// // // //         playSound(); // Play sound when timer finishes
// // // //         Get.defaultDialog(
// // // //           title: 'Time\'s Up!',
// // // //           content: Text('Your gaming time is over.'),
// // // //         );
// // // //       }
// // // //     });
// // // //   }

// // // //   void stopTimer() {
// // // //     _timer?.cancel();
// // // //     isActive.value = false;
// // // //     timeRemaining.value = null;
// // // //   }

// // // //   void playSound() async {
// // // //     await player.setAsset('assets/alert.mp3'); // Load sound file from assets
// // // //     await player.play(); // Play the loaded sound file
// // // //   }
// // // // }

// // // import 'package:flutter/material.dart';
// // // import 'package:get/get.dart';
// // // import 'package:just_audio/just_audio.dart'; // Import JustAudioPlayer
// // // import 'dart:async';

// // // void main() {
// // //   runApp(ArcadeManagerApp());
// // // }

// // // class ArcadeManagerApp extends StatefulWidget {
// // //   @override
// // //   State<ArcadeManagerApp> createState() => _ArcadeManagerAppState();
// // // }

// // // class _ArcadeManagerAppState extends State<ArcadeManagerApp> {
// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return GetMaterialApp(
// // //       home: HomePage(),
// // //     );
// // //   }
// // // }

// // // class HomePage extends StatefulWidget {
// // //   @override
// // //   _HomePageState createState() => _HomePageState();
// // // }

// // // class _HomePageState extends State<HomePage> {
// // //   final Map<String, List<Slot>> games = {
// // //     'Pool': List.generate(10, (_) => Slot()),
// // //     'Snooker': List.generate(6, (_) => Slot()),
// // //     'Table Tennis': List.generate(3, (_) => Slot()),
// // //     'PS-5': List.generate(5, (_) => Slot()),
// // //     'PS-4': List.generate(5, (_) => Slot()),
// // //     'LAN Gaming': List.generate(10, (_) => Slot()),
// // //     'Social Hub': List.generate(1, (_) => Slot()),
// // //     'Party Room': List.generate(1, (_) => Slot()),
// // //   };

// // //   final Map<String, List<int>> timeOptions = {
// // //     'default': [60, 30, 15, 5], // Minutes for other games
// // //     'Social Hub': [180, 120, 60], // 3hr, 2hr, 1hr in minutes
// // //     'Party Room': [180, 120, 60], // 3hr, 2hr, 1hr in minutes
// // //   };

// // //   Map<String, List<AdvanceBooking>> advanceBookings = {}; // Map to store advance bookings

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Scaffold(
// // //       appBar: AppBar(title: Text('Arcade Game Manager')),
// // //       body: ListView(
// // //         children: games.entries.map((entry) {
// // //           return Column(
// // //             crossAxisAlignment: CrossAxisAlignment.start,
// // //             children: [
// // //               Padding(
// // //                 padding: const EdgeInsets.all(8.0),
// // //                 child: Text(
// // //                   entry.key,
// // //                   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
// // //                 ),
// // //               ),
// // //               Wrap(
// // //                 children: entry.value.map((slot) {
// // //                   return Obx(() => GestureDetector(
// // //                         onTap: () {
// // //                           Get.defaultDialog(
// // //                             title: 'Table Details',
// // //                             content: Column(
// // //                               children: [
// // //                                 Align(
// // //                                   alignment: Alignment.topRight,
// // //                                   child: IconButton(
// // //                                     icon: Icon(Icons.close),
// // //                                     onPressed: () {
// // //                                       Get.back();
// // //                                     },
// // //                                   ),
// // //                                 ),
// // //                                 Text(
// // //                                   'Table ${entry.value.indexOf(slot) + 1}',
// // //                                   style: TextStyle(fontSize: 16),
// // //                                 ),
// // //                                 if (!slot.isActive.value &&
// // //                                     (entry.key == 'Social Hub' || entry.key == 'Party Room'))
// // //                                   Obx(() => DropdownButton<int>(
// // //                                         hint: Text('Select Time'),
// // //                                         value: slot.selectedTime.value,
// // //                                         items: timeOptions[entry.key]!.map((int value) {
// // //                                           return DropdownMenuItem<int>(
// // //                                             value: value,
// // //                                             child: Text('${(value / 60).floor()} hr ${(value % 60)} min'),
// // //                                           );
// // //                                         }).toList(),
// // //                                         onChanged: (int? newValue) {
// // //                                           slot.selectedTime.value = newValue;
// // //                                         },
// // //                                       )),
// // //                                 if (!slot.isActive.value &&
// // //                                     entry.key != 'Social Hub' &&
// // //                                     entry.key != 'Party Room')
// // //                                   Obx(() => DropdownButton<int>(
// // //                                         hint: Text('Select Time'),
// // //                                         value: slot.selectedTime.value,
// // //                                         items: timeOptions['default']!.map((int value) {
// // //                                           return DropdownMenuItem<int>(
// // //                                             value: value,
// // //                                             child: Text('$value min'),
// // //                                           );
// // //                                         }).toList(),
// // //                                         onChanged: (int? newValue) {
// // //                                           slot.selectedTime.value = newValue;
// // //                                         },
// // //                                       )),
// // //                                 ElevatedButton(
// // //                                   onPressed: () {
// // //                                     if (slot.isActive.value) {
// // //                                       slot.stopTimer();
// // //                                     } else {
// // //                                       if (slot.selectedTime.value != null) {
// // //                                         slot.startTimer(slot.selectedTime.value!);
// // //                                       }
// // //                                     }
// // //                                   },
// // //                                   child: Text(slot.isActive.value ? 'Stop' : 'Start'),
// // //                                 ),
// // //                                 if (slot.timeRemaining.value != null)
// // //                                   Text(
// // //                                     '${formatTime(slot.timeRemaining.value!)}',
// // //                                     style: TextStyle(fontSize: 16, color: Colors.black),
// // //                                   ),
// // //                               ],
// // //                             ),
// // //                           );
// // //                         },
// // //                         child: Card(
// // //                           color: slot.isActive.value
// // //                               ? Colors.green
// // //                               : (slot.timeRemaining.value == null ? Colors.white : Colors.red),
// // //                           margin: EdgeInsets.all(8.0),
// // //                           child: Padding(
// // //                             padding: const EdgeInsets.all(8.0),
// // //                             child: Column(
// // //                               children: [
// // //                                 Text(
// // //                                   slot.isActive.value
// // //                                       ? '${formatTime(slot.timeRemaining.value!)}'
// // //                                       : 'Table ${entry.value.indexOf(slot) + 1}',
// // //                                   style: TextStyle(fontSize: 16),
// // //                                 ),
// // //                               ],
// // //                             ),
// // //                           ),
// // //                         ),
// // //                       ));
// // //                 }).toList(),
// // //               ),
// // //             ],
// // //           );
// // //         }).toList(),
// // //       ),
// // //       floatingActionButton: FloatingActionButton(
// // //         onPressed: () {
// // //           Get.defaultDialog(
// // //             title: 'Advanced Booking',
// // //             content: Container(
// // //               width: double.maxFinite,
// // //               child: Column(
// // //                 mainAxisSize: MainAxisSize.min,
// // //                 crossAxisAlignment: CrossAxisAlignment.start,
// // //                 children: [
// // //                   Text('Name:'),
// // //                   TextFormField(
// // //                     decoration: InputDecoration(
// // //                       hintText: 'Enter your name',
// // //                     ),
// // //                   ),
// // //                   SizedBox(height: 10),
// // //                   Text('Game:'),
// // //                   DropdownButton<String>(
// // //                     value: 'Pool', // Default value
// // //                     onChanged: (String? newValue) {},
// // //                     items: games.keys.map((String game) {
// // //                       return DropdownMenuItem<String>(
// // //                         value: game,
// // //                         child: Text(game),
// // //                       );
// // //                     }).toList(),
// // //                   ),
// // //                   SizedBox(height: 10),
// // //                   Text('Table:'),
// // //                   DropdownButton<int>(
// // //                     hint: Text('Select Table'),
// // //                     onChanged: (int? newValue) {},
// // //                     items: List.generate(10, (index) {
// // //                       return DropdownMenuItem<int>(
// // //                         value: index + 1,
// // //                         child: Text('Table ${index + 1}'),
// // //                       );
// // //                     }),
// // //                   ),
// // //                   SizedBox(height: 10),
// // //                   Text('Hours:'),
// // //                   DropdownButton<int>(
// // //                     hint: Text('Select Hours'),
// // //                     onChanged: (int? newValue) {},
// // //                     items: [1, 2, 3, 4, 5].map((int value) {
// // //                       return DropdownMenuItem<int>(
// // //                         value: value,
// // //                         child: Text('$value hr'),
// // //                       );
// // //                     }).toList(),
// // //                   ),
// // //                   SizedBox(height: 20),
// // //                   Align(
// // //                     alignment: Alignment.center,
// // //                     child: ElevatedButton(
// // //                       onPressed: () {
// // //                         // Implement booking logic here
// // //                         final name = 'John Doe'; // Replace with actual name input
// // //                         final game = 'Pool'; // Replace with selected game
// // //                         final table = 1; // Replace with selected table number
// // //                         final hours = 2; // Replace with selected hours

// // //                         final booking = AdvanceBooking(name: name, game: game, table: table, hours: hours);
// // //                         if (advanceBookings.containsKey(game)) {
// // //                           advanceBookings[game]!.add(booking);
// // //                         } else {
// // //                           advanceBookings[game] = [booking];
// // //                         }

// // //                         Get.back();
// // //                       },
// // //                       child: Text('Book Now'),
// // //                     ),
// // //                   ),
// // //                 ],
// // //               ),
// // //             ),
// // //           );
// // //         },
// // //         child: Icon(Icons.add),
// // //       ),
// // //       drawer: Drawer(
// // //         child: ListView(
// // //           padding: EdgeInsets.zero,
// // //           children: <Widget>[
// // //             DrawerHeader(
// // //               decoration: BoxDecoration(
// // //                 color: Colors.blue,
// // //               ),
// // //               child: Text(
// // //                 'Advance Bookings',
// // //                 style: TextStyle(
// // //                   color: Colors.white,
// // //                   fontSize: 24,
// // //                 ),
// // //               ),
// // //             ),
// // //             ListTile(
// // //               title: Text('Toggle Advanced Bookings'),
// // //               onTap: () {
// // //                 Get.defaultDialog(
// // //                   title: 'Advance Bookings List',
// // //                   content: Container(
// // //                     width: double.maxFinite,
// // //                     child: ListView.builder(
// // //                       itemCount: advanceBookings.length,
// // //                       itemBuilder: (BuildContext context, int index) {
// // //                         final game = advanceBookings.keys.toList()[index];
// // //                         final bookings = advanceBookings[game]!;
// // //                         return ExpansionTile(
// // //                           title: Text(game),
// // //                           children: bookings.map((booking) {
// // //                             return ListTile(
// // //                               title: Text('Table ${booking.table} - ${booking.name} - ${booking.hours} hr'),
// // //                             );
// // //                           }).toList(),
// // //                         );
// // //                       },
// // //                     ),
// // //                   ),
// // //                 );
// // //               },
// // //             ),
// // //           ],
// // //         ),
// // //       ),
// // //     );
// // //   }

// // //   String formatTime(Duration duration) {
// // //     if (duration.inHours > 0) {
// // //       return '${duration.inHours}:${(duration.inMinutes % 60).toString().padLeft(2, '0')}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
// // //     } else {
// // //       return '${(duration.inMinutes % 60).toString().padLeft(2, '0')}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
// // //     }
// // //   }
// // // }

// // // class Slot {
// // //   var isActive = false.obs;
// // //   var timeRemaining = Rx<Duration?>(null);
// // //   Timer? _timer;
// // //   var selectedTime = Rx<int?>(null);
// // //   final AudioPlayer player = AudioPlayer(); // Initialize AudioPlayer

// // //   Future<void> startTimer(int minutes) async {
// // //     timeRemaining.value = Duration(minutes: minutes);
// // //     isActive.value = true;
// // //     _timer = Timer.periodic(Duration(seconds: 1), (timer) {
// // //       if (timeRemaining.value!.inSeconds > 0) {
// // //         timeRemaining.value = Duration(seconds: timeRemaining.value!.inSeconds - 1);
// // //       } else {
// // //         isActive.value = false;
// // //         timer.cancel();
// // //         playSound(); // Play sound when timer finishes
// // //         Get.defaultDialog(
// // //           title: 'Time\'s Up!',
// // //           content: Text('Your gaming time is over.'),
// // //         );
// // //       }
// // //     });
// // //   }

// // //   void stopTimer() {
// // //     _timer?.cancel();
// // //     isActive.value = false;
// // //     timeRemaining.value = null;
// // //   }

// // //   void playSound() async {
// // //     await player.setAsset('assets/alert.mp3'); // Load sound file from assets
// // //     await player.play(); // Play the loaded sound file
// // //   }
// // // }

// // // class AdvanceBooking {
// // //   final String name;
// // //   final String game;
// // //   final int table;
// // //   final int hours;

// // //   AdvanceBooking({
// // //     required this.name,
// // //     required this.game,
// // //     required this.table,
// // //     required this.hours,
// // //   });
// // // }

// // // import 'package:flutter/material.dart';
// // // import 'package:get/get.dart';
// // // import 'package:just_audio/just_audio.dart'; // Import JustAudioPlayer
// // // import 'dart:async';

// // // void main() {
// // //   runApp(ArcadeManagerApp());
// // // }

// // // class ArcadeManagerApp extends StatelessWidget {
// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return GetMaterialApp(
// // //       home: HomePage(),
// // //     );
// // //   }
// // // }

// // // class HomePage extends StatefulWidget {
// // //   @override
// // //   _HomePageState createState() => _HomePageState();
// // // }

// // // class _HomePageState extends State<HomePage> {
// // //   final Map<String, List<Slot>> games = {
// // //     'Pool': List.generate(10, (_) => Slot()),
// // //     'Snooker': List.generate(6, (_) => Slot()),
// // //     'Table Tennis': List.generate(3, (_) => Slot()),
// // //     'PS-5': List.generate(5, (_) => Slot()),
// // //     'PS-4': List.generate(5, (_) => Slot()),
// // //     'LAN Gaming': List.generate(10, (_) => Slot()),
// // //     'Social Hub': List.generate(1, (_) => Slot()),
// // //     'Party Room': List.generate(1, (_) => Slot()),
// // //   };

// // //   final Map<String, List<int>> timeOptions = {
// // //     'default': [60, 30, 15, 5], // Minutes for other games
// // //     'Social Hub': [180, 120, 60], // 3hr, 2hr, 1hr in minutes
// // //     'Party Room': [180, 120, 60], // 3hr, 2hr, 1hr in minutes
// // //   };

// // //   Map<String, List<AdvanceBooking>> advanceBookings =
// // //       {}; // Map to store advance bookings

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Scaffold(
// // //       appBar: AppBar(
// // //         title: Text('Arcade Game Manager'),
// // //         actions: [
// // //           IconButton(
// // //             icon: Icon(Icons.calendar_today),
// // //             onPressed: () {
// // //               Get.to(AdvanceBookingsScreen(advanceBookings: advanceBookings));
// // //             },
// // //           ),
// // //         ],
// // //       ),
// // //       body: ListView(
// // //         children: games.entries.map((entry) {
// // //           return Column(
// // //             crossAxisAlignment: CrossAxisAlignment.start,
// // //             children: [
// // //               Padding(
// // //                 padding: const EdgeInsets.all(8.0),
// // //                 child: Text(
// // //                   entry.key,
// // //                   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
// // //                 ),
// // //               ),
// // //               Wrap(
// // //                 children: entry.value.map((slot) {
// // //                   return Obx(() => GestureDetector(
// // //                         onTap: () {
// // //                           Get.defaultDialog(
// // //                             title: 'Table Details',
// // //                             content: Column(
// // //                               children: [
// // //                                 Align(
// // //                                   alignment: Alignment.topRight,
// // //                                   child: IconButton(
// // //                                     icon: Icon(Icons.close),
// // //                                     onPressed: () {
// // //                                       Get.back();
// // //                                     },
// // //                                   ),
// // //                                 ),
// // //                                 Text(
// // //                                   'Table ${entry.value.indexOf(slot) + 1}',
// // //                                   style: TextStyle(fontSize: 16),
// // //                                 ),
// // //                                 if (!slot.isActive.value &&
// // //                                     (entry.key == 'Social Hub' ||
// // //                                         entry.key == 'Party Room'))
// // //                                   Obx(() => DropdownButton<int>(
// // //                                         hint: Text('Select Time'),
// // //                                         value: slot.selectedTime.value,
// // //                                         items: timeOptions[entry.key]!
// // //                                             .map((int value) {
// // //                                           return DropdownMenuItem<int>(
// // //                                             value: value,
// // //                                             child: Text(
// // //                                                 '${(value / 60).floor()} hr ${(value % 60)} min'),
// // //                                           );
// // //                                         }).toList(),
// // //                                         onChanged: (int? newValue) {
// // //                                           slot.selectedTime.value = newValue;
// // //                                         },
// // //                                       )),
// // //                                 if (!slot.isActive.value &&
// // //                                     entry.key != 'Social Hub' &&
// // //                                     entry.key != 'Party Room')
// // //                                   Obx(() => DropdownButton<int>(
// // //                                         hint: Text('Select Time'),
// // //                                         value: slot.selectedTime.value,
// // //                                         items: timeOptions['default']!
// // //                                             .map((int value) {
// // //                                           return DropdownMenuItem<int>(
// // //                                             value: value,
// // //                                             child: Text('$value min'),
// // //                                           );
// // //                                         }).toList(),
// // //                                         onChanged: (int? newValue) {
// // //                                           slot.selectedTime.value = newValue;
// // //                                         },
// // //                                       )),
// // //                                 ElevatedButton(
// // //                                   onPressed: () {
// // //                                     if (slot.isActive.value) {
// // //                                       slot.stopTimer();
// // //                                     } else {
// // //                                       if (slot.selectedTime.value != null) {
// // //                                         slot.startTimer(
// // //                                             slot.selectedTime.value!);
// // //                                       }
// // //                                     }
// // //                                   },
// // //                                   child: Text(
// // //                                       slot.isActive.value ? 'Stop' : 'Start'),
// // //                                 ),
// // //                                 if (slot.timeRemaining.value != null)
// // //                                   Text(
// // //                                     '${formatTime(slot.timeRemaining.value!)}',
// // //                                     style: TextStyle(
// // //                                         fontSize: 16, color: Colors.black),
// // //                                   ),
// // //                               ],
// // //                             ),
// // //                           );
// // //                         },
// // //                         child: Card(
// // //                           color: slot.isActive.value
// // //                               ? Colors.green
// // //                               : (slot.timeRemaining.value == null
// // //                                   ? Colors.white
// // //                                   : Colors.red),
// // //                           margin: EdgeInsets.all(8.0),
// // //                           child: Padding(
// // //                             padding: const EdgeInsets.all(8.0),
// // //                             child: Column(
// // //                               children: [
// // //                                 Text(
// // //                                   slot.isActive.value
// // //                                       ? '${formatTime(slot.timeRemaining.value!)}'
// // //                                       : 'Table ${entry.value.indexOf(slot) + 1}',
// // //                                   style: TextStyle(fontSize: 16),
// // //                                 ),
// // //                               ],
// // //                             ),
// // //                           ),
// // //                         ),
// // //                       ));
// // //                 }).toList(),
// // //               ),
// // //             ],
// // //           );
// // //         }).toList(),
// // //       ),
// // //       floatingActionButton: FloatingActionButton(
// // //         onPressed: () {
// // //           Get.defaultDialog(
// // //             title: 'Advanced Booking',
// // //             content: Container(
// // //               width: double.maxFinite,
// // //               child: Column(
// // //                 mainAxisSize: MainAxisSize.min,
// // //                 crossAxisAlignment: CrossAxisAlignment.start,
// // //                 children: [
// // //                   Text('Name:'),
// // //                   TextFormField(
// // //                     decoration: InputDecoration(
// // //                       hintText: 'Enter your name',
// // //                     ),
// // //                     onChanged: (value) {
// // //                       // Implement logic to update name
// // //                     },
// // //                   ),
// // //                   SizedBox(height: 10),
// // //                   Text('Game:'),
// // //                   DropdownButton<String>(
// // //                     value: 'Pool', // Default value
// // //                     onChanged: (String? newValue) {
// // //                       // Implement logic to update game selection
// // //                     },
// // //                     items: games.keys.map((String game) {
// // //                       return DropdownMenuItem<String>(
// // //                         value: game,
// // //                         child: Text(game),
// // //                       );
// // //                     }).toList(),
// // //                   ),
// // //                   SizedBox(height: 10),
// // //                   Text('Table:'),
// // //                   DropdownButton<int>(
// // //                     hint: Text('Select Table'),
// // //                     onChanged: (int? newValue) {
// // //                       // Implement logic to update table selection
// // //                     },
// // //                     items: List.generate(10, (index) {
// // //                       return DropdownMenuItem<int>(
// // //                         value: index + 1,
// // //                         child: Text('Table ${index + 1}'),
// // //                       );
// // //                     }),
// // //                   ),
// // //                   SizedBox(height: 10),
// // //                   Text('Hours:'),
// // //                   DropdownButton<int>(
// // //                     hint: Text('Select Hours'),
// // //                     onChanged: (int? newValue) {
// // //                       // Implement logic to update hours selection
// // //                     },
// // //                     items: [1, 2, 3, 4, 5].map((int value) {
// // //                       return DropdownMenuItem<int>(
// // //                         value: value,
// // //                         child: Text('$value hr'),
// // //                       );
// // //                     }).toList(),
// // //                   ),
// // //                   SizedBox(height: 20),
// // //                   Align(
// // //                     alignment: Alignment.center,
// // //                     child: ElevatedButton(
// // //                       onPressed: () {
// // //                         // Implement booking logic here
// // //                         final name = ''; // Retrieve name from TextFormField
// // //                         final game = 'Pool'; // Replace with selected game
// // //                         final table = 1; // Replace with selected table number
// // //                         final hours = 2; // Replace with selected hours

// // //                         final booking = AdvanceBooking(
// // //                             name: name, game: game, table: table, hours: hours);
// // //                         if (advanceBookings.containsKey(game)) {
// // //                           advanceBookings[game]!.add(booking);
// // //                         } else {
// // //                           advanceBookings[game] = [booking];
// // //                         }

// // //                         Get.back();
// // //                       },
// // //                       child: Text('Book Now'),
// // //                     ),
// // //                   ),
// // //                 ],
// // //               ),
// // //             ),
// // //           );
// // //         },
// // //         child: Icon(Icons.add),
// // //       ),
// // //       drawer: Drawer(
// // //         child: ListView(
// // //           padding: EdgeInsets.zero,
// // //           children: <Widget>[
// // //             DrawerHeader(
// // //               decoration: BoxDecoration(
// // //                 color: Colors.blue,
// // //               ),
// // //               child: Text(
// // //                 'Advanced Bookings',
// // //                 style: TextStyle(
// // //                   color: Colors.white,
// // //                   fontSize: 24,
// // //                 ),
// // //               ),
// // //             ),
// // //             ListTile(
// // //               title: Text('Advance Bookings List'),
// // //               onTap: () {
// // //                 Get.to(AdvanceBookingsScreen(advanceBookings: advanceBookings));
// // //               },
// // //             ),
// // //           ],
// // //         ),
// // //       ),
// // //     );
// // //   }

// // //   String formatTime(Duration duration) {
// // //     if (duration.inHours > 0) {
// // //       return '${duration.inHours}:${(duration.inMinutes % 60).toString().padLeft(2, '0')}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
// // //     } else {
// // //       return '${(duration.inMinutes % 60).toString().padLeft(2, '0')}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
// // //     }
// // //   }
// // // }

// // // class Slot {
// // //   var isActive = false.obs;
// // //   var timeRemaining = Rx<Duration?>(null);
// // //   Timer? _timer;
// // //   var selectedTime = Rx<int?>(null);
// // //   final AudioPlayer player = AudioPlayer(); // Initialize AudioPlayer

// // //   Future<void> startTimer(int minutes) async {
// // //     timeRemaining.value = Duration(minutes: minutes);
// // //     isActive.value = true;
// // //     _timer = Timer.periodic(Duration(seconds: 1), (timer) {
// // //       if (timeRemaining.value!.inSeconds > 0) {
// // //         timeRemaining.value =
// // //             Duration(seconds: timeRemaining.value!.inSeconds - 1);
// // //       } else {
// // //         isActive.value = false;
// // //         timer.cancel();
// // //         playSound(); // Play sound when timer finishes
// // //         Get.defaultDialog(
// // //           title: 'Time\'s Up!',
// // //           content: Text('Your gaming time is over.'),
// // //         );
// // //       }
// // //     });
// // //   }

// // //   void stopTimer() {
// // //     _timer?.cancel();
// // //     isActive.value = false;
// // //     timeRemaining.value = null;
// // //   }

// // //   void playSound() async {
// // //     await player.setAsset('assets/alert.mp3'); // Load sound file from assets
// // //     await player.play(); // Play the loaded sound file
// // //   }
// // // }

// // // class AdvanceBooking {
// // //   final String name;
// // //   final String game;
// // //   final int table;
// // //   final int hours;

// // //   AdvanceBooking({
// // //     required this.name,
// // //     required this.game,
// // //     required this.table,
// // //     required this.hours,
// // //   });
// // // }

// // // class AdvanceBookingsScreen extends StatelessWidget {
// // //   final Map<String, List<AdvanceBooking>> advanceBookings;

// // //   const AdvanceBookingsScreen({Key? key, required this.advanceBookings})
// // //       : super(key: key);

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Scaffold(
// // //       appBar: AppBar(
// // //         title: Text('Advanced Bookings'),
// // //       ),
// // //       body: ListView(
// // //         children: advanceBookings.entries.map((entry) {
// // //           return ExpansionTile(
// // //             title: Text(entry.key),
// // //             children: entry.value.map((booking) {
// // //               return ListTile(
// // //                 title: Text(
// // //                     '${booking.name} booked Table ${booking.table} for ${booking.hours} hours'),
// // //               );
// // //             }).toList(),
// // //           );
// // //         }).toList(),
// // //       ),
// // //     );
// // //   }
// // // }

// // import 'package:flutter/material.dart';
// // import 'package:get/get.dart';
// // import 'package:just_audio/just_audio.dart'; // Import JustAudioPlayer
// // import 'dart:async';

// // void main() {
// //   runApp(ArcadeManagerApp());
// // }

// // class ArcadeManagerApp extends StatefulWidget {
// //   @override
// //   State<ArcadeManagerApp> createState() => _ArcadeManagerAppState();
// // }

// // class _ArcadeManagerAppState extends State<ArcadeManagerApp> {
// //   @override
// //   Widget build(BuildContext context) {
// //     return GetMaterialApp(
// //       home: HomePage(),
// //     );
// //   }
// // }

// // class HomePage extends StatefulWidget {
// //   @override
// //   _HomePageState createState() => _HomePageState();
// // }

// // class _HomePageState extends State<HomePage> {
// //   final Map<String, List<Slot>> games = {
// //     'Pool': List.generate(10, (_) => Slot()),
// //     'Snooker': List.generate(6, (_) => Slot()),
// //     'Table Tennis': List.generate(3, (_) => Slot()),
// //     'PS-5': List.generate(5, (_) => Slot()),
// //     'PS-4': List.generate(5, (_) => Slot()),
// //     'LAN Gaming': List.generate(10, (_) => Slot()),
// //     'Social Hub': List.generate(1, (_) => Slot()),
// //     'Party Room': List.generate(1, (_) => Slot()),
// //   };

// //   final Map<String, List<int>> timeOptions = {
// //     'default': [60, 30, 15, 5], // Minutes for other games
// //     'Social Hub': [180, 120, 60], // 3hr, 2hr, 1hr in minutes
// //     'Party Room': [180, 120, 60], // 3hr, 2hr, 1hr in minutes
// //   };

// //   Map<String, List<AdvanceBooking>> advanceBookings =
// //       {}; // Map to store advance bookings

// //   // Controllers for input fields
// //   final nameController = TextEditingController();
// //   final gameController = TextEditingController();
// //   final tableController = TextEditingController();
// //   final hoursController = TextEditingController();

// //   @override
// //   void dispose() {
// //     // Clean up controllers
// //     nameController.dispose();
// //     gameController.dispose();
// //     tableController.dispose();
// //     hoursController.dispose();
// //     super.dispose();
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text('Arcade Game Manager'),
// //         actions: [
// //           // IconButton(
// //           //   icon: Icon(Icons.calendar_today),
// //           //   onPressed: () {
// //           //     Get.to(AdvanceBookingsScreen(advanceBookings: advanceBookings));
// //           //   },
// //           // ),
// //         ],
// //       ),
// //       body: ListView(
// //         children: games.entries.map((entry) {
// //           return Column(
// //             crossAxisAlignment: CrossAxisAlignment.start,
// //             children: [
// //               Padding(
// //                 padding: const EdgeInsets.all(8.0),
// //                 child: Text(
// //                   entry.key,
// //                   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
// //                 ),
// //               ),
// //               Wrap(
// //                 children: entry.value.map((slot) {
// //                   return Obx(() => GestureDetector(
// //                         onTap: () {
// //                           Get.defaultDialog(
// //                             title: 'Table Details',
// //                             content: Column(
// //                               children: [
// //                                 Align(
// //                                   alignment: Alignment.topRight,
// //                                   child: IconButton(
// //                                     icon: Icon(Icons.close),
// //                                     onPressed: () {
// //                                       Get.back();
// //                                     },
// //                                   ),
// //                                 ),
// //                                 Text(
// //                                   'Table ${entry.value.indexOf(slot) + 1}',
// //                                   style: TextStyle(fontSize: 16),
// //                                 ),
// //                                 if (!slot.isActive.value &&
// //                                     (entry.key == 'Social Hub' ||
// //                                         entry.key == 'Party Room'))
// //                                   Obx(() => DropdownButton<int>(
// //                                         hint: Text('Select Time'),
// //                                         value: slot.selectedTime.value,
// //                                         items: timeOptions[entry.key]!
// //                                             .map((int value) {
// //                                           return DropdownMenuItem<int>(
// //                                             value: value,
// //                                             child: Text(
// //                                                 '${(value / 60).floor()} hr ${(value % 60)} min'),
// //                                           );
// //                                         }).toList(),
// //                                         onChanged: (int? newValue) {
// //                                           slot.selectedTime.value = newValue;
// //                                         },
// //                                       )),
// //                                 if (!slot.isActive.value &&
// //                                     entry.key != 'Social Hub' &&
// //                                     entry.key != 'Party Room')
// //                                   Obx(() => DropdownButton<int>(
// //                                         hint: Text('Select Time'),
// //                                         value: slot.selectedTime.value,
// //                                         items: timeOptions['default']!
// //                                             .map((int value) {
// //                                           return DropdownMenuItem<int>(
// //                                             value: value,
// //                                             child: Text('$value min'),
// //                                           );
// //                                         }).toList(),
// //                                         onChanged: (int? newValue) {
// //                                           slot.selectedTime.value = newValue;
// //                                         },
// //                                       )),
// //                                 ElevatedButton(
// //                                   onPressed: () {
// //                                     if (slot.isActive.value) {
// //                                       slot.stopTimer();
// //                                     } else {
// //                                       if (slot.selectedTime.value != null) {
// //                                         slot.startTimer(
// //                                             slot.selectedTime.value!);
// //                                       }
// //                                     }
// //                                   },
// //                                   child: Text(
// //                                       slot.isActive.value ? 'Stop' : 'Start'),
// //                                 ),
// //                                 if (slot.timeRemaining.value != null)
// //                                   Text(
// //                                     '${formatTime(slot.timeRemaining.value!)}',
// //                                     style: TextStyle(
// //                                         fontSize: 16, color: Colors.black),
// //                                   ),
// //                               ],
// //                             ),
// //                           );
// //                         },
// //                         child: Card(
// //                           color: slot.isActive.value
// //                               ? Colors.green
// //                               : (slot.timeRemaining.value == null
// //                                   ? Colors.white
// //                                   : Colors.red),
// //                           margin: EdgeInsets.all(8.0),
// //                           child: Padding(
// //                             padding: const EdgeInsets.all(8.0),
// //                             child: Column(
// //                               children: [
// //                                 Text(
// //                                   slot.isActive.value
// //                                       ? '${formatTime(slot.timeRemaining.value!)}'
// //                                       : 'Table ${entry.value.indexOf(slot) + 1}',
// //                                   style: TextStyle(fontSize: 16),
// //                                 ),
// //                               ],
// //                             ),
// //                           ),
// //                         ),
// //                       ));
// //                 }).toList(),
// //               ),
// //             ],
// //           );
// //         }).toList(),
// //       ),
// //       floatingActionButton: FloatingActionButton(
// //         onPressed: () {
// //           Get.defaultDialog(
// //             title: 'Advanced Booking',
// //             content: Container(
// //               width: double.maxFinite,
// //               child: Column(
// //                 mainAxisSize: MainAxisSize.min,
// //                 crossAxisAlignment: CrossAxisAlignment.start,
// //                 children: [
// //                   Text('Name:'),
// //                   TextFormField(
// //                     controller: nameController,
// //                     decoration: InputDecoration(
// //                       hintText: 'Enter your name',
// //                     ),
// //                     onChanged: (value) {
// //                       // Implement logic to update name
// //                     },
// //                   ),
// //                   SizedBox(height: 10),
// //                   Text('Game:'),
// //                   DropdownButton<String>(
// //                     value: 'Pool', // Default value
// //                     onChanged: (String? newValue) {
// //                       // Implement logic to update game selection
// //                     },
// //                     items: games.keys.map((String game) {
// //                       return DropdownMenuItem<String>(
// //                         value: game,
// //                         child: Text(game),
// //                       );
// //                     }).toList(),
// //                   ),
// //                   SizedBox(height: 10),
// //                   Text('Table:'),
// //                   DropdownButton<int>(
// //                     hint: Text('Select Table'),
// //                     value: int.tryParse(tableController.text) ?? null,
// //                     onChanged: (int? newValue) {
// //                       tableController.text = newValue.toString();
// //                     },
// //                     items: List.generate(10, (index) {
// //                       return DropdownMenuItem<int>(
// //                         value: index + 1,
// //                         child: Text('Table ${index + 1}'),
// //                       );
// //                     }),
// //                   ),
// //                   SizedBox(height: 10),
// //                   Text('Hours:'),
// //                   DropdownButton<int>(
// //                     hint: Text('Select Hours'),
// //                     value: int.tryParse(hoursController.text) ?? null,
// //                     onChanged: (int? newValue) {
// //                       hoursController.text = newValue.toString();
// //                     },
// //                     items: [1, 2, 3, 4, 5].map((int value) {
// //                       return DropdownMenuItem<int>(
// //                         value: value,
// //                         child: Text('$value hr'),
// //                       );
// //                     }).toList(),
// //                   ),
// //                   SizedBox(height: 20),
// //                   Align(
// //                     alignment: Alignment.center,
// //                     child: ElevatedButton(
// //                       onPressed: () {
// //                         // Implement booking logic here
// //                         final name = nameController.text;
// //                         final game = gameController.text;
// //                         final table = int.tryParse(tableController.text) ?? 0;
// //                         final hours = int.tryParse(hoursController.text) ?? 0;

// //                         if (name.isNotEmpty &&
// //                             game.isNotEmpty &&
// //                             table > 0 &&
// //                             hours > 0) {
// //                           final booking = AdvanceBooking(
// //                             name: name,
// //                             game: game,
// //                             table: table,
// //                             hours: hours,
// //                           );

// //                           if (advanceBookings.containsKey(game)) {
// //                             advanceBookings[game]!.add(booking);
// //                           } else {
// //                             advanceBookings[game] = [booking];
// //                           }

// //                           // nameController.clear();
// //                           // gameController.clear();
// //                           // tableController.clear();
// //                           // hoursController.clear();

// //                           Get.back();
// //                         }
// //                       },
// //                       child: Text('Book Now'),
// //                     ),
// //                   ),
// //                 ],
// //               ),
// //             ),
// //           );
// //         },
// //         child: Icon(Icons.add),
// //       ),
// //       drawer: Drawer(
// //         child: ListView(
// //           padding: EdgeInsets.zero,
// //           children: <Widget>[
// //             DrawerHeader(
// //               decoration: BoxDecoration(
// //                 color: Colors.blue,
// //               ),
// //               child: Text(
// //                 'Advanced Bookings',
// //                 style: TextStyle(
// //                   color: Colors.white,
// //                   fontSize: 24,
// //                 ),
// //               ),
// //             ),
// //             ListTile(
// //               title: Text('Advance Bookings List'),
// //               onTap: () {
// //                 Get.to(AdvanceBookingsScreen(advanceBookings: advanceBookings));
// //               },
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }

// //   String formatTime(Duration duration) {
// //     if (duration.inHours > 0) {
// //       return '${duration.inHours}:${(duration.inMinutes % 60).toString().padLeft(2, '0')}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
// //     } else {
// //       return '${(duration.inMinutes % 60).toString().padLeft(2, '0')}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
// //     }
// //   }
// // }

// // class Slot {
// //   var isActive = false.obs;
// //   var timeRemaining = Rx<Duration?>(null);
// //   Timer? _timer;
// //   var selectedTime = Rx<int?>(null);
// //   final AudioPlayer player = AudioPlayer(); // Initialize AudioPlayer

// //   Future<void> startTimer(int minutes) async {
// //     timeRemaining.value = Duration(minutes: minutes);
// //     isActive.value = true;
// //     _timer = Timer.periodic(Duration(seconds: 1), (timer) {
// //       if (timeRemaining.value!.inSeconds > 0) {
// //         timeRemaining.value =
// //             Duration(seconds: timeRemaining.value!.inSeconds - 1);
// //       } else {
// //         isActive.value = false;
// //         timer.cancel();
// //         playSound(); // Play sound when timer finishes
// //         Get.defaultDialog(
// //           title: 'Time\'s Up!',
// //           content: Text('Your gaming time is over.'),
// //         );
// //       }
// //     });
// //   }

// //   void stopTimer() {
// //     _timer?.cancel();
// //     isActive.value = false;
// //     timeRemaining.value = null;
// //   }

// //   void playSound() async {
// //     await player.setAsset('assets/alert.wav'); // Load sound file from assets
// //     await player.play(); // Play the loaded sound file
// //   }
// // }

// // class AdvanceBooking {
// //   final String name;
// //   final String game;
// //   final int table;
// //   final int hours;

// //   AdvanceBooking({
// //     required this.name,
// //     required this.game,
// //     required this.table,
// //     required this.hours,
// //   });
// // }

// // class AdvanceBookingsScreen extends StatelessWidget {
// //   final Map<String, List<AdvanceBooking>> advanceBookings;

// //   const AdvanceBookingsScreen({Key? key, required this.advanceBookings})
// //       : super(key: key);

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text('Advanced Bookings'),
// //       ),
// //       body: ListView(
// //         children: advanceBookings.entries.map((entry) {
// //           return ExpansionTile(
// //             title: Text(entry.key),
// //             children: entry.value.map((booking) {
// //               return ListTile(
// //                 title: Text(
// //                     '${booking.name} booked Table ${booking.table} for ${booking.hours} hours'),
// //               );
// //             }).toList(),
// //           );
// //         }).toList(),
// //       ),
// //     );
// //   }
// // }

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:audioplayers/audioplayers.dart'; // Import audioplayers
// import 'package:shared_preferences/shared_preferences.dart'; // Import SharedPreferences
// import 'dart:async';

// void main() {
//   runApp(ArcadeManagerApp());
// }

// class ArcadeManagerApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return GetMaterialApp(
//       home: HomePage(),
//     );
//   }
// }

// class HomePage extends StatefulWidget {
//   @override
//   _HomePageState createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   final Map<String, List<Slot>> games = {
//     'Pool': List.generate(10, (_) => Slot('Pool')),
//     'Snooker': List.generate(6, (_) => Slot('Snooker')),
//     'Table Tennis': List.generate(3, (_) => Slot('Table Tennis')),
//     'PS-5': List.generate(5, (_) => Slot('PS-5')),
//     'PS-4': List.generate(5, (_) => Slot('PS-4')),
//     'LAN Gaming': List.generate(10, (_) => Slot('LAN Gaming')),
//     'Social Hub': List.generate(1, (_) => Slot('Social Hub')),
//     'Party Room': List.generate(1, (_) => Slot('Party Room')),
//   };

//   final Map<String, List<int>> timeOptions = {
//     'default': [60, 30, 15, 5, 1], // Minutes for other games
//     'Social Hub': [180, 120, 60], // 3hr, 2hr, 1hr in minutes
//     'Party Room': [180, 120, 60], // 3hr, 2hr, 1hr in minutes
//   };

//   late SharedPreferences prefs;

//   @override
//   void initState() {
//     super.initState();
//     initializeSharedPreferences();
//   }

//   Future<void> initializeSharedPreferences() async {
//     prefs = await SharedPreferences.getInstance();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Arcade Game Manager'),
//       ),
//       body: ListView(
//         children: games.entries.map((entry) {
//           return Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Text(
//                   entry.key,
//                   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                 ),
//               ),
//               Wrap(
//                 children: entry.value.map((slot) {
//                   return Obx(() => GestureDetector(
//                         onTap: () {
//                           Get.defaultDialog(
//                             title: 'Table Details',
//                             content: Column(
//                               children: [
//                                 Align(
//                                   alignment: Alignment.topRight,
//                                   child: IconButton(
//                                     icon: Icon(Icons.close),
//                                     onPressed: () {
//                                       Get.back();
//                                     },
//                                   ),
//                                 ),
//                                 Text(
//                                   'Table ${entry.value.indexOf(slot) + 1}',
//                                   style: TextStyle(fontSize: 16),
//                                 ),
//                                 if (!slot.isActive.value &&
//                                     (entry.key == 'Social Hub' ||
//                                         entry.key == 'Party Room'))
//                                   Obx(() => DropdownButton<int>(
//                                         hint: Text('Select Time'),
//                                         value: slot.selectedTime.value,
//                                         items: timeOptions[entry.key]!
//                                             .map((int value) {
//                                           return DropdownMenuItem<int>(
//                                             value: value,
//                                             child: Text(
//                                                 '${(value / 60).floor()} hr ${(value % 60)} min'),
//                                           );
//                                         }).toList(),
//                                         onChanged: (int? newValue) {
//                                           slot.selectedTime.value = newValue;
//                                         },
//                                       )),
//                                 if (!slot.isActive.value &&
//                                     entry.key != 'Social Hub' &&
//                                     entry.key != 'Party Room')
//                                   Obx(() => DropdownButton<int>(
//                                         hint: Text('Select Time'),
//                                         value: slot.selectedTime.value,
//                                         items: timeOptions['default']!
//                                             .map((int value) {
//                                           return DropdownMenuItem<int>(
//                                             value: value,
//                                             child: Text('$value min'),
//                                           );
//                                         }).toList(),
//                                         onChanged: (int? newValue) {
//                                           slot.selectedTime.value = newValue;
//                                         },
//                                       )),
//                                 ElevatedButton(
//                                   onPressed: () {
//                                     if (slot.isActive.value) {
//                                       slot.stopTimer();
//                                       storeGameUsageData(
//                                           slot.game,
//                                           entry.value.indexOf(slot) + 1,
//                                           slot.startTime!,
//                                           slot.selectedTime.value!);
//                                     } else {
//                                       if (slot.selectedTime.value != null) {
//                                         slot.startTimer(
//                                             slot.selectedTime.value!);
//                                       }
//                                     }
//                                   },
//                                   child: Text(
//                                       slot.isActive.value ? 'Stop' : 'Start'),
//                                 ),
//                                 if (slot.timeRemaining.value != null)
//                                   Text(
//                                     '${formatTime(slot.timeRemaining.value!)}',
//                                     style: TextStyle(
//                                         fontSize: 16, color: Colors.black),
//                                   ),
//                               ],
//                             ),
//                           );
//                         },
//                         child: Card(
//                           color: slot.isActive.value
//                               ? Colors.green
//                               : (slot.timeRemaining.value == null
//                                   ? Colors.white
//                                   : Colors.red),
//                           margin: EdgeInsets.all(8.0),
//                           child: Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Column(
//                               children: [
//                                 Text(
//                                   slot.isActive.value
//                                       ? '${formatTime(slot.timeRemaining.value!)}'
//                                       : 'Table ${entry.value.indexOf(slot) + 1}',
//                                   style: TextStyle(fontSize: 16),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ));
//                 }).toList(),
//               ),
//             ],
//           );
//         }).toList(),
//       ),
//       drawer: Drawer(
//         child: ListView(
//           padding: EdgeInsets.zero,
//           children: <Widget>[
//             DrawerHeader(
//               decoration: BoxDecoration(
//                 color: Colors.blue,
//               ),
//               child: Text(
//                 'Game Usage Details',
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontSize: 24,
//                 ),
//               ),
//             ),
//             ListTile(
//               title: Text('View Game Usage'),
//               onTap: () {
//                 Get.to(GameUsageDetailsScreen(games: games, prefs: prefs));
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   String formatTime(Duration duration) {
//     if (duration.inHours > 0) {
//       return '${duration.inHours}:${(duration.inMinutes % 60).toString().padLeft(2, '0')}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
//     } else {
//       return '${(duration.inMinutes % 60).toString().padLeft(2, '0')}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
//     }
//   }

//   void storeGameUsageData(
//       String game, int table, DateTime startTime, int usedTime) {
//     if (prefs != null) {
//       final String key = '${game}_Table$table';
//       final String startKey = 'start_$key';
//       final String endKey = 'end_$key';

//       prefs.setString(startKey, startTime.toIso8601String());

//       DateTime endTime = startTime.add(Duration(minutes: usedTime));
//       prefs.setString(endKey, endTime.toIso8601String());
//     }
//   }
// }

// class Slot {
//   final String game;
//   var isActive = false.obs;
//   var timeRemaining = Rx<Duration?>(null);
//   Timer? _timer;
//   var selectedTime = Rx<int?>(null);
//   DateTime? startTime;

//   Slot(this.game);

//   Future<void> startTimer(int minutes) async {
//     startTime = DateTime.now();
//     timeRemaining.value = Duration(minutes: minutes);
//     isActive.value = true;
//     _timer = Timer.periodic(Duration(seconds: 1), (timer) {
//       if (timeRemaining.value!.inSeconds > 0) {
//         timeRemaining.value =
//             Duration(seconds: timeRemaining.value!.inSeconds - 1);
//       } else {
//         isActive.value = false;
//         timer.cancel();
//         playSound(); // Play sound when timer finishes
//         Get.defaultDialog(
//           title: 'Time\'s Up!',
//           content: Text('Your gaming time is over.'),
//         );
//       }
//     });
//   }

//   void stopTimer() {
//     _timer?.cancel();
//     isActive.value = false;
//     timeRemaining.value = null;
//   }

//   void playSound() async {
//     AudioPlayer audioPlayer = AudioPlayer(); // Initialize AudioPlayer
//     await audioPlayer.setSource(AssetSource('assets/alert1.mp3'));
//     await audioPlayer.resume(); // Play the loaded sound file
//   }
// }

// class GameUsageDetailsScreen extends StatelessWidget {
//   final Map<String, List<Slot>> games;
//   final SharedPreferences prefs;

//   const GameUsageDetailsScreen(
//       {Key? key, required this.games, required this.prefs})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     List<Widget> gameUsageList = [];

//     games.forEach((game, slots) {
//       slots.forEach((slot) {
//         String key = '${game}_Table${slots.indexOf(slot) + 1}';
//         String startKey = 'start_$key';
//         String endKey = 'end_$key';

//         String? startTimeString = prefs.getString(startKey);
//         String? endTimeString = prefs.getString(endKey);

//         if (startTimeString != null && endTimeString != null) {
//           DateTime startTime = DateTime.parse(startTimeString);
//           DateTime endTime = DateTime.parse(endTimeString);

//           Duration usedTime = endTime.difference(startTime);

//           gameUsageList.add(ListTile(
//             title: Text('$game - Table ${slots.indexOf(slot) + 1}'),
//             subtitle: Text(
//                 'Started: $startTime\nUsed Time: ${formatDuration(usedTime)}'),
//           ));
//         }
//       });
//     });

//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Game Usage Details'),
//       ),
//       body: ListView(
//         children: gameUsageList,
//       ),
//     );
//   }

//   String formatDuration(Duration duration) {
//     return '${duration.inHours}:${(duration.inMinutes % 60).toString().padLeft(2, '0')}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
//   }
// // }

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:audioplayers/audioplayers.dart';

// import 'package:shared_preferences/shared_preferences.dart';
// import 'dart:async';

// void main() {
//   runApp(ArcadeManagerApp());
// }

// class ArcadeManagerApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return GetMaterialApp(
//       home: HomePage(),
//     );
//   }
// }

// class HomePage extends StatefulWidget {
//   @override
//   _HomePageState createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   final Map<String, List<Slot>> games = {
//     'Pool': List.generate(10, (_) => Slot('Pool')),
//     'Snooker': List.generate(6, (_) => Slot('Snooker')),
//     'Table Tennis': List.generate(3, (_) => Slot('Table Tennis')),
//     'PS-5': List.generate(5, (_) => Slot('PS-5')),
//     'PS-4': List.generate(5, (_) => Slot('PS-4')),
//     'LAN Gaming': List.generate(10, (_) => Slot('LAN Gaming')),
//     'Social Hub': List.generate(1, (_) => Slot('Social Hub')),
//     'Party Room': List.generate(1, (_) => Slot('Party Room')),
//   };

//   final Map<String, List<int>> timeOptions = {
//     'default': [60, 30, 15, 5, 1],
//     'Social Hub': [180, 120, 60],
//     'Party Room': [180, 120, 60],
//   };

//   late SharedPreferences prefs;

//   @override
//   void initState() {
//     super.initState();
//     initializeSharedPreferences();
//     // playSound();
//   }

//   Future<void> initializeSharedPreferences() async {
//     prefs = await SharedPreferences.getInstance();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Arcade Game Manager'),
//       ),
//       body: ListView(
//         children: games.entries.map((entry) {
//           return Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Text(
//                   entry.key,
//                   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                 ),
//               ),
//               Wrap(
//                 children: entry.value.map((slot) {
//                   return Obx(() => GestureDetector(
//                         onTap: () {
//                           Get.defaultDialog(
//                             title: 'Table Details',
//                             content: Column(
//                               children: [
//                                 Align(
//                                   alignment: Alignment.topRight,
//                                   child: IconButton(
//                                     icon: Icon(Icons.close),
//                                     onPressed: () {
//                                       Get.back();
//                                     },
//                                   ),
//                                 ),
//                                 Text(
//                                   'Table ${entry.value.indexOf(slot) + 1}',
//                                   style: TextStyle(fontSize: 16),
//                                 ),
//                                 if (!slot.isActive.value &&
//                                     (entry.key == 'Social Hub' ||
//                                         entry.key == 'Party Room'))
//                                   Obx(() => DropdownButton<int>(
//                                         hint: Text('Select Time'),
//                                         value: slot.selectedTime.value,
//                                         items: timeOptions[entry.key]!
//                                             .map((int value) {
//                                           return DropdownMenuItem<int>(
//                                             value: value,
//                                             child: Text(
//                                                 '${(value / 60).floor()} hr ${(value % 60)} min'),
//                                           );
//                                         }).toList(),
//                                         onChanged: (int? newValue) {
//                                           slot.selectedTime.value = newValue;
//                                         },
//                                       )),
//                                 if (!slot.isActive.value &&
//                                     entry.key != 'Social Hub' &&
//                                     entry.key != 'Party Room')
//                                   Obx(() => DropdownButton<int>(
//                                         hint: Text('Select Time'),
//                                         value: slot.selectedTime.value,
//                                         items: timeOptions['default']!
//                                             .map((int value) {
//                                           return DropdownMenuItem<int>(
//                                             value: value,
//                                             child: Text('$value min'),
//                                           );
//                                         }).toList(),
//                                         onChanged: (int? newValue) {
//                                           slot.selectedTime.value = newValue;
//                                         },
//                                       )),
//                                 ElevatedButton(
//                                   onPressed: () {
//                                     if (slot.isActive.value) {
//                                       slot.stopTimer();
//                                       storeGameUsageData(
//                                           slot.game,
//                                           entry.value.indexOf(slot) + 1,
//                                           slot.startTime!,
//                                           slot.selectedTime.value!);
//                                     } else {
//                                       if (slot.selectedTime.value != null) {
//                                         slot.startTimer(
//                                             slot.selectedTime.value!,
//                                             onTimerEnd: () {
//                                           storeGameUsageData(
//                                               slot.game,
//                                               entry.value.indexOf(slot) + 1,
//                                               slot.startTime!,
//                                               slot.selectedTime.value!);
//                                         });
//                                       }
//                                     }
//                                   },
//                                   child: Text(
//                                       slot.isActive.value ? 'Stop' : 'Start'),
//                                 ),
//                                 if (slot.timeRemaining.value != null)
//                                   Text(
//                                     '${formatTime(slot.timeRemaining.value!)}',
//                                     style: TextStyle(
//                                         fontSize: 16, color: Colors.black),
//                                   ),
//                               ],
//                             ),
//                           );
//                         },
//                         child: Card(
//                           color: slot.isActive.value
//                               ? Colors.green
//                               : (slot.timeRemaining.value == null
//                                   ? Colors.white
//                                   : Colors.red),
//                           margin: EdgeInsets.all(8.0),
//                           child: Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Column(
//                               children: [
//                                 Text(
//                                   slot.isActive.value
//                                       ? '${formatTime(slot.timeRemaining.value!)}'
//                                       : 'Table ${entry.value.indexOf(slot) + 1}',
//                                   style: TextStyle(fontSize: 16),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ));
//                 }).toList(),
//               ),
//             ],
//           );
//         }).toList(),
//       ),
//       drawer: Drawer(
//         child: ListView(
//           padding: EdgeInsets.zero,
//           children: <Widget>[
//             DrawerHeader(
//               decoration: BoxDecoration(
//                 color: Colors.blue,
//               ),
//               child: Text(
//                 'Game Usage Details',
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontSize: 24,
//                 ),
//               ),
//             ),
//             ListTile(
//               title: Text('View Game Usage'),
//               onTap: () {
//                 Get.to(GameUsageDetailsScreen(games: games, prefs: prefs));
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   String formatTime(Duration duration) {
//     if (duration.inHours > 0) {
//       return '${duration.inHours}:${(duration.inMinutes % 60).toString().padLeft(2, '0')}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
//     } else {
//       return '${(duration.inMinutes % 60).toString().padLeft(2, '0')}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
//     }
//   }

//   void storeGameUsageData(
//       String game, int table, DateTime startTime, int usedTime) {
//     final String key = '${game}_Table$table';
//     final String startKey = 'start_$key';
//     final String endKey = 'end_$key';

//     prefs.setString(startKey, startTime.toIso8601String());

//     DateTime endTime = startTime.add(Duration(minutes: usedTime));
//     prefs.setString(endKey, endTime.toIso8601String());
//   }
// }

// class Slot {
//   final String game;
//   var isActive = false.obs;
//   var timeRemaining = Rx<Duration?>(null);
//   Timer? _timer;
//   var selectedTime = Rx<int?>(null);
//   DateTime? startTime;

//   Slot(this.game);

//   Future<void> startTimer(int minutes, {required Function onTimerEnd}) async {
//     startTime = DateTime.now();
//     timeRemaining.value = Duration(minutes: minutes);
//     isActive.value = true;
//     _timer = Timer.periodic(Duration(seconds: 1), (timer) {
//       if (timeRemaining.value!.inSeconds > 0) {
//         timeRemaining.value =
//             Duration(seconds: timeRemaining.value!.inSeconds - 1);
//       } else {
//         isActive.value = false;
//         timer.cancel();
//         playSound();
//         stopTimer();

//         Get.defaultDialog(
//           title: 'Time\'s Up ${game}!',
//           content: Text('Your gaming time is over.'),
//         );
//       }
//     });
//   }

//   void stopTimer() {
//     _timer?.cancel();
//     isActive.value = false;
//     timeRemaining.value = null;
//   }

//   void playSound() async {
//     // AudioPlayer audioPlayer = AudioPlayer();
//     // await audioPlayer.play(AssetSource('alert.mp3'));
//     // final player = AudioPlayer();
//     //     await player.play(AssetSource('alert1.mp4'));

//     final player = AudioPlayer();
//     await player.play(AssetSource('audio/alert1.mp3'));
//   }
// }

// class GameUsageDetailsScreen extends StatelessWidget {
//   final Map<String, List<Slot>> games;
//   final SharedPreferences prefs;

//   const GameUsageDetailsScreen(
//       {Key? key, required this.games, required this.prefs})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     List<Widget> gameUsageList = [];

//     games.forEach((game, slots) {
//       slots.asMap().forEach((index, slot) {
//         String key = '${game}_Table${index + 1}';
//         String startKey = 'start_$key';
//         String endKey = 'end_$key';

//         String? startTimeString = prefs.getString(startKey);
//         String? endTimeString = prefs.getString(endKey);

//         if (startTimeString != null && endTimeString != null) {
//           DateTime startTime = DateTime.parse(startTimeString);
//           DateTime endTime = DateTime.parse(endTimeString);
//           Duration usedTime = endTime.difference(startTime);

//           gameUsageList.add(ListTile(
//             title: Text('$game - Table ${index + 1}'),
//             subtitle: Text(
//                 'Started: $startTime\nUsed Time: ${formatDuration(usedTime)}'),
//           ));
//         }
//       });
//     });

//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Game Usage Details'),
//       ),
//       body: ListView(
//         children: gameUsageList,
//       ),
//     );
//   }

//   String formatDuration(Duration duration) {
//     return '${duration.inHours}:${(duration.inMinutes % 60).toString().padLeft(2, '0')}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

void main() {
  runApp(ArcadeManagerApp());
}

class ArcadeManagerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Map<String, List<Slot>> games = {
    'Pool': List.generate(10, (_) => Slot('Pool')),
    'Snooker': List.generate(6, (_) => Slot('Snooker')),
    'Table Tennis': List.generate(3, (_) => Slot('Table Tennis')),
    'PS-5': List.generate(5, (_) => Slot('PS-5')),
    'PS-4': List.generate(5, (_) => Slot('PS-4')),
    'LAN Gaming': List.generate(10, (_) => Slot('LAN Gaming')),
    'Social Hub': List.generate(1, (_) => Slot('Social Hub')),
    'Party Room': List.generate(1, (_) => Slot('Party Room')),
  };

  final Map<String, List<int>> timeOptions = {
    'default': [60, 30, 15, 5, 1],
    'Social Hub': [180, 120, 60],
    'Party Room': [180, 120, 60],
  };

  late SharedPreferences prefs;

  @override
  void initState() {
    super.initState();
    initializeSharedPreferences();
  }

  Future<void> initializeSharedPreferences() async {
    prefs = await SharedPreferences.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Arcade Tracker'),
      ),
      body: ListView(
        children: games.entries.map((entry) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  entry.key,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              Wrap(
                children: entry.value.map((slot) {
                  return Obx(() => GestureDetector(
                        onTap: () {
                          Get.defaultDialog(
                            title: 'Table Details',
                            content: Column(
                              children: [
                                Align(
                                  alignment: Alignment.topRight,
                                  child: IconButton(
                                    icon: Icon(Icons.close),
                                    onPressed: () {
                                      Get.back();
                                    },
                                  ),
                                ),
                                Text('Book: ${slot.game}'),
                                SizedBox(height: 10),
                                Text(
                                  'Table ${entry.value.indexOf(slot) + 1}',
                                  style: TextStyle(fontSize: 16),
                                ),
                                if (!slot.isActive.value &&
                                    (entry.key == 'Social Hub' ||
                                        entry.key == 'Party Room'))
                                  Obx(() => DropdownButton<int>(
                                        hint: Text('Select Time'),
                                        value: slot.selectedTime.value,
                                        items: timeOptions[entry.key]!
                                            .map((int value) {
                                          return DropdownMenuItem<int>(
                                            value: value,
                                            child: Text(
                                                '${(value / 60).floor()} hr ${(value % 60)} min'),
                                          );
                                        }).toList(),
                                        onChanged: (int? newValue) {
                                          slot.selectedTime.value = newValue;
                                        },
                                      )),
                                if (!slot.isActive.value &&
                                    entry.key != 'Social Hub' &&
                                    entry.key != 'Party Room')
                                  Obx(() => DropdownButton<int>(
                                        hint: Text('Select Time'),
                                        value: slot.selectedTime.value,
                                        items: timeOptions['default']!
                                            .map((int value) {
                                          return DropdownMenuItem<int>(
                                            value: value,
                                            child: Text('$value min'),
                                          );
                                        }).toList(),
                                        onChanged: (int? newValue) {
                                          slot.selectedTime.value = newValue;
                                        },
                                      )),
                                Obx(
                                  () => ElevatedButton(
                                    onPressed: () {
                                      if (slot.isActive.value) {
                                        // storeGameUsageData(
                                        //     slot.game,
                                        //     entry.value.indexOf(slot) + 1,
                                        //     slot.startTime!,
                                        //     slot.selectedTime.value!);
                                        slot.stopTimer();
                                      } else {
                                        if (slot.selectedTime.value != null) {
                                          slot.startTimer(
                                              slot.selectedTime.value!);
                                          storeGameUsageData(
                                              slot.game,
                                              entry.value.indexOf(slot) + 1,
                                              slot.startTime!,
                                              slot.selectedTime.value!);
                                        }
                                      }
                                    },
                                    child: Text(
                                        slot.isActive.value ? 'Stop' : 'Start'),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                if (slot.timeRemaining.value != null)
                                  Obx(
                                    () => Text(
                                      '${formatTime(slot.timeRemaining.value!)}',
                                      style: TextStyle(
                                          fontSize: 16, color: Colors.black),
                                    ),
                                  ),
                              ],
                            ),
                          );
                        },
                        child: Card(
                          color: slot.isActive.value
                              ? Colors.green
                              : (slot.timeRemaining.value == null
                                  ? Colors.white
                                  : Colors.red),
                          margin: EdgeInsets.all(8.0),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Text(
                                  slot.isActive.value
                                      ? '${formatTime(slot.timeRemaining.value!)}'
                                      : 'Table ${entry.value.indexOf(slot) + 1}',
                                  style: TextStyle(fontSize: 16),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ));
                }).toList(),
              ),
            ],
          );
        }).toList(),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Game Usage Details',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              title: Text('View Game Usage'),
              onTap: () {
                Get.to(GameUsageDetailsScreen(games: games, prefs: prefs));
              },
            ),
          ],
        ),
      ),
    );
  }

  String formatTime(Duration duration) {
    if (duration.inHours > 0) {
      return '${duration.inHours}:${(duration.inMinutes % 60).toString().padLeft(2, '0')}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
    } else {
      return '${(duration.inMinutes % 60).toString().padLeft(2, '0')}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
    }
  }

  void storeGameUsageData(
      String game, int table, DateTime startTime, int usedTime) {
    final String key = '${game}_Table$table';
    final String startKey = 'start_$key';
    final String endKey = 'end_$key';

    prefs.setString(startKey, startTime.toIso8601String());
    DateTime endTime = startTime.add(Duration(minutes: usedTime));
    prefs.setString(endKey, endTime.toIso8601String());
  }
}

class Slot {
  final String game;
  var isActive = false.obs;
  var timeRemaining = Rx<Duration?>(null);
  Timer? _timer;
  var selectedTime = Rx<int?>(null);
  DateTime? startTime;

  Slot(this.game);
  final player = AudioPlayer();

  Future<void> startTimer(int minutes) async {
    // final AudioPlayer player = AudioPlayer();

    startTime = DateTime.now();
    timeRemaining.value = Duration(minutes: minutes);
    isActive.value = true;
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (timeRemaining.value!.inSeconds > 0) {
        timeRemaining.value =
            Duration(seconds: timeRemaining.value!.inSeconds - 1);
      } else {
        isActive.value = false;
        timer.cancel();
        stopTimer();
        // Save data automatically when time is up
        player.play(AssetSource('audio/alert1.mp3'));

        Get.defaultDialog(
          title: 'Time\'s Up!',
          content: Column(
            children: [
              Text('Your ${game} time is over.'),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  stopTimer();
                  player.stop(); // Stop the audio
                  Get.back();
                },
                child: Text('Continue'),
              ),
            ],
          ),
        );
      }
    });
  }

  void stopTimer() {
    _timer?.cancel();
    isActive.value = false;

    timeRemaining.value = null;
  }
}

class GameUsageDetailsScreen extends StatelessWidget {
  final Map<String, List<Slot>> games;
  final SharedPreferences prefs;

  const GameUsageDetailsScreen(
      {Key? key, required this.games, required this.prefs})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Game Usage Details'),
      ),
      body: ListView.builder(
        itemCount: games.keys.length,
        itemBuilder: (context, index) {
          final gameName = games.keys.elementAt(index);
          final slots = games[gameName]!;

          return ExpansionTile(
            title: Text(gameName),
            children: slots.map((slot) {
              String key = '${slot.game}_Table${slots.indexOf(slot) + 1}';
              String startKey = 'start_$key';
              String endKey = 'end_$key';

              String? startTime = prefs.getString(startKey);
              String? endTime = prefs.getString(endKey);

              if (startTime != null && endTime != null) {
                Duration usedTime = DateTime.parse(endTime)
                    .difference(DateTime.parse(startTime));
                return ListTile(
                  title: Text('$gameName - Table ${slots.indexOf(slot) + 1}'),
                  subtitle: Text(
                      'Started: $startTime\nUsed Time: ${formatDuration(usedTime)}'),
                );
              }
              return Container();
            }).toList(),
          );
        },
      ),
    );
  }

  String formatDuration(Duration duration) {
    return '${duration.inHours}:${(duration.inMinutes % 60).toString().padLeft(2, '0')}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
  }
}

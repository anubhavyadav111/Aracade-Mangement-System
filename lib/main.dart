// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:audioplayers/audioplayers.dart';
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

// class HomePage extends StatelessWidget {
//   final Map<String, List<Slot>> games = {
//     'Pool': List.generate(10, (_) => Slot()),
//     'Snooker': List.generate(6, (_) => Slot()),
//     'Table Tennis': List.generate(3, (_) => Slot()),
//     'PS-5': List.generate(5, (_) => Slot()),
//     'PS-4': List.generate(5, (_) => Slot()),
//     'LAN Gaming': List.generate(10, (_) => Slot()),
//     'Social Hub': List.generate(1, (_) => Slot()),
//     'Party Room': List.generate(1, (_) => Slot()),
//   };

//   final List<int> timeOptions = [60, 30, 15, 5]; // Minutes

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Arcade Game Manager')),
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
//                                 if (!slot.isActive.value)
//                                   DropdownButton<int>(
//                                     hint: Text('Select Time'),
//                                     value: slot.selectedTime.value,
//                                     items: timeOptions.map((int value) {
//                                       return DropdownMenuItem<int>(
//                                         value: value,
//                                         child: Text('$value min'),
//                                       );
//                                     }).toList(),
//                                     onChanged: (int? newValue) {
//                                       slot.selectedTime.value = newValue;
//                                     },
//                                   ),
//                                 ElevatedButton(
//                                   onPressed: () {
//                                     if (slot.isActive.value) {
//                                       slot.stopTimer();
//                                     } else {
//                                       if (slot.selectedTime.value != null) {
//                                         slot.startTimer(slot.selectedTime.value!);
//                                       }
//                                     }
//                                   },
//                                   child: Text(slot.isActive.value ? 'Stop' : 'Start'),
//                                 ),
//                                 if (slot.timeRemaining.value != null)
//                                   Text(
//                                     '${(slot.timeRemaining.value!.inMinutes % 60).toString().padLeft(2, '0')}:${(slot.timeRemaining.value!.inSeconds % 60).toString().padLeft(2, '0')}',
//                                     style: TextStyle(fontSize: 16, color: Colors.black),
//                                   ),
//                               ],
//                             ),
//                           );
//                         },
//                         child: Card(
//                           color: slot.isActive.value
//                               ? Colors.green
//                               : (slot.timeRemaining.value == null ? Colors.white : Colors.red),
//                           margin: EdgeInsets.all(8.0),
//                           child: Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Column(
//                               children: [
//                                 Text(
//                                   slot.isActive.value
//                                       ? '${(slot.timeRemaining.value!.inMinutes % 60).toString().padLeft(2, '0')}:${(slot.timeRemaining.value!.inSeconds % 60).toString().padLeft(2, '0')}'
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
//     );
//   }
// }

// class Slot {
//   var isActive = false.obs;
//   var timeRemaining = Rx<Duration?>(null);
//   Timer? _timer;
//   var selectedTime = Rx<int?>(null);
//   final AudioPlayer audioPlayer = AudioPlayer();

//   void startTimer(int minutes) {
//     timeRemaining.value = Duration(minutes: minutes);
//     isActive.value = true;
//     _timer = Timer.periodic(Duration(seconds: 1), (timer) {
//       if (timeRemaining.value!.inSeconds > 0) {
//         timeRemaining.value = Duration(seconds: timeRemaining.value!.inSeconds - 1);
//       } else {
//         isActive.value = false;
//         timer.cancel();
//         audioPlayer.play(AssetSource('assets/sound/alert.mp3'));
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
// }
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart'; // Import JustAudioPlayer
import 'dart:async';

void main() {
  runApp(ArcadeManagerApp());
}

class ArcadeManagerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  final Map<String, List<Slot>> games = {
    'Pool': List.generate(10, (_) => Slot()),
    'Snooker': List.generate(6, (_) => Slot()),
    'Table Tennis': List.generate(3, (_) => Slot()),
    'PS-5': List.generate(5, (_) => Slot()),
    'PS-4': List.generate(5, (_) => Slot()),
    'LAN Gaming': List.generate(10, (_) => Slot()),
    'Social Hub': List.generate(1, (_) => Slot()),
    'Party Room': List.generate(1, (_) => Slot()),
  };

  final List<int> timeOptions = [60, 30, 15, 5]; // Minutes

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Arcade Game Manager')),
      body: ListView(
        children: games.entries.map((entry) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                                Text(
                                  'Table ${entry.value.indexOf(slot) + 1}',
                                  style: TextStyle(fontSize: 16),
                                ),
                               
                                if (!slot.isActive.value)
                                  Obx(() => DropdownButton<int>(
                                        hint: Text('Select Time'),
                                        value: slot.selectedTime.value,
                                        items: timeOptions.map((int value) {
                                          return DropdownMenuItem<int>(
                                            value: value,
                                            child: Text('$value min'),
                                          );
                                        }).toList(),
                                        onChanged: (int? newValue) {
                                          slot.selectedTime.value = newValue;
                                        },
                                      )),
                                ElevatedButton(
                                  onPressed: () {
                                    if (slot.isActive.value) {
                                      slot.stopTimer();
                                    } else {
                                      if (slot.selectedTime.value != null) {
                                        slot.startTimer(
                                            slot.selectedTime.value!);
                                      }
                                    }
                                  },
                                  child: Text(
                                      slot.isActive.value ? 'Stop' : 'Start'),
                                ),
                                if (slot.timeRemaining.value != null)
                                  Text(
                                    '${(slot.timeRemaining.value!.inMinutes % 60).toString().padLeft(2, '0')}:${(slot.timeRemaining.value!.inSeconds % 60).toString().padLeft(2, '0')}',
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.black),
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
                                      ? '${(slot.timeRemaining.value!.inMinutes % 60).toString().padLeft(2, '0')}:${(slot.timeRemaining.value!.inSeconds % 60).toString().padLeft(2, '0')}'
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
    );
  }
}

class Slot {
  var isActive = false.obs;
  var timeRemaining = Rx<Duration?>(null);
  Timer? _timer;
  var selectedTime = Rx<int?>(null);
  final AudioPlayer player = AudioPlayer(); // Initialize AudioPlayer

  Future<void> startTimer(int minutes) async {
    timeRemaining.value = Duration(minutes: minutes);
    isActive.value = true;
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (timeRemaining.value!.inSeconds > 0) {
        timeRemaining.value =
            Duration(seconds: timeRemaining.value!.inSeconds - 1);
      } else {
        isActive.value = false;
        timer.cancel();
        playSound(); // Play sound when timer finishes
        Get.defaultDialog(
          title: 'Time\'s Up!',
          content: Text('Your gaming time is over.'),
        );
      }
    });
  }

  void stopTimer() {
    _timer?.cancel();
    isActive.value = false;
    timeRemaining.value = null;
  }

  void playSound() async {
    await player.setAsset('assets/alert.mp3'); // Load sound file from assets
    await player.play(); // Play the loaded sound file
  }
}

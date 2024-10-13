
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
    'Pool': List.generate(12, (_) => Slot('Pool')),
    'Snooker': List.generate(4, (_) => Slot('Snooker')),
    'Table Tennis': List.generate(3, (_) => Slot('Table Tennis')),
    'PS-5': List.generate(5, (_) => Slot('PS-5')),
    'PS-4': List.generate(5, (_) => Slot('PS-4')),
    'LAN Gaming': List.generate(10, (_) => Slot('LAN Gaming')),
    'Social Hub': List.generate(1, (_) => Slot('Social Hub')),
    'Party Room': List.generate(1, (_) => Slot('Party Room')),
    'Jam Room': List.generate(1, (_) => Slot('Jam Room')),
    'Ludo': List.generate(1, (_) => Slot('LUDO')),
    'Chess': List.generate(1, (_) => Slot('Chess')),
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
                spacing: 16.0,
                runSpacing: 16.0,
                children: entry.value.map((slot) {
                  return Obx(() => GestureDetector(
                        onTap: () {
                          Get.defaultDialog(
                            barrierDismissible: false,
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
                        child: AnimatedContainer(
                          duration: Duration(seconds: 1),
                          color: slot.isBlinking.value
                              ? (slot.blinkState.value
                                  ? Colors.red
                                  : Colors.white)
                              : (slot.isActive.value
                                  ? Colors.green
                                  : (slot.timeRemaining.value == null
                                      ? Colors.white
                                      : Colors.red)),
                          margin: EdgeInsets.all(8.0),
                          child: Container(
                            width: 120,
                            height: 70,
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  slot.isActive.value
                                      ? '${formatTime(slot.timeRemaining.value!)}'
                                      : 'Table ${entry.value.indexOf(slot) + 1}',
                                  style: TextStyle(fontSize: 16),
                                  textAlign: TextAlign.center,
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
  var isBlinking = false.obs;
  var blinkState = false.obs;
  Timer? _blinkTimer;

  Slot(this.game);
  final player = AudioPlayer();
  bool isAlertPlaying = false;

  Future<void> startTimer(int minutes) async {
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
        if (!isAlertPlaying) {
          isAlertPlaying = true;
          playAlert();
          startBlinking();

          Get.defaultDialog(
            barrierDismissible: false,
            title: 'Time\'s Up!',
            content: Column(
              children: [
                Text('Your ${game} time is over.'),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    stopAlert();
                    stopBlinking();
                    Get.back();
                  },
                  child: Text('Continue'),
                ),
              ],
            ),
          );
        }
      }
    });
  }

  void playAlert() async {
    await player.setReleaseMode(ReleaseMode.loop);
    await player.play(AssetSource('audio/alert1.mp3'));
  }

  void startBlinking() {
    isBlinking.value = true;
    _blinkTimer = Timer.periodic(Duration(milliseconds: 500), (timer) {
      blinkState.value = !blinkState.value;
    });
  }

  void stopBlinking() {
    _blinkTimer?.cancel();
    isBlinking.value = false;
    blinkState.value = false;
  }

  void stopTimer() {
    _timer?.cancel();
    isActive.value = false;
    timeRemaining.value = null;
    if (isAlertPlaying) {
      stopAlert();
    }
    stopBlinking();
  }

  void stopAlert() {
    player.stop();
    isAlertPlaying = false;
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

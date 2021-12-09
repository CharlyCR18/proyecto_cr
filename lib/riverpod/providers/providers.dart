import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod/riverpod.dart';

/*final UserProvider = FutureProvider<String>((ref) async {
  return ref.read(dataProvider).getUserData();
});*/
int c = 18;
DateTime time = DateTime.now();
final counterStateProvider = StateProvider<DateTime>((ref) {return time;});

//final counterController = StateNotifierProvider <CounterNotifier, int>
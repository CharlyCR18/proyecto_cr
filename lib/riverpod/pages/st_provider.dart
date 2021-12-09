import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:proyecto_cr/riverpod/pages/widgets/button_increment.dart';
import 'package:proyecto_cr/riverpod/providers/providers.dart';
import 'package:riverpood/pages/widgets/button_decrement.dart';
import 'package:riverpood/pages/widgets/button_increment.dart';
import 'package:riverpood/providers/providers.dart';

class StProvider extends ConsumerWidget {
  const StProvider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final counter = ref.watch(counterStateProvider);

    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 50,
            ),
            Text('Un contador: $counter'),
            const SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: const [
                ButtonIncrement(),
                ButtonDecrement(),
              ],
            )
          ],
        ),
      ),
    );
  }
}

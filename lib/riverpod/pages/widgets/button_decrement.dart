import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpood/providers/providers.dart';

class ButtonDecrement extends ConsumerWidget {
  const ButtonDecrement({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //final counter = ref.watch(counterStateProvider);
    return ElevatedButton(
      onPressed: () => ref.watch(counterStateProvider.state),
      child: const Text('Decrement'),
    );
  }
}

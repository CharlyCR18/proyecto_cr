import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    '/stprovider',
                  );
                },
                child: const Text("StateProvider")),
            ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    '/stnotifierprovider',
                  );
                },
                child: const Text("StateNotifierProvider"))
          ],
        ),
      ),
    );
  }
}

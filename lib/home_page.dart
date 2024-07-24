import 'dart:async';

import 'package:background_app/counter_service.dart';
import 'package:background_app/data_source.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Timer? timer;
  String formattedDate =
      DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());
  int tapCount = 0;
  _incrementCounter() {
    setState(() {
      tapCount++;
      formattedDate = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());
      debugPrint(formattedDate);
    });
    // insertData();
    startService();
  }

  insertData() async {
    Map<String, dynamic> data = {
      'timestamp$tapCount': FieldValue.serverTimestamp(),
    };
    try {
      await DataSource().insertDataFirebase(data);
      debugPrint('Data inserted successfully');
    } catch (e) {
      debugPrint('Error: $e');
    }
  }

  // @override
  // void initState() {
  //   super.initState();
  //   timer = Timer.periodic(
  //       const Duration(seconds: 10), (Timer t) => _incrementCounter());
  // }

  // @override
  // void dispose() {
  //   timer?.cancel();
  //   super.dispose();
  // }
   static const platform = MethodChannel('com.example.app/service');
   void startService() {
    platform.invokeMethod('startService');
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Home Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Date And Time',
            ),
            ValueListenableBuilder(
              valueListenable: CounterService.instance().count,
              builder: (context, countValue, child) {
                return Text('Counting: $countValue');
              },
            ),
            Text(
              formattedDate,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

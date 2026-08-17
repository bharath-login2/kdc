import 'dart:developer';


import 'package:call_e_log/call_log.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kdc_chitty_mainnew/screens/myApp.dart';
import 'package:workmanager/workmanager.dart';
void callbackDispatcher() {
  Workmanager().executeTask((dynamic task, dynamic inputData) async {
    // print('Background Services are Working!');
    try {
      final Iterable<CallLogEntry> cLog = await CallLog.get();
      // print('Queried call log entries');
      for (CallLogEntry entry in cLog) {
        // print('-------------------------------------');
        // print('F. NUMBER  : ${entry.formattedNumber}');
        // print('C.M. NUMBER: ${entry.cachedMatchedNumber}');
        // print('NUMBER     : ${entry.number}');
        // print('NAME       : ${entry.name}');
        // print('TYPE       : ${entry.callType}');
        // print(
        //     'DATE       : ${DateTime.fromMillisecondsSinceEpoch(entry.timestamp!)}');
        // print('DURATION   : ${entry.duration}');
        // print('ACCOUNT ID : ${entry.phoneAccountId}');
        // print('ACCOUNT ID : ${entry.phoneAccountId}');
        // print('SIM NAME   : ${entry.simDisplayName}');
        // print('-------------------------------------');
      }
      return true;
    } on PlatformException catch (e, s) {
      // print(e);
      // print(s);
      return true;
    }
  });
}
// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   runApp( const MyApp());
//   Workmanager().initialize(callbackDispatcher, isInDebugMode: true);
// }
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.dumpErrorToConsole(details);
    log(details.exceptionAsString());
    if (details.stack != null) {
      log(details.stack.toString());
    }
  };

  await Firebase.initializeApp();

  Workmanager().initialize(
    callbackDispatcher,
    isInDebugMode: true,
  );

  runApp(const MyApp());
}
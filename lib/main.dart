import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:full_pay/data/local/storage_repository.dart';
import 'package:full_pay/services/firebase_options.dart';

import 'app/app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await StorageRepository.init();

  runApp(App());
}

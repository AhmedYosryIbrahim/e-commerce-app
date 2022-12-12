import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'app.dart';
import 'core/utils/bloc_observer.dart';
import 'injector.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  Bloc.observer = MyBlocObserver();
  await EasyLocalization.ensureInitialized();
  await Hive.initFlutter();

  await Hive.openBox<dynamic>('userData');
  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('ar')],
      path: "assets/langs",
      startLocale: const Locale('ar'),
      saveLocale: true,
      child: const MyApp(),
    ),
  );
}

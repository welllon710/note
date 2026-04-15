import 'package:flutter/material.dart';
import 'package:flutter_note/src/pages/home_page.dart';
import 'package:flutter_note/src/utils/HiveUtils.dart';
import 'package:flutter_note/src/utils/SPUtils.dart';
import 'package:flutter_note/src/utils/SecureHiveUtil.dart';
import 'package:flutter_note/src/utils/SharedPreferencesAsyncUtil.dart';
import 'package:flutter_note/src/utils/SnackBarHepler.dart';
import 'package:flutter_note/src/utils/theme_manage.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveUtil().init();
  await SecureHiveUtil.init();
  await ThemeManager().init();
  await SPUtils.init();
  await SharedPreferencesAsyncUtil.init();
  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => ThemeManager())],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final themeManager = Provider.of<ThemeManager>(context);
    return MaterialApp(
      title: 'Flutter Demo',
      theme: themeManager.currentTheme,
      scaffoldMessengerKey: scaffoldMessengerGlobalKey,
      home: const HomePage(),
    );
  }
}

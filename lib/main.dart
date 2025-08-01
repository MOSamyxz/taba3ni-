import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:taba3ni/core/service/app_service.dart';
import 'package:taba3ni/config/injection/injection.dart';
import 'package:taba3ni/teba3ni.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:device_preview/device_preview.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  
  await dotenv.load(fileName: ".env");

  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL']!,
    anonKey: dotenv.env['SUPABASE_ANON_KEY']!,
  );

  await init();  
  await sl<AppService>().initApp();  
  runApp(DevicePreview(
        enabled: !kReleaseMode,

     builder: (context) =>  const Taba3ni()));
}


import 'dart:io';
import 'package:codaula/database/psicologo_dao.dart';
import 'package:codaula/model/psicologo_model.dart';
import 'package:codaula/database/paciente_dao.dart';
import 'package:codaula/model/paciente_model.dart';
import 'package:codaula/screens/android/apppsico.dart';
import 'package:flutter/material.dart';

void main() {
 WidgetsFlutterBinding.ensureInitialized();


  if(Platform.isAndroid){
    debugPrint('app no android');
    runApp(AppPsico());
  }
  if(Platform.isIOS){
    debugPrint('app no IOS');
  }
  //runApp(MyApp());
}




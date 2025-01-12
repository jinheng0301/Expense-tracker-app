import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:track_your_expenses/app.dart';
import 'package:track_your_expenses/simple_bloc_observer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      appId: '1:1078796524667:android:ea0c47c60b316b2e9416de',
      apiKey: 'AIzaSyD8m8Cvij4r7WpKskN7VtvTl6jJBOgFxNs',
      projectId: 'expense-tracker-141c7',
      storageBucket: 'expense-tracker-141c7.firebasestorage.app',
      messagingSenderId: '297855924061',
    ),
  );
  Bloc.observer = SimpleBlocObserver();
  runApp(const MyApp());
}

import 'package:firebase_chat_app/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> firebaseInit() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}
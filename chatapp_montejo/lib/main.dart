
import 'package:chatapp_montejo/services/backend.dart';
import 'package:chatapp_montejo/wrapper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, orientation){
        return MultiProvider(
          providers: [
            StreamProvider<User?>(create: (BuildContext context)=>AuthenticationMethods().user, initialData: null,)
          ],
          child: MaterialApp(
            title: "Chat-App",
            debugShowCheckedModeBanner: false,
            home: Wrapper(status: getUser()),
          ),
        );
      }
    );
  }
}

Future getUser() async{
  AuthenticationMethods _auth = new AuthenticationMethods();
  User? currentUser;
  await _auth.getCurrentUser().then((result){
    currentUser = result;
    return currentUser?.emailVerified;
  });
}



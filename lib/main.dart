import 'package:flutter/material.dart';
import 'package:flutter_stetho/flutter_stetho.dart';
import 'package:provider/provider.dart';
import 'package:simple_database/local/app_db.dart';
import 'package:simple_database/local/dao/customer_dao.dart';
import 'package:simple_database/my_home.dart';

//void main() => runApp(MyApp());
void main(){
  Stetho.initialize();
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    final appDatabase=AppDb();
    return MultiProvider(
      providers: [
        Provider<CustomerDao>(
          create: (_)=>appDatabase.customerDao,
        )
      ],
      child: MaterialApp(
        theme: ThemeData(
            primaryColor: Colors.blueAccent
        ),
        home: MyHome(),
      ),
    );

  }

}
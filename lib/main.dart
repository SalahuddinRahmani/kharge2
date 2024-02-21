import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:kharge/splash.dart';
import 'about.dart';
import 'display.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Hive.initFlutter();
//   await Hive.openBox('data');
//
//   runApp(MainPage());
// }




class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController listNameController = TextEditingController();

  void _goToInputPage(BuildContext context) {
    final String listName = listNameController.text;
    Navigator.pushNamed(context, '/input', arguments: listName);
  }

  @override
  void dispose() {
    listNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: listNameController,
              decoration: InputDecoration(
                labelText: 'List Name',
              ),
            ),
            SizedBox(height: 10),
            MaterialButton(
              height: 44,
              color: Colors.blueGrey,
              onPressed: () {
                _goToInputPage(context);
              },
              child: Text(
                'Go to Input Page',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MyApp extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Data App',
      // theme: ThemeData(
      //   primarySwatch: Colors.blue,
      // ),
      initialRoute: '/',
      routes: {
        '/': (context) => InputPage(),
        '/display': (context) => DisplayPage(),
      },
    );
  }
}



class InputPage extends StatefulWidget {
  @override
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  String text = "اشتراک گذاری برنامه";
  final TextEditingController stringController = TextEditingController();
  final TextEditingController intController = TextEditingController();
  late TextEditingController dateController;

  @override
  void initState() {
    super.initState();
    final DateTime now = DateTime.now();
    final String formattedDate = DateFormat('yyyy-MM-dd').format(now);
    dateController = TextEditingController(text: formattedDate);
  }

  void _saveData(BuildContext context) {
    final String stringValue = stringController.text;
    final int intValue = int.parse(intController.text);
    final String enteredDate = dateController.text;

    final Map<String, dynamic> data = {
      'string': stringValue,
      'int': intValue,
      'date': enteredDate,
    };

    final Box box = Hive.box('data');
    box.add(data);

    stringController.clear();
    intController.clear();
    dateController.clear();

    Navigator.pushNamed(context, '/display', arguments: data);
  }

  @override
  void dispose() {
    stringController.dispose();
    intController.dispose();
    dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[200],
      appBar: AppBar(
          backgroundColor: Colors.blueGrey,
          actions: [
            PopupMenuButton(
                color: Colors.white,
                onSelected: (Value) {},
                itemBuilder: (context) => [
                  PopupMenuItem(
                    onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context){
                      return DisplayPage();
                    }));
                    },
                    child: Row(
                      children: [
                        Icon(
                          Icons.list_alt,
                          color: Colors.blue[300],
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text("لیست", style: TextStyle(color: Colors.black)),
                      ],
                    ),
                  ),



                  PopupMenuItem(
                    onTap: () {
                      // Share.share(text);
                    },
                    child: Row(
                      children: [
                        Icon(
                          Icons.share,
                          color: Colors.blue[300],
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(text, style: TextStyle(color: Colors.black)),
                      ],
                    ),
                  ),
                  PopupMenuItem(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (aa) {
                            return AboutPage2();
                          }));
                    },
                    child: Row(
                      children: [
                        Icon(
                          Icons.info_outline,
                          color: Colors.blue[300],
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          "در باره سازنده",
                          style: TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                  PopupMenuItem(
                    onTap: () {
                      exit(0);
                    },
                    child: Row(
                      children: [
                        Icon(
                          Icons.exit_to_app,
                          color: Colors.red[400],
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text("خارج شدن از برنامه",
                            style: TextStyle(color: Colors.black)),
                      ],
                    ),
                  ),
                ]),
          ],
          centerTitle: true,
          title: Text('حساب روزانه')),
      // ... rest of the code ...

      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            
            Row(

              mainAxisAlignment: MainAxisAlignment.end,
              children: [

                Container(
                  width: 110,
                  child: TextField(
                    controller: dateController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10) ),


                      ),
                      hintText: 'تاریخ',
                    ),
                  ),
                ),

                Text('       : تاریخ      ',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold)),


              ],
            ),






            SizedBox(height: 15,),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  width: 380,
                  child: TextField(
                    controller: intController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)

                        ),
                      ),
                      hintText: 'قیمت',
                    ),
                  ),
                ),
                Text('       : مبلغ پول',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
              ],
            ),
            SizedBox(height: 5,),



            Container(
              child: TextField(
                maxLines: 7,
                controller: stringController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(

                      Radius.circular(10)
                    ),
                  ),
                  hintText: 'نوت',
                ),
              ),
            ),


            SizedBox(height: 10),


            Container(
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
              width: 380,
              child: MaterialButton(
                height: 44,

                color: Colors.blueGrey,
                onPressed: () {
                  _saveData(context);
                },
                child: Text(
                  'ذخیره',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),

            SizedBox(height: 10),

            Container(
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
              width: 380,
              child: MaterialButton(
                height: 44,

                color: Colors.blueGrey,
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context){
                    return DisplayPage();
                  }));
                },
                child: Text(
                  'یادداشت ها',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),

            SizedBox(height: 10),

            Container(
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
              width: 380,
              child: MaterialButton(
                height: 44,

                color: Colors.blueGrey,
                onPressed: () {
                  intController.clear();
                  stringController.clear();
                },
                child: Text(
                  'انصراف',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

























//
//
//
//
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:hive/hive.dart';
// import 'package:hive_flutter/hive_flutter.dart';
// import 'package:intl/intl.dart';
// import 'package:kharge/splash.dart';
// import 'about.dart';
// import 'display.dart';
//
// // void main() async {
// //   WidgetsFlutterBinding.ensureInitialized();
// //   await Hive.initFlutter();
// //   await Hive.openBox('data');
// //
// //   runApp(MainPage());
// // }
//
// class MyApp extends StatelessWidget {
//
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Data App',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       initialRoute: '/',
//       routes: {
//         '/': (context) => InputPage(),
//         '/display': (context) => DisplayPage(),
//       },
//     );
//   }
// }
//
// class InputPage extends StatelessWidget {
//   String text = "اشتراک گذاری برنامه";
//   final TextEditingController stringController = TextEditingController();
//   final TextEditingController intController = TextEditingController();
//
//   void _saveData(BuildContext context) {
//     final String stringValue = stringController.text;
//     final int intValue = int.parse(intController.text);
//
//     final DateTime now = DateTime.now();
//     final String formattedDate = DateFormat('yyyy-MM-dd').format(now);
//
//     final Map<String, dynamic> data = {
//       'string': stringValue,
//       'int': intValue,
//       'date': formattedDate,
//     };
//
//     final Box box = Hive.box('data');
//     box.add(data);
//
//     stringController.clear();
//     intController.clear();
//
//     Navigator.pushNamed(context, '/display');
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.blueGrey[100],
//       drawer:Drawer(
//         backgroundColor: Colors.blueGrey[200],
//         child: ListView(
//           children: [
//             Container(
//               decoration: BoxDecoration(
//                 color: Colors.blueGrey[400],
//               ),
//               child: ListTile(
//
//                 title: Center(child: Text("لیست",style: TextStyle(fontSize: 20),)),
//                 onTap: (){
//                   Navigator.push(context, MaterialPageRoute(builder: (context){
//                     return DisplayPage();}));
//                 },
//               ),
//             ),
//
//             Container(
//               decoration: BoxDecoration(
//                 color: Colors.blueGrey[300],
//               ),
//               child: ListTile(
//                 onTap: () {
//                   showDialog(
//                       context: context,
//                       builder: (context) {
//                         return AlertDialog(
//                           backgroundColor: Colors.blueGrey[300],
//                           title: Text(
//                             "میخواهید از برنامه بیرون شوید؟",
//                             style: TextStyle(color: Colors.black87),
//                           ),
//                           actions: [
//                             MaterialButton(
//                               color: Colors.red[400],
//                               onPressed: () {
//                                 Navigator.pop(context);
//                               },
//                               child: Text(
//                                 "نخیر",
//                                 style: TextStyle(
//                                     color: Colors.white, fontSize: 20),
//                               ),
//                             ),
//                             MaterialButton(
//                               color: Colors.green[300],
//                               onPressed: () {
//                                 exit(0);
//                               },
//                               child: Text(
//                                 "بلی",
//                                 style: TextStyle(
//                                     color: Colors.white, fontSize: 20),
//                               ),
//                             ),
//                           ],
//                         );
//                       });
//                 },
//                 leading: IconButton(
//                     onPressed: null,
//                     icon: Icon(
//                       Icons.exit_to_app,
//                       size: 25,
//                       color: Colors.red[400],
//                     )),
//                 title: Text(
//
//                   "بیرون شدن از برنامه",
//                   style: TextStyle(fontSize: 20, color: Colors.black87),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ) ,
//
//       appBar: AppBar(
//           backgroundColor: Colors.blueGrey,
//           actions: [
//             PopupMenuButton(
//                 color: Colors.white,
//                 onSelected: (Value) {},
//                 itemBuilder: (context) => [
//                   PopupMenuItem(
//                     onTap: () {
//                       // Share.share(text);
//                     },
//                     child: Row(
//                       children: [
//                         Icon(
//                           Icons.share,
//                           color: Colors.blue[300],
//                         ),
//                         SizedBox(
//                           width: 5,
//                         ),
//                         Text(text, style: TextStyle(color: Colors.black)),
//                       ],
//                     ),
//                   ),
//                   PopupMenuItem(
//                     onTap: () {
//                       Navigator.push(context,
//                           MaterialPageRoute(builder: (aa) {
//                             return AboutPage2();
//                           }));
//                     },
//                     child: Row(
//                       children: [
//                         Icon(
//                           Icons.info_outline,
//                           color: Colors.blue[300],
//                         ),
//                         SizedBox(
//                           width: 5,
//                         ),
//                         Text(
//                           "در باره سازنده",
//                           style: TextStyle(color: Colors.black),
//                         ),
//                       ],
//                     ),
//                   ),
//                   PopupMenuItem(
//                     onTap: () {
//                       exit(0);
//                     },
//                     child: Row(
//                       children: [
//                         Icon(
//                           Icons.exit_to_app,
//                           color: Colors.red[400],
//                         ),
//                         SizedBox(
//                           width: 5,
//                         ),
//                         Text("خارج شدن از برنامه",
//                             style: TextStyle(color: Colors.black)),
//                       ],
//                     ),
//                   ),
//                 ]),
//           ],
//           centerTitle: true,
//           title: Text('حساب روزانه')),
//       body: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             TextField(
//               controller: stringController,
//               decoration: InputDecoration(
//                   border: OutlineInputBorder(
//                       borderRadius:
//                       BorderRadius.only(topLeft: Radius.circular(5),topRight: Radius.circular(5))),
//                   hintText: 'نوت'),
//             ),
//             // SizedBox(height: 5,),
//
//             TextField(
//               controller: intController,
//               keyboardType: TextInputType.number,
//               decoration: InputDecoration(
//                 border: OutlineInputBorder(
//                     borderRadius:
//                     BorderRadius.only(bottomLeft: Radius.circular(5),bottomRight: Radius.circular(5))),
//                 hintText: 'قیمت',
//
//
//
//
//               ),
//             ),
//             SizedBox(height: 10,),
//             MaterialButton(
//               height: 44,
//
//               color: Colors.blueGrey,
//               onPressed: () {
//                 _saveData(context);
//               },
//               child: Text('ذخیره',style: TextStyle(color: Colors.white),),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
//
//


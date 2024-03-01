import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'about.dart';
import 'display.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String ekilo = '';
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
  String note = '';
  String inte = '';
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
    // dateController.clear();

    // Navigator.pushNamed(context, '/display', arguments: data);
  }

  void validateTextField() {
    setState(() {
      note = stringController.text.isEmpty ? '!نوت خالی است' : '';
      inte = intController.text.isEmpty ? '!نرخ خالی است' : '';
    });
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
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
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
                            Text("لیست مخارج",
                                style: TextStyle(color: Colors.black)),
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
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),
                      // hintText: 'تاریخ    ',
                    ),
                  ),
                ),
                Text('       : تاریخ      ',
                    style:
                        TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  width: 380,
                  child: TextField(
                    textAlign: TextAlign.right,
                    controller: intController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),

                      errorText: note,
                      // errorStyle: TextStyle(color: Colors.red,fontSize: 15),
                      labelText: 'قیمت را وارد کنید',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 30),
                  child: Text(
                    '       : مبلغ پول',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 1,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  width: 380,
                  child: TextField(
                    textAlign: TextAlign.right,
                    // textDirection: TextDirection.rtl,

                    maxLines: 2,
                    controller: stringController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),
                      labelText: 'نوت را وارد کنید',
                      errorText: note,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 30),
                  child: Text(
                    '           : نوت   ',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(right: 66),
              child: Container(
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(10)),
                width: 380,
                child: MaterialButton(
                  height: 44,
                  color: Colors.blueGrey,
                  onPressed: () {
                    validateTextField();
                    _saveData(context);
                    showSnackbar2();
                  },
                  child: Text(
                    'ذخیره',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(right: 66),
              child: Container(
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(10)),
                width: 380,
                child: MaterialButton(
                  height: 44,
                  color: Colors.blueGrey,
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return DisplayPage();
                    }));
                  },
                  child: Text(
                    'مخارج',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(right: 66),
              child: Container(
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(10)),
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
            ),
          ],
        ),
      ),
    );
  }

  void showSnackbar2() {
    final snackBar = SnackBar(
      backgroundColor: Colors.blueGrey[400],
      duration: Duration(seconds: 2),
      content: Center(
          child: Text(
        "👍ذخیره شد ",
        style: TextStyle(fontSize: 23, color: Colors.white),
      )),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}

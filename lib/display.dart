import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:kharge/main.dart';




class DisplayPage extends StatefulWidget {
  @override
  _DisplayPageState createState() => _DisplayPageState();
}

class _DisplayPageState extends State<DisplayPage> {
  int _sumIntegers() {
    final Box box = Hive.box('data');
    int sum = 0;

    for (int i = 0; i < box.length; i++) {
      final data = box.getAt(i) as Map<String, dynamic>;
      sum += data['int'] as int;
    }

    return sum;
  }

  void _updateListTile(BuildContext context, int index) {
    final Box box = Hive.box('data');
    final data = box.getAt(index) as Map<String, dynamic>;
    final TextEditingController stringController =
    TextEditingController(text: data['string']);
    final TextEditingController intController =
    TextEditingController(text: data['int'].toString());

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Update List Tile'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Enter new values:'),
            TextField(
              controller: stringController,
              decoration: InputDecoration(labelText: 'نوت'),
            ),
            TextField(
              controller: intController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'قیمت'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              final String newString = stringController.text;
              final int newInt = int.parse(intController.text);

              final Map<String, dynamic> newData = {
                'string': newString,
                'int': newInt,
                'date': data['date'],
              };

              box.putAt(index, newData);

              Navigator.pop(context);
            },
            child: Text('آپدیت'),
          ),
          TextButton(
            onPressed: () {
              box.deleteAt(index); // Delete the item from the box
              Navigator.pop(context);
            },
            child: Text('حذف'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('برگشت'),
          ),
        ],
      ),
    );
  }

  void _calculateSum() {
    final int sum = _sumIntegers();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('کل مجموع'),
        content: Text(':مجموع $sum'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Box box = Hive.box('data');

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.blueGrey[100],
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.blueGrey,
          title: Text('لیست',style: TextStyle(fontSize: 25),),
          bottom: TabBar(

            indicatorColor: Colors.black87,
            tabs: [

              Tab(text: 'روز'),
              Tab(text: 'هفته'),
              Tab(text: 'ماه'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            ListView.builder(
              itemCount: box.length,
              itemBuilder: (context, index) {
                final data = box.getAt(index) as Map<String, dynamic>;

                return Container(
                  decoration: BoxDecoration(
                      boxShadow: <BoxShadow>[],
                      color: Colors.blueGrey[300],
                      // gradient: LinearGradient(colors: [
                      //   Color.fromRGBO(255, 200, 100, 1),
                      //   Color.fromRGBO(235, 160, 26, 1.0),
                      //
                      //
                      // ]),
                      // color: Colors.amber[50],
                      border: Border.all(color: Colors.black87),
                      borderRadius: BorderRadius.circular(10.0)),
                  child: ListTile(
                    title: Text(':قیمت ${data['int']}'),
                    subtitle:   Text('Date: ${data['date']}'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(data['string']),
                        SizedBox(width: 22,),
                        IconButton(
                            color: Colors.red[400],
                            icon: Icon(Icons.delete),
                            onPressed: () {
                              //////////
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      backgroundColor: Colors.blueGrey[300],
                                      title: Text(
                                        "حذف شود؟",
                                        style: TextStyle(color: Colors.black87),
                                      ),
                                      actions: [
                                        MaterialButton(
                                          color: Colors.red[400],
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text(
                                            "نخیر",
                                            style: TextStyle(
                                                color: Colors.white, fontSize: 20),
                                          ),
                                        ),
                                        MaterialButton(
                                          color: Colors.green[400],
                                          // onPressed: () =>{ box.deleteAt(index),Navigator.pop(context),showSnackbar2()},
                                          onPressed: (){
                                            setState(()=>{ box.deleteAt(index),Navigator.pop(context),showSnackbar2()});
                                          },

                                          // ;
                                          //
                                          //
                                          child: Text(
                                            "بلی",
                                            style: TextStyle(
                                                color: Colors.white, fontSize: 20),
                                          ),
                                        ),
                                      ],
                                    );
                                  });

                            }),
                      ],
                    ),
                    onTap: () => _updateListTile(context, index),
                  ),
                );
              },
            ),
            ListView.builder(
              itemCount: box.length,
              itemBuilder: (context, index) {
                final data = box.getAt(index) as Map<String, dynamic>;

                return Container(
                  decoration: BoxDecoration(
                      boxShadow: <BoxShadow>[],
                      color: Colors.blueGrey[300],
                      // gradient: LinearGradient(colors: [
                      //   Color.fromRGBO(255, 200, 100, 1),
                      //   Color.fromRGBO(235, 160, 26, 1.0),
                      //
                      //
                      // ]),
                      // color: Colors.amber[50],
                      border: Border.all(color: Colors.black87),
                      borderRadius: BorderRadius.circular(10.0)),
                  child: ListTile(

                    title: Text('Integer: ${data['int']}'),
                    subtitle: Text(data['string']),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('Week: ${data['date']}'),
                        SizedBox(width: 22,),
                        IconButton(
                            color: Colors.red[400],
                            icon: Icon(Icons.delete),
                            onPressed: () {
                              //////////
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      backgroundColor: Colors.blueGrey[400],
                                      title: Text(
                                        "حذف شود؟",
                                        style: TextStyle(color: Colors.black87),
                                      ),
                                      actions: [
                                        MaterialButton(
                                          color: Colors.red[400],
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text(
                                            "نخیر",
                                            style: TextStyle(
                                                color: Colors.white, fontSize: 20),
                                          ),
                                        ),
                                        MaterialButton(
                                          color: Colors.green[400],
                                          // onPressed: () =>{ box.deleteAt(index),Navigator.pop(context),showSnackbar2()},
                                          onPressed: (){
                                            setState(()=>{ box.deleteAt(index),Navigator.pop(context),showSnackbar2()});
                                          },

                                          // ;
                                          //
                                          //
                                          child: Text(
                                            "بلی",
                                            style: TextStyle(
                                                color: Colors.white, fontSize: 20),
                                          ),
                                        ),
                                      ],
                                    );
                                  });

                            }),
                      ],
                    ),
                    onTap: () => _updateListTile(context, index),
                  ),
                );
              },
            ),
            ListView.builder(
              itemCount: box.length,
              itemBuilder: (context, index) {
                final data = box.getAt(index) as Map<String, dynamic>;

                return Container(
                  decoration: BoxDecoration(
                      boxShadow: <BoxShadow>[],
                      color: Colors.blueGrey[300],
                      // gradient: LinearGradient(colors: [
                      //   Color.fromRGBO(255, 200, 100, 1),
                      //   Color.fromRGBO(235, 160, 26, 1.0),
                      //
                      //
                      // ]),
                      // color: Colors.amber[50],
                      border: Border.all(color: Colors.black87),
                      borderRadius: BorderRadius.circular(10.0)),
                  child: ListTile(
                    title:   Text('Integer: ${data['int']}'),
                    subtitle: Text('Month: ${data['date']}'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(data['string']),
                        // onPressed: () {
                        //   box.deleteAt(index); // Delete the item from the box
                        //   setState(() {}); // Update the UI after deletion
                        // },
                        IconButton(
                            color: Colors.red[400],
                            icon: Icon(Icons.delete),
                            onPressed: () {
                              //////////
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      backgroundColor: Colors.blueGrey[300],
                                      title: Text(
                                        "حذف شود؟",
                                        style: TextStyle(color: Colors.black87),
                                      ),
                                      actions: [
                                        MaterialButton(
                                          color: Colors.red[400],
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text(
                                            "نخیر",
                                            style: TextStyle(
                                                color: Colors.white, fontSize: 20),
                                          ),
                                        ),
                                        MaterialButton(
                                          color: Colors.green[400],
                                          // onPressed: () =>{ box.deleteAt(index),Navigator.pop(context),showSnackbar2()},
                                    onPressed: (){
                                            setState(()=>{ box.deleteAt(index),Navigator.pop(context),showSnackbar2()});
                                    },

                                    // ;
                                          //
                                          //
                                          child: Text(
                                            "بلی",
                                            style: TextStyle(
                                                color: Colors.white, fontSize: 20),
                                          ),
                                        ),
                                      ],
                                    );
                                  });

                            }),
                      ],
                    ),
                    onTap: () => _updateListTile(context, index),
                  ),
                );
              },
            ),
          ],
        ),

        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            FloatingActionButton(
              backgroundColor: Colors.blueGrey,
              onPressed: _calculateSum,
              child: Text('مجموع',style: TextStyle(color: Colors.white),),
            ),
            SizedBox(height: 16),
            FloatingActionButton(
              backgroundColor: Colors.blueGrey,
              onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context){
                return InputPage();
              }));
              },
              child: Icon(Icons.add),
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
      content: Center(child: Text("👍حذف شد ",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold,color: Colors.black),)),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

}
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Box studentBox;
  TextEditingController controller = TextEditingController();
  @override
  void initState() {
    studentBox = Hive.box("Student");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text("Hive"),
        actions: [
          InkWell(
            onTap: () {
              showDialog();
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: Icon(Icons.add),
            ),
          ),
        ],
      ),
      body: ValueListenableBuilder(
        valueListenable: Hive.box("Student").listenable(),
        builder: (context, value, child) {
          return ListView.builder(
            itemCount: studentBox.keys.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  tileColor: Colors.green,
                  title: Text(studentBox.getAt(index).toString()),
                ),
              );
            },
          );
        },
      ),
    );
  }

  showDialog() {
    showModalBottomSheet(
        context: context,
        builder: (builder) {
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                TextField(
                  controller: controller,
                  decoration: InputDecoration(
                    hintText: "!@#%^*123456789",
                    labelText: "Text",
                    hintStyle: TextStyle(color: Colors.black),
                    labelStyle: TextStyle(color: Colors.black),
                    suffix: Icon(Icons.keyboard),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black)),
                  ),
                ),
                Column(
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.only(left: 15.0, right: 15.0, top: 15.0),
                      child: InkWell(
                        onTap: () {
                          studentBox.add(controller.text);
                          controller.clear();
                          Navigator.pop(context);
                        },
                        child: SizedBox(
                          height: 50.0,
                          width: 330.0,
                          child: Card(
                            color: Colors.green,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            child: Center(child: Text("Submit")),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          );
        });
  }
}

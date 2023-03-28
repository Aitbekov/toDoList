import 'package:first_api/data/database.dart';
import 'package:first_api/util/dialog_box.dart';
import 'package:first_api/util/todo_tile.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomePage extends StatefulWidget {

  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  // reference the hive box
  final _myBox = Hive.box('mybox');
  ToDoDataBase dataBase = ToDoDataBase();

  @override
  void initState() {

    // if this is the 1st time ever opening the app, then create default data
 if(_myBox.get('TODOLIST') == null){
  dataBase.createInitialData();
 }else{
   // there already exists data
   dataBase.loadData();
 }

    super.initState();
  }

  //text controller
  final TextEditingController _controller = TextEditingController();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[200],
      appBar: AppBar(
        title: Text('TO DO'),
        elevation: 0,
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewTask,
        child: const Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: dataBase.toDoList.length,
        itemBuilder: (context, index) {
          return ToDoTile(
            taskName: dataBase.toDoList[index][0],
            taskCompleted: dataBase.toDoList[index][1],
            onChanged: (value) => checkBoxChanged(value, index),
            deleteFunction: (context) => deleteTask(index),

          );
        },
      ),
    );
  }

  // checkbox was tapped
  void saveNewTask() {
    setState(() {
      dataBase.toDoList.add([_controller.text, false]);
     _controller.clear();
    });
    Navigator.of(context).pop();
    dataBase.updateDataBase();

  }

  void checkBoxChanged(bool? value, int index) {
    setState(() {
      dataBase.toDoList[index][1] = !dataBase.toDoList[index][1];
    });
    dataBase.updateDataBase();
  }

  void createNewTask() {
    showDialog(
        context: context,
        builder: (context) {
          return DialogBox(
            controller: _controller,
            onSave: saveNewTask,
            onCancel: () => Navigator.of(context).pop(),

          );
        });
  }

  //delete task
void deleteTask(int index){
     setState(() {
       dataBase.toDoList.removeAt(index);
     });
     dataBase.updateDataBase();
}
}









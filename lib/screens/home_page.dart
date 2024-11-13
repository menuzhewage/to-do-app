import 'package:flutter/material.dart';
import 'package:my_to_do/constraints/colors.dart';
import 'package:my_to_do/screens/list_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _controller = TextEditingController();
  DateTime? selectedDate;

  // Updated to include deadline
  List toDoList = [
    ['learn flutter', false, null],
    ['learn web', false, null],
    ['learn java', false, null],
  ];

  void checkBoxChanged(int index) {
    setState(() {
      toDoList[index][1] = !toDoList[index][1];
    });
  }

  Future<void> saveNewTask() async {
    // Prompt for deadline selection
    await selectDate(context);

    setState(() {
      toDoList.add([_controller.text, false, selectedDate]);
      _controller.clear();
      selectedDate = null; // Reset selectedDate after adding the task
    });
  }

  void deleteTask(int index) {
    setState(() {
      toDoList.removeAt(index);
    });
  }

  Future<void> selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null) {
      setState(() {
        selectedDate = pickedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        toolbarHeight: 70,
        backgroundColor: bgColor,
        title: const Center(
          child: Padding(
            padding: EdgeInsets.all(30),
            child: Text(
              "Things To Do!",
              style: TextStyle(
                fontSize: 24,
                color: textColor,
              ),
            ),
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: toDoList.length,
        itemBuilder: (BuildContext context, index) {
          return ToDoList(
            taskName: toDoList[index][0],
            taskCompleted: toDoList[index][1],
            deadline: toDoList[index][2],
            onChanged: (value) => checkBoxChanged(index),
            deleteFunction: (context) => deleteTask(index),
          );
        },
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(
          left: 20,
          right: 20,
        ),
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: TextField(
                  controller: _controller,
                  decoration: InputDecoration(
                    hintText: 'Add new to-do item',
                    filled: true,
                    fillColor: bgColor2,
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.white,
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.white,
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
              ),
            ),
            FloatingActionButton(
              onPressed: saveNewTask,
              child: const Icon(Icons.add),
            ),
          ],
        ),
      ),
    );
  }
}

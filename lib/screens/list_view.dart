import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../constraints/colors.dart';
import 'package:intl/intl.dart';

class ToDoList extends StatelessWidget {
  const ToDoList({
    super.key,
    required this.taskName,
    required this.taskCompleted,
    required this.onChanged,
    required this.deleteFunction,
    this.deadline,
  });

  final String taskName;
  final bool taskCompleted;
  final DateTime? deadline;
  final Function(bool?)? onChanged;
  final Function(BuildContext) deleteFunction;

  String timeLeft(DateTime deadline) {
    final now = DateTime.now();
    final difference = deadline.difference(now);

    if (difference.isNegative) {
      return 'Deadline Passed';
    }

    final hoursLeft = difference.inHours;
    final minutesLeft = difference.inMinutes % 60;

    return '$hoursLeft hours and $minutesLeft minutes left';
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 20,
        left: 20,
        right: 20,
        bottom: 0,
      ),
      child: Slidable(
        endActionPane: ActionPane(
          motion: const StretchMotion(),
          children: [
            SlidableAction(
              onPressed: deleteFunction,
              icon: Icons.delete,
              borderRadius: BorderRadius.circular(15),
            )
          ],
        ),
        child: Container(
          padding: const EdgeInsets.all(25),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: bgColor2,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Checkbox(
                    value: taskCompleted,
                    onChanged: onChanged,
                    checkColor: bgColor,
                    activeColor: Colors.white,
                    side: const BorderSide(
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    taskName,
                    style: TextStyle(
                      color: textColor,
                      fontSize: 18,
                      decoration: taskCompleted
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                      decorationColor: Colors.white,
                      decorationThickness: 2,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 2,),
              if (deadline != null)
                Padding(
                  padding: const EdgeInsets.only(left: 48.0),
                  child: Text(
                    'Deadline: ${DateFormat('dd-MMM-yyyy').format(deadline!)}',
                    style: const TextStyle(
                      color: textColor,
                      fontSize: 14,
                    ),
                  )
                ),
                if (deadline != null)
                Padding(
                  padding: const EdgeInsets.only(left: 48.0),
                  child: Text(
                    'Time Left: ${timeLeft(deadline!)}',
                    style: const TextStyle(
                      color: textColor,
                      fontSize: 14,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

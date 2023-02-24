import 'package:getx_todo_list/app/data/models/task.dart';
import 'package:getx_todo_list/app/data/providers/task/provider.dart';

class TaskRepository {
  final TaskProvider taskProvider;

  TaskRepository(this.taskProvider);

  List<Task> readTask() {
    return taskProvider.readTask();
  }

  void writeTask(List<Task> tasks) {
    taskProvider.writeTasks(tasks);
  }
}

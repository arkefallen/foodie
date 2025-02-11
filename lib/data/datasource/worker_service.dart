import 'dart:math';

import 'package:foodie/data/datasource/notification_service.dart';
import 'package:foodie/data/datasource/restaurant_service.dart';
import 'package:workmanager/workmanager.dart';

enum WorkerType {
  dailyReminder(
      uniqueName: "id.arkefallen.foodie", taskName: "id.arkefallen.foodie");

  final String uniqueName;
  final String taskName;

  const WorkerType({required this.uniqueName, required this.taskName});
}

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    if (task == WorkerType.dailyReminder.taskName ||
        task == WorkerType.dailyReminder.uniqueName) {
      final restaurants = await RestaurantService().getListRestaurants();
      final randomIndex = Random().nextInt(restaurants.restaurants!.length);
      final restaurantName =
          restaurants.restaurants?[randomIndex].name.toString();
      final notificationService = NotificationService();
      await notificationService.init();
      notificationService.scheduleDailyReminderOnElevenAM(
          data: restaurantName.toString());
    }
    return Future.value(true);
  });
}

class WorkManagerService {
  final Workmanager _workManager;

  WorkManagerService() : _workManager = Workmanager();

  Future<void> init() async {
    await _workManager.initialize(callbackDispatcher, isInDebugMode: false);
  }

  Future<void> runPeriodicTask() async {
    await _workManager.registerPeriodicTask(
      WorkerType.dailyReminder.uniqueName,
      WorkerType.dailyReminder.taskName,
      frequency: const Duration(days: 1),
      initialDelay: Duration.zero,
    );
  }

  Future<void> cancel() async {
    await _workManager.cancelAll();
  }
}

// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:foodie/provider/daily_reminder_provider.dart';
import 'package:foodie/provider/settings_provider.dart';
import 'package:foodie/provider/theme_settings_provider.dart';
import 'package:foodie/util.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<SettingsProvider>().loadSettings();
      TextTheme textTheme = createTextTheme(context, "Manrope", "Merriweather");
      final currentTheme =
          context.read<ThemeSettingsProvider>().getTheme(textTheme);
      if (currentTheme.brightness == Brightness.dark) {
        context.read<SettingsProvider>().toggleDarkMode(true);
      } else {
        context.read<SettingsProvider>().toggleDarkMode(false);
      }
    });
  }

  Future<void> onReminderSwitchChanged(bool isEnabled) async {
    if (isEnabled) {
      await context.read<DailyReminderProvider>().requestPermission();
      final isPermissionAllowed =
          context.read<DailyReminderProvider>().permission;
      if (isPermissionAllowed != null && isPermissionAllowed == true) {
        await context
            .read<DailyReminderProvider>()
            .scheduleDailyReminderNotificationEveryElevenAM();
        context.read<SettingsProvider>().toggleDailyReminder(true);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Pengingat harian makan siang sukses diaktifkan'),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Mohon izinkan notifikasi terlebih dahulu'),
          ),
        );
        context.read<SettingsProvider>().toggleDailyReminder(false);
      }
    } else {
      await context.read<DailyReminderProvider>().cancelNotification();
      context.read<SettingsProvider>().toggleDailyReminder(false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Pengingat harian makan siang telah dinonaktifkan'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = createTextTheme(context, "Manrope", "Merriweather");
    return Scaffold(
      appBar: AppBar(
        title: const Text("Setelan"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            SwitchListTile(
              value: context.watch<SettingsProvider>().isDarkMode,
              onChanged: (value) {
                if (value) {
                  context.read<ThemeSettingsProvider>().setDarkMode(textTheme);
                } else {
                  context.read<ThemeSettingsProvider>().setLightMode(textTheme);
                }
                context.read<SettingsProvider>().toggleDarkMode(value);
              },
              title: const Text(
                "Mode Gelap",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: const Text(
                  "Ubah tema aplikasi Anda menjadi mode gelap/terang"),
            ),
            const SizedBox(
              height: 8.0,
            ),
            SwitchListTile(
              value: context.watch<SettingsProvider>().dailyReminder,
              onChanged: (value) {
                onReminderSwitchChanged(value);
              },
              title: const Text(
                "Pengingat Harian",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: const Text(
                  "Atur notifikasi pengingat makan siang setiap pukul 11.00 A.M"),
            ),
          ],
        ),
      ),
    );
  }
}

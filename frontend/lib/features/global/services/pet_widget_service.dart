import 'dart:io';

import 'package:bite_buddy/features/global/constants/app_images.dart';
import 'package:bite_buddy/features/pet/domain/entities/pet_entity.dart';
import 'package:flutter/widgets.dart';
import 'package:home_widget/home_widget.dart';

// Keeps the home-screen widget up to date. The app saves the buddy's details
// here whenever it loads the pet; the widget itself (Android:
// BuddyWidgetProvider.kt, iOS: ios/BuddyWidget/BuddyWidget.swift) works out
// the mood from the last meal time, so it stays right between app opens.
class PetWidgetService {
  static const _androidName = 'BuddyWidgetProvider';
  static const _iOSName = 'BuddyWidget';
  // iOS widgets can only read data from a shared App Group; this id must
  // match the one added in Xcode (see ios/BuddyWidget/SETUP.md)
  static const appGroupId = 'group.com.example.biteBuddy';

  String? _savedImageFor;

  Future<void> init() async {
    if (Platform.isIOS) await HomeWidget.setAppGroupId(appGroupId);
  }

  Future<void> update(PetEntity pet) async {
    try {
      await (
        HomeWidget.saveWidgetData<String>('petName', pet.name),
        HomeWidget.saveWidgetData<int>('streak', pet.streak),
        HomeWidget.saveWidgetData<int>('mealsEaten', pet.mealsEaten),
        // A string, because Android stores large ints differently from small
        HomeWidget.saveWidgetData<String>(
          'lastFedAt',
          pet.lastFedAt?.millisecondsSinceEpoch.toString() ?? '',
        ),
      ).wait;
      // The picture only needs saving again when the species changes
      if (_savedImageFor != pet.speciesKey) {
        await HomeWidget.saveImage(
          'petImage',
          AssetImage(AppImages.pet(pet.speciesKey)),
        );
        _savedImageFor = pet.speciesKey;
      }
      await HomeWidget.updateWidget(
        androidName: _androidName,
        iOSName: _iOSName,
      );
    } catch (e) {
      // A widget that didn't update is never worth interrupting the app for
      debugPrint('Home widget update failed: $e');
    }
  }

  // After signing out, so the widget doesn't show the last user's buddy
  Future<void> clear() async {
    try {
      for (final key in ['petName', 'streak', 'mealsEaten', 'lastFedAt']) {
        await HomeWidget.saveWidgetData<Object>(key, null);
      }
      await HomeWidget.saveWidgetData<String>('petImage', null);
      _savedImageFor = null;
      await HomeWidget.updateWidget(
        androidName: _androidName,
        iOSName: _iOSName,
      );
    } catch (e) {
      debugPrint('Home widget clear failed: $e');
    }
  }
}

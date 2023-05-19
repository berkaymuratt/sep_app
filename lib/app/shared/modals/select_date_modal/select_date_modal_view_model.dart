import 'package:flutter/material.dart';
import 'package:sep_app/app/shared/view_models/view_model_base.dart';
import 'package:sep_app/locator.dart';
import 'package:sep_app/repositories/db/doctors_repository.dart';

class SelectDateModalViewModel extends ViewModelBase {
  final DoctorsRepository _doctorsRepository = locator<DoctorsRepository>();

  DateTime? _selectedDate;
  DateTime? _selectedDateWithTime;

  List<DateTime>? _availableTimes;

  DateTime? get selectedDateWithTime => _selectedDateWithTime;

  set selectedDateWithTime(DateTime? selectedDateWithTime) {
    _selectedDateWithTime = selectedDateWithTime;
    notifyListeners();
  }

  List<DateTime>? get availableTimes => _availableTimes;

  set availableTimes(List<DateTime>? availableTimes) {
    _availableTimes = availableTimes;
    notifyListeners();
  }

  DateTime? get selectedDate => _selectedDate;

  Future<List<DateTime>?> getAvailableTimes(
      String doctorId, DateTime date) async {

    try {
      state = ViewState.BUSY;

      var busyTimes = await _doctorsRepository.getBusyTimes(doctorId, date);
      _availableTimes = [];

      for (int hour = 8; hour < 19; hour++) {

        var firstTime = DateTime(date.year, date.month, date.day, hour, 00);

        if (_isTimeAvailable(busyTimes, firstTime)) {
          _availableTimes!.add(firstTime);
        }

        var secondTime = DateTime(date.year, date.month, date.day, hour, 30);

        if (_isTimeAvailable(busyTimes, secondTime)) {
          _availableTimes!.add(secondTime);
        }
      }
      return availableTimes;
    } catch(e) {
      _availableTimes = null;
      debugPrint(e.toString());
      errorMsg = e.toString();
      return null;
    } finally {
      state = ViewState.IDLE;
    }
  }

  set selectedDate(DateTime? selectedDate) {
    _selectedDate = selectedDate;
    notifyListeners();
  }

  void clearAvailableTimes() {
    availableTimes = null;
    notifyListeners();
  }

  bool _isTimeAvailable(List<DateTime> busyTimes, DateTime date) {
    bool isTimeAvailable = true;

    for (var time in busyTimes) {
      if (time.toIso8601String() == "${date.toIso8601String()}Z") {
        return false;
      }
    }

    return isTimeAvailable;
  }
}
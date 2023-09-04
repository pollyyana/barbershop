import 'package:barbershop/src/core/ui/constants.dart';
import 'package:barbershop/src/model/schedule_model.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class AppointmentDs extends CalendarDataSource {
  final List<ScheduleModel> schedules;
  AppointmentDs({required this.schedules});


  @override
  List<dynamic>? get appointments {
    return schedules.map((e) {
      final ScheduleModel(
        date: DateTime(:year, :month, :day),
        :hour,
        :clientName
      ) = e;

      final starTime = DateTime(year, month, day ,hour,0,0);
      final endTime = DateTime(year, month, day,hour + 1,0,0);

      return Appointment(
        color: ColorsConstants.brow,
        startTime: starTime,
        endTime: endTime,
        subject: clientName,
      );
    }).toList();
  }
  // [
  // Appointment(
  //   startTime: DateTime.now(),
  //   endTime: DateTime.now().add(
  //     const Duration(hours: 1),
  //   ),
  //   subject: 'Pollyana Medeiros'
  // ),
  // Appointment(
  //   color: ColorsConstants.brow,
  //   startTime: DateTime.now().add(
  //     const Duration(hours: 2),
  //   ),
  //   endTime: DateTime.now().add(
  //     const Duration(hours: 3),
  //   ),
  //   subject: 'Duda Medeiros'
  // ),
  // ];
}

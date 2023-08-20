enum EmployeeRegisterStateStatus {
  initial,
  success,
  error,
}

class EmployeeRegisterState {
  final EmployeeRegisterStateStatus status;
  final bool registerADM;
  final List<String> workdays;
  final List<int> workhours;

  EmployeeRegisterState.initial()
      : this(
            status: EmployeeRegisterStateStatus.initial,
            registerADM: false,
            workdays: <String>[],
            workhours: <int>[]);

  EmployeeRegisterState(
      {required this.status,
      required this.registerADM,
      required this.workdays,
      required this.workhours});

  EmployeeRegisterState copyWith({
    EmployeeRegisterStateStatus? status,
    bool? registerADM,
    List<String>? workDays,
    List<int>? workhours,
  }) {
    return EmployeeRegisterState(
      status: status ?? this.status,
      registerADM: registerADM ?? this.registerADM,
      workdays: workDays ?? this.workdays,
      workhours: workhours ?? this.workhours,
    );
  }
}

import 'package:barbershop/src/core/ui/barbershop_icon.dart';
import 'package:barbershop/src/core/ui/helpers/form_helper.dart';
import 'package:barbershop/src/core/ui/helpers/messages.dart';
import 'package:barbershop/src/core/ui/widgets/hours_panel.dart';
import 'package:barbershop/src/features/schedule/schedule_state.dart';
import 'package:barbershop/src/features/schedule/schedule_vm.dart';
import 'package:barbershop/src/features/schedule/widgets/schedule_calendar.dart';
import 'package:barbershop/src/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:validatorless/validatorless.dart';

import '../../core/ui/constants.dart';
import '../../core/ui/widgets/avatar_widget.dart';

class SchedulePage extends ConsumerStatefulWidget {
  const SchedulePage({super.key});

  @override
  ConsumerState<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends ConsumerState<SchedulePage> {
  var dateFormat = DateFormat('dd/MM/yyyy');
  var showCalendar = false;
  final formKey = GlobalKey<FormState>();
  final clienteEC = TextEditingController();
  final dateEC = TextEditingController();

  get scheduleVm => null;

  @override
  void dispose() {
    clienteEC.dispose();
    dateEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userModel = ModalRoute.of(context)!.settings.arguments as UserModel;


    final scheduleVm = ref.watch(scheduleVmProvider.notifier);

    final employeeData = switch(userModel){
      UserModelADM(:final workDays, :final workHours)=>(
        workDays: workDays!,
        workHours: workHours!
      ),
      UserModelEmployee(:final workDays, :final workHours)=> (
         workDays: workDays,
        workHours: workHours
      ),
    };

    ref.listen(scheduleVmProvider.select((state) => state.status),(_, status){
      switch(status){
        case ScheduleStateStatus.initial:
        break;
        case ScheduleStateStatus.success:
        Messages.showSuccess('Cliente agendado com sucesso', context);
        Navigator.of(context).pop();
        case ScheduleStateStatus.error:
        Messages.showError('Erro ao registrar agendamento', context);
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Agendar Cliente '),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Form(
            key: formKey,
            child: Center(
              child: Column(
                children: [
                  const AvatarWidget(hideUploadButton: true),
                  const SizedBox(
                    height: 24,
                  ),
                   Text(
                    userModel.name,
                    // 'Nome e Sobrenome',
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    height: 37,
                  ),
                  TextFormField(
                    controller: clienteEC,
                    validator: Validatorless.required('Cliente Obrigatorio'),
                    decoration: const InputDecoration(
                      label: Text('Cliente'),
                    ),
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  TextFormField(
                    readOnly: true,
                    controller: dateEC,
                    validator: Validatorless.required(
                        'Selecione a data de agendamento'),
                    onTap: () {
                      setState(() {
                        showCalendar = true;
                      });
                      context.unfocus();
                    },
                    decoration: const InputDecoration(
                        label: Text('Selecione uma data'),
                        hintText: 'Selecione uma Data',
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        suffixIcon: Icon(
                          BarbershopIcon.calendar,
                          color: ColorsConstants.brow,
                          size: 18,
                        )),
                  ),
                  Offstage(
                    offstage: !showCalendar,
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 24,
                        ),
                        ScheduleCalendar(
                          cancelPressed: () {
                            setState(() {
                              showCalendar = false;
                            });
                          },
                          okPressed: (DateTime value) {
                            setState(() {
                              dateEC.text = dateFormat.format(value);
                              scheduleVm.dateSelect(value);
                              showCalendar = false;
                            });
                          },
                          workDays: employeeData.workDays,
                        ),
                      ],

                    ),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  HoursPanel.singleSelection(
                    startTime: 6,
                    endTime: 23,
                    onHourPressed: scheduleVm.hourSelect,
                    enabledTime:  employeeData.workHours,
                    // enabledTime: const [6, 7, 8],
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(56)),
                    onPressed: () {
                      switch (formKey.currentState?.validate()) {
                        case null || false:
                          Messages.showError('Dados Incompletos', context);
                        case true:
                          //chamada vm
                          final hourSelected = ref.watch(scheduleVmProvider
                              .select((state) => state.scheduleHour != null));
                          if (hourSelected) {
                            //register
                            scheduleVm.register(userModel: userModel, clientName: clienteEC.text);
                          } else {
                            Messages.showError(
                                'Por favor selecione um horario de atendimento',
                                context);
                          }
                      }
                    },
                    child: const Text('AGENDAR'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

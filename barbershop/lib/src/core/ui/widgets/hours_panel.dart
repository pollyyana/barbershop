import 'package:barbershop/src/core/ui/constants.dart';
import 'package:flutter/material.dart';

class HoursPanel extends StatefulWidget {
  final List<int>? enabledTime;
  final int startTime;
  final int endTime;
  final ValueChanged<int> onHourPressed;
  final bool singleSelection;

  const HoursPanel({
    super.key,
    required this.startTime,
    required this.endTime,
    required this.onHourPressed,
    this.enabledTime,
  }) : singleSelection = false;

  const HoursPanel.singleSelection({
    super.key,
    required this.startTime,
    required this.endTime,
    required this.onHourPressed,
    this.enabledTime,
  }) : singleSelection = true;

  @override
  State<HoursPanel> createState() => _HoursPanelState();
}

class _HoursPanelState extends State<HoursPanel> {
  int? ultimaSelection;
  @override
  Widget build(BuildContext context) {
    final HoursPanel(:singleSelection) = widget;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Selecione os horarios de atendimento',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        Wrap(
          spacing: 8,
          runSpacing: 16,
          children: [
            for (int i = widget.startTime; i <= widget.endTime; i++)
              TimeButton(
                enabledTime: widget.enabledTime,
                label: '${i.toString().padLeft(2, '0')}:00',
                value: i,
                timeSelected: ultimaSelection,
                singleSelection: singleSelection,
                // onPressed: widget.onHourPressed,
                onPressed: (timeSelected) {
                  setState(() {
                    if (singleSelection) {
                      //pocibidade de tirar a seleção
                      if (ultimaSelection == timeSelected) {
                        ultimaSelection = null;
                      } else {
                        ultimaSelection = timeSelected;
                      }
                    }
                  });
                  widget.onHourPressed(timeSelected);
                },
              )
          ],
        )
      ],
    );
  }
}

class TimeButton extends StatefulWidget {
  final List<int>? enabledTime;
  final String label;
  final int value;
  final ValueChanged<int> onPressed;
  final bool singleSelection;
  final int? timeSelected;

  const TimeButton({
    super.key,
    this.enabledTime,
    required this.label,
    required this.value,
    required this.onPressed,
    required this.singleSelection,
    this.timeSelected,
  });

  @override
  State<TimeButton> createState() => _TimeButtonState();
}

class _TimeButtonState extends State<TimeButton> {
  var selected = false;

  @override
  Widget build(BuildContext context) {
    //destruction
    final TimeButton(
      :singleSelection,
      :timeSelected,
      :value,
      :label,
      :enabledTime,
      :onPressed
    ) = widget;

    if (singleSelection) {
      if (timeSelected != null) {
        if (timeSelected == value) {
          selected = true;
        } else {
          selected = false;
        }
      }
    }

    final textColor = selected ? Colors.white : ColorsConstants.grey;
    var buttonColor = selected ? ColorsConstants.brow : Colors.white;
    final buttonBorderColor =
        selected ? ColorsConstants.brow : ColorsConstants.grey;

    final disableTime = enabledTime != null && !enabledTime.contains(value);
    if (disableTime) {
      buttonColor = Colors.grey[400]!;
    }

    return InkWell(
      borderRadius: BorderRadius.circular(8),
      onTap: disableTime
          ? null
          : () {
              setState(() {
                selected = !selected;
                onPressed(value);
              });
            },
      child: Container(
        width: 64,
        height: 36,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: buttonColor,
          border: Border.all(color: buttonBorderColor),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
                fontSize: 12, color: textColor, fontWeight: FontWeight.w500),
          ),
        ),
      ),
    );
  }
}


 // TimeButton(label: '8:00'),
            // TimeButton(label: '9:00'),
            // TimeButton(label: '10:00'),
            // TimeButton(label: '11:00'),
            // TimeButton(label: '12:00'),
            // TimeButton(label: '13:00'),
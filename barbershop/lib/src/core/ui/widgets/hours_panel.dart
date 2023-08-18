import 'package:barbershop/src/core/ui/constants.dart';
import 'package:flutter/material.dart';

class HoursPanel extends StatelessWidget {

  final int startTime;
  final int endTime;

    const HoursPanel({
      super.key,
    required this.startTime,
    required this.endTime
  });


  @override
  Widget build(BuildContext context) {
    return  Column(
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
            for(int i =  startTime; i <= endTime; i++)
             TimeButton(
              label: '${i.toString().padLeft(2, '0')}:00'
              )
            // TimeButton(label: '8:00'),
            // TimeButton(label: '9:00'),
            // TimeButton(label: '10:00'),
            // TimeButton(label: '11:00'),
            // TimeButton(label: '12:00'),
            // TimeButton(label: '13:00'),
          ],
        )
      ],
    );
  }
}

class TimeButton extends StatelessWidget {
  const TimeButton({
    super.key,
    required this.label,
  });

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 64,
      height: 36,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
        border: Border.all(color: ColorsConstants.grey),
      ),
      child: Center(
        child: Text(
          label,
          style: const TextStyle(
              fontSize: 12,
              color: ColorsConstants.grey,
              fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}

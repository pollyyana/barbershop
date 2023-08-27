import 'package:barbershop/src/core/ui/barbershop_icon.dart';
import 'package:barbershop/src/core/ui/constants.dart';
import 'package:barbershop/src/model/user_model.dart';
import 'package:flutter/material.dart';

class HomeEmployeeTile extends StatelessWidget {
  // final imageNetwork = false;
  final UserModel employee;

  const HomeEmployeeTile({super.key, required this.employee});

  @override
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 100,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: ColorsConstants.grey)),
      child: Row(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: switch (employee.avatar) {
                final avatar? =>  NetworkImage(avatar),
                _ => const AssetImage(ImageConstants.avatar),
              } as ImageProvider),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 Text(
                  employee.name,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                      ),
                      onPressed: () {
                        Navigator.of(context).pushNamed('/schedule');
                      },
                      child: const Text('AGENDAR'),
                    ),
                    OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                      ),
                      onPressed: () {},
                      child: const Text('VER AGENDA'),
                    ),
                    const Icon(
                      BarbershopIcon.penEdit,
                      size: 16,
                      color: ColorsConstants.brow,
                    ),
                    const Icon(
                      BarbershopIcon.trash,
                      size: 16,
                      color: ColorsConstants.brow,
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
// image: imageNetwork
                //     ? const NetworkImage('url') as ImageProvider
                //     : const AssetImage(ImageConstants.avatar),
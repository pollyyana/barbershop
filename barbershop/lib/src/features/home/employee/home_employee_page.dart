import 'package:barbershop/src/core/providers/application_providers.dart';
import 'package:barbershop/src/core/ui/widgets/avatar_widget.dart';
import 'package:barbershop/src/core/ui/widgets/barbershop_loader.dart';
import 'package:barbershop/src/features/home/employee/home_employee_provider.dart';
import 'package:barbershop/src/features/home/home_header.dart';
import 'package:barbershop/src/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/ui/constants.dart';

class HomeEmployeePage extends ConsumerWidget {
  const HomeEmployeePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userModelAsync = ref.watch(getMeProvider);
    return Scaffold(
        body: userModelAsync.when(
      error: (error, stackTrace) {
        return const Center(
          child: Text('Erro ao carregar Pagina'),
        );
      },
      loading: () => const BarbershopLoader(),
      data: (user) {
        final UserModel(:id, :name) = user;
        return CustomScrollView(
          slivers: [
            const SliverToBoxAdapter(
              child: HomeHeader(
                hideFilter: true,
              ),
            ),
            SliverFillRemaining(
              hasScrollBody: false,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    const AvatarWidget(
                      hideUploadButton: true,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      // 'Nome e sobrenome',
                      name,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Container(
                      width: MediaQuery.sizeOf(context).width * .7,
                      height: 108,
                      decoration: BoxDecoration(
                          border: Border.all(color: ColorsConstants.grey),
                          borderRadius: BorderRadius.circular(8)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Consumer(builder: (context, ref, child) {
                            final totalAsync =
                                ref.watch(GetTotalSchedulesTodayProvider(id));
                            return totalAsync.when(
                              error: (error, stackTrace) {
                                return const Center(
                                  child: Text('Erro ao carregar total de agendamentos'),
                                );
                              },
                              loading: () => const BarbershopLoader(),
                              data: (totalSchedule) {
                                return Text(
                                  // '5',
                                  '$totalSchedule',
                                  style: const TextStyle(
                                    fontSize: 32,
                                    color: ColorsConstants.brow,
                                    fontWeight: FontWeight.w600,
                                  ),
                                );
                              },
                            );
                          }),
                          const Text(
                            'Hoje',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          minimumSize: const Size.fromHeight(56)),
                      onPressed: () {
                        Navigator.of(context)
                            .pushNamed('/schedule', arguments: user);
                      },
                      child: const Text('AGENDAR CLIENTE'),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    OutlinedButton(
                      style: OutlinedButton.styleFrom(
                          minimumSize: const Size.fromHeight(56)),
                      onPressed: () {
                        Navigator.of(context)
                            .pushNamed('/employee/schedule', arguments: user);
                      },
                      child: const Text('VER AGENDA'),
                    ),
                  ],
                ),
              ),
            )
          ],
        );
      },
    ));
  }
}

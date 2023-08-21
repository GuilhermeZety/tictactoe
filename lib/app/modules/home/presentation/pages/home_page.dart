import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:scaffold_gradient_background/scaffold_gradient_background.dart';
import 'package:tictactoe/app/core/common/constants/app_assets.dart';
import 'package:tictactoe/app/core/common/constants/app_colors.dart';
import 'package:tictactoe/app/core/common/constants/app_routes.dart';
import 'package:tictactoe/app/core/common/extensions/widget_extension.dart';
import 'package:tictactoe/app/modules/home/presentation/cubit/home_cubit.dart';
import 'package:tictactoe/app/ui/components/button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeCubit cubit = HomeCubit();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: ScaffoldGradientBackground(
        gradient: AppColors.backgrondGradient,
        body: SafeArea(
          child: BlocListener<HomeCubit, HomeState>(
            bloc: cubit,
            listener: (context, state) {
              if (state is HomeNewRoom) {
                Navigator.of(context).pushNamed(AppRoutes.newRoom, arguments: state.roomId);
              }
            },
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(
                  maxHeight: 500,
                ),
                child: Container(
                  height: double.infinity,
                  padding: const EdgeInsets.all(30),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SvgPicture.asset(
                        AppAssets.logo,
                        width: 130,
                      ).hero('logo'),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Button(
                            onPressed: () async {
                              await cubit.createRoom();
                            },
                            child: const Text('Criar sala'),
                          ).expandedH(),
                          const Gap(20),
                          Button.secondary(
                            onPressed: () async {
                              Modular.to.pushNamed(AppRoutes.joinRoom);
                            },
                            child: const Text('Entrar em uma sala'),
                          ).expandedH(),
                        ],
                      ),
                      const Gap(20),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

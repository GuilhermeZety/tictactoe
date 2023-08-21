import 'dart:developer';

import 'package:flextras/flextras.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:scaffold_gradient_background/scaffold_gradient_background.dart';
import 'package:tictactoe/app/core/common/constants/app_assets.dart';
import 'package:tictactoe/app/core/common/constants/app_colors.dart';
import 'package:tictactoe/app/core/common/constants/app_routes.dart';
import 'package:tictactoe/app/core/common/extensions/widget_extension.dart';
import 'package:tictactoe/app/core/common/utils/toasting.dart';
import 'package:tictactoe/app/modules/new_room/presentation/cubit/new_room_cubit.dart';
import 'package:tictactoe/app/ui/components/custom_app_bar.dart';
import 'package:tictactoe/app/ui/components/input.dart';
import 'package:tictactoe/app/ui/components/panel.dart';
import 'package:tictactoe/app/ui/components/qrcode.dart';

class NewRoomPage extends StatefulWidget {
  const NewRoomPage({super.key, required this.roomID});

  final int roomID;

  @override
  State<NewRoomPage> createState() => _NewRoomPageState();
}

class _NewRoomPageState extends State<NewRoomPage> {
  NewRoomCubit cubit = NewRoomCubit();

  @override
  void initState() {
    cubit.init(widget.roomID);
    super.initState();
  }

  @override
  void dispose() {
    cubit.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldGradientBackground(
      gradient: AppColors.backgrondGradient,
      appBar: CustomAppBar(
        backAction: () => cubit.exitRoom(context),
      ),
      // appBar:
      body: SafeArea(
        child: Center(
          child: BlocConsumer<NewRoomCubit, NewRoomState>(
            bloc: cubit,
            listener: (context, state) {
              if (state is NewRoomError) {
                Toasting.error(context, message: state.message);
              }
              if (state is NewRoomExit) {
                Modular.to.pop();
              }
              if (state is NewRoomJoin) {
                Modular.to.pushNamedAndRemoveUntil(AppRoutes.game, (_) => false, arguments: state.roomId);
              }
            },
            builder: (context, state) {
              return Container(
                padding: const EdgeInsets.all(30),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SvgPicture.asset(
                      AppAssets.logo,
                      width: 130,
                    ).hero('logo'),
                    const Gap(50),
                    Panel(
                      child: SeparatedColumn(
                        separatorBuilder: () => const Gap(20),
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(
                            'Nova Sala',
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.white),
                          ),
                          const Text(
                            'Peça para seu adversario ler o QRCode ou inserir o código.',
                            style: TextStyle(color: AppColors.grey_200),
                          ),
                          QrCode(data: widget.roomID.toString()),
                          Input(
                            TextEditingController(text: widget.roomID.toString()),
                            copy: true,
                            readOnly: true,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

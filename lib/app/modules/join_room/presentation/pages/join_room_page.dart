import 'dart:async';
import 'dart:developer';

import 'package:flextras/flextras.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:scaffold_gradient_background/scaffold_gradient_background.dart';
import 'package:tictactoe/app/core/common/constants/app_assets.dart';
import 'package:tictactoe/app/core/common/constants/app_colors.dart';
import 'package:tictactoe/app/core/common/constants/app_routes.dart';
import 'package:tictactoe/app/core/common/extensions/widget_extension.dart';
import 'package:tictactoe/app/core/common/utils/toasting.dart';
import 'package:tictactoe/app/modules/join_room/presentation/cubit/join_room_cubit.dart';
import 'package:tictactoe/app/ui/components/button.dart';
import 'package:tictactoe/app/ui/components/custom_app_bar.dart';
import 'package:tictactoe/app/ui/components/input.dart';
import 'package:tictactoe/app/ui/components/loader.dart';
import 'package:tictactoe/app/ui/components/panel.dart';

class JoinRoomPage extends StatefulWidget {
  const JoinRoomPage({super.key});

  @override
  State<JoinRoomPage> createState() => _JoinRoomPageState();
}

class _JoinRoomPageState extends State<JoinRoomPage> {
  JoinRoomCubit cubit = JoinRoomCubit();

  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Timer invalidToastTimer = Timer(Duration.zero, () {});

  bool isPopped = false;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void reassemble() {
    super.reassemble();
    if (cubit.controller != null) {
      cubit.controller!.resumeCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldGradientBackground(
      gradient: AppColors.backgrondGradient,
      appBar: CustomAppBar(
        backAction: () => Modular.to.pop(),
      ),
      // appBar:
      body: SafeArea(
        child: Center(
          child: BlocConsumer<JoinRoomCubit, JoinRoomState>(
            bloc: cubit,
            listener: (context, state) {
              if (state is JoinRoomError) {
                Toasting.error(context, message: state.message);
              }
              if (state is JoinRoomExit) {
                Modular.to.pop();
              }
              if (state is JoinRoomJoin) {
                Modular.to.pushNamedAndRemoveUntil(AppRoutes.game, (_) => false, arguments: state.roomId);
              }
            },
            builder: (context, state) {
              if (state is JoinRoomLoading || state is JoinRoomJoin) {
                return const Padding(
                  padding: EdgeInsets.all(20),
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Acessando sala...',
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.white),
                        ),
                        Gap(20),
                        Loader(
                          size: 50,
                        ),
                      ],
                    ),
                  ),
                );
              }
              return Padding(
                padding: const EdgeInsets.all(30),
                child: SingleChildScrollView(
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
                              'Acessar Sala',
                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.white),
                            ),
                            const Text(
                              'Leia o QRCode do seu adversário ou insira o código',
                              style: TextStyle(color: AppColors.grey_200),
                            ),
                            SizedBox(
                              height: 300,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: QRView(
                                  key: qrKey,
                                  cameraFacing: CameraFacing.back,
                                  formatsAllowed: const [BarcodeFormat.qrcode],
                                  onQRViewCreated: cubit.onQRViewCreated,
                                  overlay: QrScannerOverlayShape(
                                    borderColor: AppColors.pink_400,
                                    borderRadius: 10,
                                    borderLength: 30,
                                    borderWidth: 10,
                                    cutOutSize: 200,
                                  ),
                                ),
                              ),
                            ),
                            Input.numeric(
                              cubit.roomController,
                              label: 'Código da sala:',
                            ),
                            Button.secondary(
                              onPressed: () async {
                                var code = int.tryParse(cubit.roomController.text);
                                if (code != null) {
                                  cubit.joinRoom(code);
                                }
                              },
                              child: const Text('Entrar'),
                            ).expandedH(),
                          ],
                        ),
                      ).hero('panel'),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

import 'package:app/feature/location/add-device/add_device_view_model.dart';
import 'package:app/feature/location/add-device/views/index.dart';
import 'package:app/shared/constant/index.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:stacked_services/stacked_services.dart';

class AddDeviceBottomSheet extends StatelessWidget {
  final SheetRequest request;
  final Function(SheetResponse) completer;
  final AddDeviceViewModel _viewModel;

  AddDeviceBottomSheet({
    required this.request,
    required this.completer,
    super.key,
  }) : _viewModel = request.data as AddDeviceViewModel;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => _viewModel,
      child: Container(
        width: double.infinity,
        height: AppStyle.addDeviceBottomSheetHeight,
        padding: EdgeInsets.symmetric(
          horizontal: AppStyle.horizontalPadding16,
        ),
        decoration: BoxDecoration(
          color: AppStyle.secondaryColor1,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(AppStyle.borderRadius18),
          ),
        ),
        child: Consumer<AddDeviceViewModel>(
          builder: (context, viewModel, child) {
            return viewModel.isScanSuccessful
                ? Center(
                    child: Lottie.asset(
                      'assets/animations/success.json',
                      width: AppStyle.successAnimationSize,
                      height: AppStyle.successAnimationSize,
                      repeat: false,
                      onLoaded: (_) => {
                        Future.delayed(const Duration(seconds: 2), () {
                          completer(SheetResponse(confirmed: true, data: viewModel.serialNumber));
                        })
                      },
                    ),
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        AppStrings.scanQRCodeTitle,
                        style: TextStyle(
                          color: AppStyle.textColor,
                          fontSize: AppStyle.fontSize20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(
                        height: AppStyle.qrScannerViewHeight,
                        width: AppStyle.qrScannerViewWidth,
                        child: QrScannerView(onDetect: (value) => viewModel.addDevice(value)),
                      ),
                      Text(
                        viewModel.serialNumberError ?? AppStrings.scanQRCodeDescription,
                        style: TextStyle(
                          color: viewModel.serialNumberError != null
                              ? AppStyle.negativeColor
                              : AppStyle.textColorWith05Opacity,
                          fontSize: AppStyle.fontSize16,
                        ),
                      ),
                    ],
                  );
          },
        ),
      ),
    );
  }
}

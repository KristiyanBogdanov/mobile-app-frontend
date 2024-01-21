import 'package:app/shared/constant/index.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QrScannerView extends StatefulWidget {
  final Function onDetect;

  const QrScannerView({required this.onDetect, super.key});

  @override
  State<QrScannerView> createState() => _QrScannerViewState();
}

class _QrScannerViewState extends State<QrScannerView> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;

  @override
  Widget build(BuildContext context) {
    return QRView(
      key: qrKey,
      onQRViewCreated: (controller) {
        this.controller = controller;
        controller.scannedDataStream.listen((scanData) {
          widget.onDetect(scanData.code);
        });
      },
      overlay: QrScannerOverlayShape(
        borderColor: AppStyle.contrastColor,
        borderRadius: AppStyle.qrScannerViewBorderRadius,
        borderWidth: AppStyle.qrScannerViewBorderWidth,
        borderLength: AppStyle.qrScannerViewBorderLength,
      ),
    );
  }
}

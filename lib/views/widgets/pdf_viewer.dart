import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:leen_alkhier_store/data/responses/business_info_response.dart';
import 'package:leen_alkhier_store/utils/image_manager.dart';
import 'package:leen_alkhier_store/utils/local_const.dart';
import 'package:leen_alkhier_store/views/widgets/custom_functions_views.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

class PDFScreen extends StatefulWidget {
  final String? pdf_path;
  final String? image_path;
  final bool? image;

  PDFScreen({Key? key, this.pdf_path,this.image,this.image_path}) : super(key: key);

  _PDFScreenState createState() => _PDFScreenState();
}

class _PDFScreenState extends State<PDFScreen> with WidgetsBindingObserver {
  final Completer<PDFViewController> _controller =
  Completer<PDFViewController>();
  int? pages = 0;
  int? currentPage = 0;
  bool isReady = false;
  String errorMessage = '';


  @override
  Widget build(BuildContext context) {
    print("pdf_path : ${widget.pdf_path}");
    print("image_path : ${widget.image_path}");
    print("image : ${widget.image}");
    return Scaffold(
      appBar: CustomViews.appBarWidget(
        context: context,
        title:'view_att'.tr,
      ),
      body: widget.image == false ?Stack(
        children: <Widget>[
          PDFView(
            filePath: widget.pdf_path,
            enableSwipe: true,
            swipeHorizontal: true,
            autoSpacing: false,
            pageFling: true,
            pageSnap: true,
            defaultPage: currentPage!,
            fitPolicy: FitPolicy.BOTH,
            preventLinkNavigation:
            false, // if set to true the link is handled in flutter
            onRender: (_pages) {
              setState(() {
                pages = _pages;
                isReady = true;
              });
            },
            onError: (error) {
              setState(() {
                errorMessage = error.toString();
              });
              print(error.toString());
            },
            onPageError: (page, error) {
              setState(() {
                errorMessage = '$page: ${error.toString()}';
              });
              print('$page: ${error.toString()}');
            },
            onViewCreated: (PDFViewController pdfViewController) {
              _controller.complete(pdfViewController);
            },
            onLinkHandler: (String? uri) {
              print('goto uri: $uri');
            },
            onPageChanged: (int? page, int? total) {
              print('page change: $page/$total');
              setState(() {
                currentPage = page;
              });
            },
          ),
          errorMessage.isEmpty
              ? !isReady
              ? Center(
            child: CircularProgressIndicator(),
          )
              : Container()
              : Center(
            child: Text(errorMessage),
          )
        ],
      ) : Center(
        child:  FadeInImage(
          image: NetworkImage( widget.image_path!),
          placeholder: AssetImage(ImageAssets.placeholder),
          imageErrorBuilder:
              (context, error, stackTrace) {
            return Image.asset(
                ImageAssets.placeholder,
                fit: BoxFit.fill);
          },
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
// import 'package:flutter_absolute_path/flutter_absolute_path.dart';
import 'package:leen_alkhier_store/utils/Shared.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'dart:async';

import 'package:multi_image_picker/multi_image_picker.dart';

class PhotoGallery extends StatefulWidget {
  final String? label;
  PhotoGallery({this.label});
  @override
  _PhotoGalleryState createState() => new _PhotoGalleryState();
}

class _PhotoGalleryState extends State<PhotoGallery> {
  List<Asset> resultList = [];
  String _error = 'No Error Dectected';


  @override
  void initState() {
    super.initState();
  }

  Widget buildGridView() {
    double width =MediaQuery.of(context).size.width/5;
    double height =MediaQuery.of(context).size.width/5;

    return GridView.count(
      crossAxisCount: 3,
      children: List.generate(Shared.images_list.length, (index) {
        Asset asset = Shared.images_list[index];
        return Card(
          clipBehavior: Clip.antiAlias,
          child: Stack(
            children: <Widget>[
              AssetThumb(
                asset: asset,
                width: width.toInt(),
                height: height.toInt(),
              ),
              Positioned(
                right: 5,
                top: 5,
                child: InkWell(
                  child: Icon(
                    Icons.remove_circle,
                    size: 20,
                    color: Colors.red,
                  ),
                  onTap: () {
                    setState(() {
                      Shared.images_list.removeAt(index);


                    });
                  },
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  Future<void> loadAssets() async {
    String error = 'No Error Dectected';

    try {
        resultList = await MultiImagePicker.pickImages(
        maxImages: 100,
        enableCamera: true,
        selectedAssets: Shared.images_list,
        cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
        materialOptions: MaterialOptions(
          actionBarColor: "#03989E",
          actionBarTitle: "Leen Alkhair",
          allViewTitle: "All Photos",
          useDetailsView: false,
          selectCircleStrokeColor: "#000000",
        ),
      );
    } on Exception catch (e) {
      error = e.toString();
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      Shared.images_list = resultList;
      _error = error;
    });
  }

  @override
  Widget build(BuildContext context) {
    return  Directionality(
        textDirection:translator.activeLanguageCode== 'ar' ?
                      TextDirection.rtl : TextDirection.ltr,
        child: Container(
            padding: const EdgeInsets.only(right:15,top: 5),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: new BorderRadius.circular(5.0),
            ),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.width/2.5,
            child: Stack(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Card(
                        child: Container(
                          width: MediaQuery.of(context).size.width/5,
                          height: MediaQuery.of(context).size.width/5,
                          child:  RaisedButton(
                            child: Icon(Icons.camera_alt,size: 40,),
                            onPressed: loadAssets,
                          ),
                        )
                    ),

                    Expanded(
                      child:   buildGridView(),
                    )
                  ],
                )
              ],
            ),
          ),

      );

  }
}
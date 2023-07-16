
import 'package:flutter/material.dart';
import 'package:leen_alkhier_store/data/responses/Sales_returns/returned_order_product_data_response.dart';
import 'package:leen_alkhier_store/utils/local_const.dart';
import 'package:localize_and_translate/localize_and_translate.dart';



class UploadedImages extends StatefulWidget {
  List<Media>? media;
  UploadedImages({this.media});
  @override
  _UploadedImagesState createState() => _UploadedImagesState();
}

class _UploadedImagesState extends State<UploadedImages> {

  bool customer_images_status = false;
  bool driver_images_status = false;
  List customer_images  = [];
  List driver_images  = [];
  @override
  void initState() {
    widget.media!.forEach((element) {
      if( element.type =="customer"){
        customer_images.add(element.mediaUrl);
        customer_images_status = true;
      }else{
        driver_images.add(element.mediaUrl);
        driver_images_status = true;
      }
    });
    super.initState();
  }
  Widget buildGridView({String? type}) {
    double width =MediaQuery.of(context).size.width/2;

    return GridView.builder(
        shrinkWrap: true,
        itemCount:type == "customer" ? customer_images.length : driver_images.length ,
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 150,
            childAspectRatio: 5/ 2,mainAxisExtent: 100,
            crossAxisSpacing: 0,
            mainAxisSpacing: 0),
        itemBuilder: (context, index){

          return  Card(
            clipBehavior: Clip.antiAlias,
            child: FadeInImage.assetNetwork(
              image: type == "customer" ? customer_images[index] : driver_images[index],
              fit: BoxFit.fill,
              placeholder: "assets/placeholder.png",
            ),
          ) ;
        });
  }

  @override
  Widget build(BuildContext context) {

    return  Directionality(
      textDirection:translator.activeLanguageCode == 'ar' ?
      TextDirection.rtl : TextDirection.ltr,
      child:  Column(
        children: [
         customer_images_status ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(padding: EdgeInsets.symmetric(vertical: 10),
                child: Text(
                kclientUploaded_images.tr(),
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(right:15,top: 5),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: new BorderRadius.circular(5.0),
                ),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.width/2.5,
                child:     buildGridView(
                  type: "customer"
                ),

              )
            ],
          ) : Container(),
          driver_images_status ?  Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(padding: EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  kdriverUploaded_images.tr(),
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(right:15,top: 5),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: new BorderRadius.circular(5.0),
                ),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.width/2.5,
                child:     buildGridView(
                    type: "driver"
                ),

              )
            ],
          ) : Container(),
        ],
      )

    );
  }
}
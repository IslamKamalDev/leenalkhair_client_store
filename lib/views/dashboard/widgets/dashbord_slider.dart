import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:leen_alkhier_store/data/responses/Dashboard/dashboard_sliders_response.dart';
import 'package:leen_alkhier_store/utils/colors.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

class DashboardSlider extends StatefulWidget {
  List<FirstSlider> first_slider = [];
  DashboardSlider({required this.first_slider});
  @override
  State<StatefulWidget> createState() {
    return _DashboardSlider_State();
  }
}

// extension Unique<E, Id> on List<E> {
//   List<E> unique([Id Function(E element)? id, bool inplace = true]) {
//     final ids = Set();
//     var list = inplace ? this : List<E>.from(this);
//     list.retainWhere((x) => ids.add(id != null ? id(x) : x as Id));
//     return list;
//   }
// }

class _DashboardSlider_State extends State<DashboardSlider> {
  int _current = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  // TODO: implemen
  Widget build(BuildContext context) {
    return _buildWidget(widget.first_slider);
  }

  Widget _buildWidget(List<FirstSlider> images) {
    return Directionality(
      textDirection: translator.activeLanguageCode == 'ar'
          ? TextDirection.rtl
          : TextDirection.ltr,
      child: Column(children: [
        CarouselSlider(
          items: images
              .map((item) => Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  // elevation: 5,

                  child: FadeInImage.assetNetwork(
                    image: "${item.imageUrl}",
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.fill,
                    placeholder: "assets/placeholder.png",
                  )))
              .toList(),
          options: CarouselOptions(
              autoPlay: true,
              enlargeCenterPage: true,
              aspectRatio: 14 / 6,
              viewportFraction: 1,
              onPageChanged: (index, reason) {
                setState(() {
                  _current = index;
                });
              }),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: images.map((url) {
            int index = images.indexOf(url);
            return Container(
              width: 10.0,
              height: 10.0,
              margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 6.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _current == index
                    ? CustomColors.PRIMARY_GREEN
                    : CustomColors.WHITE_COLOR,
              ),
            );
          }).toList(),
        )
      ]),
    );
  }
}

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_geocoder/geocoder.dart';
// import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:leen_alkhier_store/providers/Branch/add_branch_provider.dart';
import 'package:leen_alkhier_store/providers/business_info_provider.dart';
import 'package:leen_alkhier_store/providers/business_register_provider.dart';
import 'package:leen_alkhier_store/utils/colors.dart';
import 'package:leen_alkhier_store/views/widgets/custom_rounded_btn.dart';
import 'package:provider/provider.dart';

class MapDialog extends StatefulWidget {
  bool isUpdateBusiness;
  bool branch;
  LatLng? location;
  String? buttonText;
  MapDialog(
      {this.isUpdateBusiness = false,
      this.location,
      this.buttonText,
      required this.branch});
  @override
  _MapDialogState createState() => _MapDialogState();
}

class _MapDialogState extends State<MapDialog> {
  LatLng? businesLatLng = LatLng(0.0, 0.0);
  List<Marker> markers = [
    Marker(markerId: MarkerId('1'), position: LatLng(0.0, 0.0))
  ];

  @override
  Future<void>? initState() {
    // TODO: implement initState
    super.initState();

    if (widget.location != null) {
      businesLatLng = widget.location;
      markers.clear();
      markers.add(Marker(markerId: MarkerId('1'), position: businesLatLng!));
      setState(() {});
      _controller.future.then((value) {
        value.animateCamera(CameraUpdate.newLatLng(businesLatLng!));
      });
    } else {
      getCurrent();
    }
    return null;
  }

  getCurrent() async {
    await Geolocator.getCurrentPosition().then((value) {
      businesLatLng = LatLng(value.latitude, value.longitude);
      markers.clear();
      markers.add(Marker(markerId: MarkerId('1'), position: businesLatLng!));
      setState(() {});
      _controller.future.then((value) {
        value.animateCamera(CameraUpdate.newLatLng(businesLatLng!));
      });
    });
    //  return position;
  }

  Completer<GoogleMapController> _controller = Completer();

  @override
  Widget build(BuildContext context) {
    var registerBusinessProvider =
        Provider.of<BusinessRegisterationProvider>(context);
    var addBranchProvider = Provider.of<AddBranchProvider>(context);
    var businessInfoProvider = Provider.of<BusinessInfoProvider>(context);
    return Container(
      //  height: 120,
      child: Column(
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: GoogleMap(
                mapType: MapType.normal,
                markers: Set.from(markers),
                onTap: (v) async {
                  businesLatLng = v;
                  businessInfoProvider.changeBusinessLocation(businesLatLng);
                  if (widget.branch) {
                    addBranchProvider.changeBranchLocation(businesLatLng);
                    final coordinates =
                        new Coordinates(v.latitude, v.longitude);
                    var addresses = await Geocoder.local
                        .findAddressesFromCoordinates(coordinates);
                    var address = addresses.first;
                  //  addBranchProvider.branch_address = address.addressLine;
                    addBranchProvider.branch_name_fun(address.addressLine);
                  }
                  markers.clear();
                  markers.add(Marker(
                      markerId: MarkerId('1'), position: businesLatLng!));
                  setState(() {});

                  _controller.future.then((value) {
                    value.animateCamera(CameraUpdate.newLatLng(businesLatLng!));
                  });
                },
                initialCameraPosition:
                    CameraPosition(target: businesLatLng!, zoom: 13),
                onMapCreated: (GoogleMapController controller) {
                  if (!_controller.isCompleted)
                    _controller.complete(controller);
                },
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          CustomRoundedButton(
            fontSize: 15,
            backgroundColor: CustomColors.PRIMARY_GREEN,
            borderColor: CustomColors.PRIMARY_GREEN,
            text: (widget.buttonText ?? 'confirm'),
            textColor: Colors.white,
            pressed: (widget.isUpdateBusiness)
                ? () {
                    Navigator.pop(context);
                  }
                : (businesLatLng == null)
                    ? null
                    : () {
                        if (widget.isUpdateBusiness)
                          businessInfoProvider
                              .changeBusinessLocation(businesLatLng);
                        else {
                          if (widget.branch) {
                            addBranchProvider
                                .changeBranchLocation(businesLatLng);
                          } else {
                            registerBusinessProvider
                                .changeBusinessLocation(businesLatLng);
                          }
                        }

                        widget.location = null;
                        Navigator.pop(context);
                      },
          )
        ],
      ),
    );
  }
}

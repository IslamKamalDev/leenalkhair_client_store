import 'package:flutter/cupertino.dart';
import 'package:leen_alkhier_store/data/responses/Sectors/sector_response.dart';
import 'package:leen_alkhier_store/repos/custom_repository.dart';

class SectorProvider extends ChangeNotifier{
  late SectorResponse sectorResponse;
  Sector? selectedSector;


  SectorProvider() {
    CustomRepository.getAllSectors().then((value) {
      {
        sectorResponse = value;
        notifyListeners();
      }
    });
  }

  void changeSector(Sector? sector) {
    selectedSector = sector;
    notifyListeners();
  }

  Future<void> resetSector() async {
    await CustomRepository.getAllSectors().then((value) {
      {

      sectorResponse = value;
        notifyListeners();
      }
    });
  }
}

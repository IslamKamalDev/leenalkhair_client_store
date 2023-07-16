import 'package:flutter/material.dart';
import 'package:leen_alkhier_store/data/responses/suggest_response.dart';
import 'package:leen_alkhier_store/repos/more_repos.dart';

class NoteProvider extends ChangeNotifier {
  SuggestResponse? suggestResponse;

  Future<void> setNote({String? note}) async {
    await MoreRepository.sendNotes(note: note).then((value) {
      suggestResponse = value;
      notifyListeners();
    });
  }
}

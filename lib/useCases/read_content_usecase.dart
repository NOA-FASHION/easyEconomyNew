import 'package:flutter_document_picker/flutter_document_picker.dart';
import 'dart:io';

import 'package:injectable/injectable.dart';

@injectable
class ReadContentUseCase {
  Future<String> execute() async {
    String contents = "";
    try {
      final path = await FlutterDocumentPicker.openDocument();
      if (path != null) {
        final file = File(path);
        contents = await file.readAsString();
      }
      return contents;
    } catch (e) {
      return 'Error!';
    }
  }
}

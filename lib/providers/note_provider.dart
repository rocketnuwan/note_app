import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:note_app/controllers/sql_helper.dart';
import 'package:note_app/models/note_model.dart';

class NoteProvider extends ChangeNotifier {
  //  add new note
  final TextEditingController _title = TextEditingController();
  final TextEditingController _desc = TextEditingController();

  TextEditingController get titleController => _title;
  TextEditingController get descController => _desc;

//create new note
  Future<void> addNewNote(BuildContext context) async {
    if (_title.text.isEmpty || _desc.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Fill All the feild"),
        ),
      );
    }
    await SqlHelper.createNote(_title.text, _desc.text);
    await refershNotes();
    _title.clear();
    _desc.clear();

    notifyListeners();
  }

  //fetch all notes
  List<NoteModel> _allNodes = [];

  List<NoteModel> get allNodes => _allNodes;

//getNotes
  Future<void> refershNotes() async {
    _allNodes = await SqlHelper.getNotes();
    notifyListeners();
  }
}

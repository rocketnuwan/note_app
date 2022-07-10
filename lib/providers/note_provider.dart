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

  //set text controllers
  void setTextControllers(NoteModel noteModel) {
    titleController.text = noteModel.title;
    descController.text = noteModel.title;

    notifyListeners();
  }

//update nots
  Future<void> updateNote(int id, BuildContext context) async {
    await SqlHelper.updateNote(id, _title.text, _desc.text);

    _title.clear();
    _desc.clear();
    await refershNotes();
    notifyListeners();
  }

  Future<void> deleteNote(int id, BuildContext context) async {
    await SqlHelper.deleteNote(
      id,
    );

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("You deleted a Note"),
      ),
    );

    await refershNotes();
    notifyListeners();
  }
}

import 'package:flutter/material.dart';
import 'package:note_app/models/note_model.dart';
import 'package:note_app/providers/note_provider.dart';
import 'package:provider/provider.dart';

class Utils {
  static void showForm(BuildContext context, NoteModel? model) {
//set exixting note details for text controllers
    if (model != null) {
      Provider.of<NoteProvider>(context, listen: false)
          .setTextControllers(model);
    }

    showModalBottomSheet(
        context: context,
        builder: (_) {
          return Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              child: Consumer<NoteProvider>(
                builder: (context, value, child) {
                  return Column(
                    children: [
                      TextField(
                        controller: value.titleController,
                        decoration: const InputDecoration(hintText: "Title"),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextField(
                        controller: value.descController,
                        decoration:
                            const InputDecoration(hintText: "Description"),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      ElevatedButton(
                          onPressed: () {
                            if (model == null) {
                              value.addNewNote(context);
                            } else {
                              value.updateNote(model.id!, context);
                            }

                            Navigator.of(context).pop();
                          },
                          child: Text(
                            model != null ? "Update Note" : "Save Note",
                          )),
                    ],
                  );
                },
              ));
        });
  }
}

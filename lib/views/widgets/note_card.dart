import 'package:flutter/material.dart';
import 'package:note_app/models/note_model.dart';
import 'package:note_app/providers/note_provider.dart';
import 'package:note_app/utils/dialogs.dart';
import 'package:note_app/views/note_view.dart';
import 'package:provider/provider.dart';

class NoteCard extends StatelessWidget {
  const NoteCard({
    Key? key,
    // required this.title,
    // required this.desc,
    required this.model,
  }) : super(key: key);

  // final String title;
  // final String desc;
  final NoteModel model;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.orangeAccent[100],
      child: ListTile(
        title: Text(model.title),
        subtitle: Text(model.description),
        trailing: SizedBox(
          width: 100,
          child: Row(
            children: [
              IconButton(
                  onPressed: () {
                    Utils.showForm(context, model);
                  },
                  icon: const Icon(
                    Icons.edit,
                  )),
              IconButton(
                  onPressed: () {
                    Provider.of<NoteProvider>(context, listen: false)
                        .deleteNote(model.id!, context);
                  },
                  icon: const Icon(
                    Icons.delete,
                  )),
            ],
          ),
        ),
      ),
    );
  }
}

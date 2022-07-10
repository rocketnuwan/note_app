import 'package:flutter/material.dart';
import 'package:note_app/providers/note_provider.dart';
import 'package:note_app/utils/dialogs.dart';
import 'package:note_app/views/widgets/note_card.dart';
import 'package:provider/provider.dart';

class NoteView extends StatefulWidget {
  const NoteView({Key? key}) : super(key: key);

  @override
  State<NoteView> createState() => _NoteViewState();
}

class _NoteViewState extends State<NoteView> {
  @override
  void initState() {
    Provider.of<NoteProvider>(context, listen: false).refershNotes();

    super.initState();
  }

  //bottom sheet function

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Pro Note App"),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Utils.showForm(context, null);
          },
          label: const Text("create note"),
          icon: const Icon(Icons.add),
        ),
        body: Consumer<NoteProvider>(
          builder: (context, value, child) {
            return value.allNodes.isEmpty
                ? const Center(
                    child: Text(
                    "No any notes",
                    style: TextStyle(color: Colors.red, fontSize: 20),
                  ))
                : ListView.separated(
                    padding: const EdgeInsets.all(15),
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return NoteCard(
                        // title: value.allNodes[index].title,
                        // desc: value.allNodes[index].description,
                        model: value.allNodes[index],
                      );
                    },
                    separatorBuilder: (context, index) => const SizedBox(
                          height: 5,
                        ),
                    itemCount: value.allNodes.length);
          },
        ));
  }
}

import 'package:flutter/material.dart';
import 'package:note_app/providers/note_provider.dart';
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
  void showForm() {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return Container(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              child: Consumer<NoteProvider>(
                builder: (context, value, child) {
                  return Column(
                    children: [
                      TextField(
                        controller: value.titleController,
                        decoration: InputDecoration(hintText: "Title"),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextField(
                        controller: value.descController,
                        decoration: InputDecoration(hintText: "Description"),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      ElevatedButton(
                          onPressed: () {
                            value.addNewNote(context);
                            Navigator.of(context).pop();
                          },
                          child: Text("Save Note")),
                    ],
                  );
                },
              ));
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Pro Note App"),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            showForm();
          },
          label: Text("create note"),
          icon: Icon(Icons.add),
        ),
        body: Consumer<NoteProvider>(
          builder: (context, value, child) {
            return value.allNodes.isEmpty
                ? Text("no notes")
                : ListView.separated(
                    padding: EdgeInsets.all(15),
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return NoteCard(
                        title: value.allNodes[index].title,
                        desc: value.allNodes[index].description,
                      );
                    },
                    separatorBuilder: (context, index) => SizedBox(
                          height: 5,
                        ),
                    itemCount: value.allNodes.length);
          },
        ));
  }
}

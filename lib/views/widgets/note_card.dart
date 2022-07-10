import 'package:flutter/material.dart';

class NoteCard extends StatelessWidget {
  const NoteCard({
    Key? key,
    required this.title,
    required this.desc,
  }) : super(key: key);

  final String title;
  final String desc;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.orangeAccent[100],
      child: ListTile(
        title: Text(title),
        subtitle: Text(desc),
        trailing: SizedBox(
          width: 100,
          child: Row(
            children: [
              IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.edit,
                  )),
              IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.delete,
                  )),
            ],
          ),
        ),
      ),
    );
  }
}

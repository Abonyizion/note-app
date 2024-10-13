import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:popover/popover.dart';
import 'package:provider/provider.dart';
import '../components/note_settings.dart';
import '../models/note.dart';
import '../models/note_database.dart';


class NotesPage extends StatefulWidget {
  final Note note;
  const NotesPage({super.key, required this.note});

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {

  final textController = TextEditingController();

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

// update note
  void updateNote(Note note) {
    // pre-fill the current note text
    textController.text = note.text;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Update note"),
        content: TextField(
          decoration: const InputDecoration(
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: Colors.green
              ),
            ),
          ),
          controller: textController,
        ),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Cancel", style: TextStyle(
                  color: Theme.of(context).colorScheme.inversePrimary),
              )),
          TextButton(
              onPressed: () {
                context.read<NoteDatabase>().updateNote(note.id, textController.text);
                Navigator.pop(context);
              },
              child: Text("Update", style: TextStyle(
                  color: Theme.of(context).colorScheme.inversePrimary),
              ))
        ],
      ),
    );
  }

  //delete note
  void deleteNote(int id) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        // title: const Text("Update note"),
        content: const Text("Are you sure you want to delete this note?"),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Cancel", style: TextStyle(
                  color: Theme.of(context).colorScheme.inversePrimary),
              )),
          TextButton(
              onPressed: () {
                context.read<NoteDatabase>().deleteNote(id);
                Navigator.pop(context);
                Navigator.pop(context);
              },
              child: Text("Delete", style: TextStyle(
                  color: Theme.of(context).colorScheme.inversePrimary),
              ))
        ],
      ),
    );
  }

  //read note
  void readNotes() {
    context.read<NoteDatabase>().fetchedNotes();
  }
/*
  @override
  void initState() {
    super.initState();
    readNotes();
  } */



  @override
  Widget build(BuildContext context) {
    //final noteDatabase = context.watch<NoteDatabase>();
    // current notes
   // List<Note> currentNotes = noteDatabase.currentNotes;

   // final note = currentNotes;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        elevation: 5,
        backgroundColor: Colors.transparent,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("notes", style: TextStyle(
            fontWeight: FontWeight.bold, fontSize: 25),
        ),
        actions: [
          Builder(
            builder: (context) =>  IconButton(
              onPressed: () => showPopover(
                width: 100,
                height: 100,
                context: context,
                bodyBuilder: (context) => NoteSettings(
                    onEdit: () {
                        updateNote(widget.note);
                    },
                    onDelete: () {
                      deleteNote(widget.note.id);
                     // Navigator.pop(context);
                    }
                ),
              ),
              icon: const Icon(Icons.more_vert),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 18),
              child: GestureDetector(
                 onLongPress: () async {
                    await Clipboard.setData(ClipboardData(
                        text: widget.note.text)
                     );
                  },
                child: Text(widget.note.text,
                  style: const TextStyle(fontSize: 20),),
              ),
            )
          ],
          ),
      ),
    );
  }
}

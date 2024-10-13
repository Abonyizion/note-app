
import 'package:data/models/note_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../components/drawer.dart';
import '../models/note.dart';
import 'notesPage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final textController = TextEditingController();

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    readNotes();
  }
  // create note
  void createNote() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: TextFormField(
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
                  context.read<NoteDatabase>().addNote(textController.text);
                  textController.clear();
                  Navigator.pop(context);
                },
                child: Text("Create", style: TextStyle(
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

  //delete note
  void deleteNote(int id) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
       // backgroundColor: Theme.of(context).colorScheme.onPrimary,
        title: const Text("Delete Note?"),
       // content: const Text("Are you sure you want to delete this note?"),
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
              },
              child: Text("Delete", style: TextStyle(
                  color: Theme.of(context).colorScheme.inversePrimary),
              ),
          ),
        ],
      ),
    );
  }
  
  @override
  Widget build(BuildContext context) {
    final noteDatabase = context.watch<NoteDatabase>();
    // current notes
    List<Note> currentNotes = noteDatabase.currentNotes;
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        elevation: 5,
        backgroundColor: Colors.transparent,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: createNote,
              child: Icon(Icons.add,
                color: Theme.of(context).colorScheme.inversePrimary,),

      ),
      drawer: const MyDrawer(),
      body:  Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
            Padding(
             padding: const EdgeInsets.only(left: 14.0),
             child: Text("My Notes",
               style: GoogleFonts.dmSerifText(fontSize: 43),
             ),
           ),
          Expanded(
            child: ListView.builder(
              itemCount: currentNotes.length,
                itemBuilder: (context, index) {
                  //get individual notes
                  final note = currentNotes[index];

                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 12),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      child: ListTile(
                        trailing: const Icon(Icons.navigate_next),
                        title: InkWell(
                          onLongPress: () => deleteNote(note.id),
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(
                                builder: (context) => NotesPage(note: currentNotes[index],)));
                          },
                            child: Text(note.text, maxLines: 1, overflow: TextOverflow.ellipsis)
                        ),
                      ),
                    ),
                  );
                }
                ),
          ),
        ],
      )
    );
  }
}

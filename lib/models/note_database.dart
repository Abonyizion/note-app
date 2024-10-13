import 'package:data/models/note.dart';
import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

class NoteDatabase extends ChangeNotifier {
  static late Isar isar;


//INITIALIZE DIRECTORY
  static Future<void> initialize() async {
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open(
        [NoteSchema],
        directory: dir.path
    );
  }
  //list of note
 final List<Note> currentNotes = [];

  // create a note and save to database
Future<void> addNote(String textFromUser) async {
  //create a new note object
  final newNote = Note()..text = textFromUser;

  // save tp db
  await isar.writeTxn( () => isar.notes.put(newNote));

  // re-read from db
  fetchedNotes();
}

// read notes  from db
 Future<void> fetchedNotes() async {
  List<Note> fetchedNotes = await isar.notes.where().findAll();
  currentNotes.clear();
  currentNotes.addAll(fetchedNotes);
  notifyListeners();
 }

 // update a note
Future<void> updateNote(int id, String newText) async {
  final existingNote = await isar.notes.get(id);
  if (existingNote != null) {
    existingNote.text = newText;
    await isar.writeTxn(() => isar.notes.put(existingNote));
    await fetchedNotes();
  }
}

// delete note from database
Future<void> deleteNote(int id) async {
  await isar.writeTxn(() => isar.notes.delete(id));
  await fetchedNotes();

}

}
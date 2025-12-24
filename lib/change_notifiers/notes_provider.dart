import 'package:flutter/material.dart';
import 'package:notes_app/core/extensions.dart';
import 'package:notes_app/enums/order_options.dart';
import 'package:notes_app/models/notes.dart';




class NotesProvider extends ChangeNotifier {
  final List<Note> _notes = [];

  List<Note> get notes => [..._searchTerm.isEmpty ? _notes : _notes.where(_test)]..sort(_compare);

  bool _test(Note note){
    final term = _searchTerm.toLowerCase().trim();
    final title = note.title?.toLowerCase() ?? '';
    final content = note.content?.toLowerCase() ?? '';
    final tags = note.tags?.map((e)=>e.toLowerCase()).toList() ?? [];
    return title.contains(term) || content.contains(term) || tags.deepContains(term);

  }

  int _compare(Note note1, Note note2) {
    return _orderBy == OrderOption.dateModified
        ? isDescending
              ? note2.dateModified.compareTo(note1.dateModified)
              : note1.dateModified.compareTo(note2.dateModified)
        : isDescending
        ? note2.dateCreated.compareTo(note1.dateCreated)
        : note1.dateCreated.compareTo(note2.dateCreated);
  }

  void addNote(Note note) {
    _notes.add(note);
    notifyListeners();
  }

  void deleteNote(Note note) {
    _notes.remove(note);
    notifyListeners();
  }

  OrderOption _orderBy = OrderOption.dateModified;
  set orderBy(OrderOption value) {
    _orderBy = value;
    notifyListeners();
  }

  OrderOption get orderBy => _orderBy;

  final bool _isDescending = true;
  set isDescending(bool value) {
    isDescending = value;
    notifyListeners();
  }

  bool get isDescending => _isDescending;

  bool _isGrid = true;
  set isGrid(bool value) {
    _isGrid = value;
    notifyListeners();
  }

  bool get isGrid => _isGrid;

  String _searchTerm = '';
  set searchTerm(String value) {
    _searchTerm = value.toLowerCase();
    notifyListeners();
  }
  String get searchTerm => _searchTerm;
}

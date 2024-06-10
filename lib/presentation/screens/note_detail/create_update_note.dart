import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:logger/logger.dart';
import 'package:my_notes/data/database/notes_db.dart';
import 'package:my_notes/presentation/constants.dart';
import 'package:my_notes/presentation/screens/note_detail/widgets/choose_color_button.dart';
import 'package:my_notes/providers.dart';
import 'package:uuid/uuid.dart';

class CreateUpdateNote extends ConsumerStatefulWidget {
  final String noteId;
  const CreateUpdateNote(this.noteId, {super.key});

  @override
  ConsumerState<CreateUpdateNote> createState() => _CreateUpdateNoteState();
}

class _CreateUpdateNoteState extends ConsumerState<CreateUpdateNote> {
  TextEditingController _titleTextController = TextEditingController();
  TextEditingController _descTextController = TextEditingController();
  ColorSelection selectedColor = ColorSelection.black;
  Color? bgColor;
  Future? addNoteFuture;
  Future? updateNoteFuture;
  NoteData? note;

  @override
  void initState() {
    super.initState();
    if (widget.noteId != 'new') {
      fetchNoteById(widget.noteId);
    } else {
      Logger().d("Create new note!");
    }
  }

  void fetchNoteById(String id) async {
    final fetchedNote = await ref.read(notesRepositoryProvider).getNoteById(id);
    setState(() {
      note = fetchedNote;
      _titleTextController.text = note?.title ?? '';
      _descTextController.text = note?.description ?? '';
      if (note != null && note!.color != null) {
        bgColor = Color(note!.color!);
      }
    });
  }

  void changeColor(int color) {
    setState(() {
      selectedColor = ColorSelection.values[color];
      bgColor = null;
    });
  }

  @override
  void dispose() {
    _titleTextController.dispose();
    _descTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor ?? selectedColor.color,
      appBar: AppBar(
        backgroundColor: bgColor ?? selectedColor.color,
        title: Text(widget.noteId != 'new' ? "Update Note" : "Add Note",
            style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 21,
                color: Colors.white)),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: _descTextController.text.isEmpty ||
                    _descTextController.text.length < 3 ||
                    (_titleTextController.text.isNotEmpty &&
                        _titleTextController.text.length < 3)
                ? null
                : () {
                    if (widget.noteId == 'new') {
                      saveNote(
                        _descTextController.text,
                        _titleTextController.text.isEmpty
                            ? null
                            : _titleTextController.text,
                      );
                    } else {
                      updateNote(
                        _descTextController.text,
                        _titleTextController.text.isEmpty
                            ? null
                            : _titleTextController.text,
                        note!,
                      );
                    }
                    GoRouter.of(context).pop();
                  },
            icon: const Icon(
              Icons.done,
              color: Colors.white,
              size: 35,
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _infoTextFieldWidget(context, "Title", _titleTextController, 1, 30),
            _infoTextFieldWidget(
                context, "Description", _descTextController, 1, 100),
            ChooseNoteColorButton(
                changeColor: changeColor, colorSelected: selectedColor),
            const Expanded(child: SizedBox()),
            Align(
              child: FutureBuilder(
                future: addNoteFuture,
                builder: (context, state) {
                  if (state.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator(
                      color: Colors.white,
                    );
                  }
                  if (state.hasError) {
                    return Text(
                      state.error.toString(),
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.white),
                    );
                  }
                  return const SizedBox();
                },
              ),
            ),
            const SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }

  ///CUSTOM WIDGETS
  Widget _infoTextFieldWidget(BuildContext context, String titleLabel,
      TextEditingController textController, int maxLines, int maxLength) {
    return TextField(
      controller: textController,
      maxLines: null,
      minLines: 1,
      maxLength: maxLength,
      onChanged: (value) {
        setState(() {
          textController.text = value;
        });
      },
      style: const TextStyle(color: Colors.white70),
      decoration: InputDecoration(
        labelText: titleLabel,
        hintStyle: const TextStyle(color: Colors.white70),
        labelStyle: const TextStyle(color: Colors.white70),
      ),
    );
  }

  ///CUSTOM FUNCTIONS
  void saveNote(String description, String? title) async {
    NoteData note = NoteData(
        id: const Uuid().v1(),
        title: title,
        description: description,
        starred: false,
        createdAt: DateTime.now(),
        color: selectedColor.color.value);
    await ref.watch(notesRepositoryProvider).addNote(note);
  }

  void updateNote(String description, String? title, NoteData oldNote) async {
    NoteData note = NoteData(
        id: oldNote.id,
        title: title,
        description: description,
        starred: oldNote.starred,
        createdAt: oldNote.createdAt,
        color: bgColor != null ? bgColor!.value : selectedColor.color.value);
    await ref.watch(notesRepositoryProvider).updateNote(note);
  }
}

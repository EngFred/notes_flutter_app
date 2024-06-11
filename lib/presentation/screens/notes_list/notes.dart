import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:my_notes/common/error_indicator.dart';
import 'package:my_notes/common/loading_indicator.dart';
import 'package:my_notes/data/database/notes_db.dart';
import 'package:my_notes/presentation/screens/notes_list/widgets/note_card.dart';
import 'package:my_notes/providers.dart';

class Notes extends ConsumerStatefulWidget {
  const Notes({super.key});

  @override
  ConsumerState<Notes> createState() => _NotesState();
}

class _NotesState extends ConsumerState<Notes> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    bool isSmallestWidth = screenWidth >= 320 && screenWidth < 371;
    bool isNormalWidth = screenWidth >= 371 && screenWidth < 431;
    bool isBigWidth = screenWidth >= 431 && screenWidth < 502;
    bool isTabletWidth = screenWidth >= 502 && screenWidth < 640;
    return SafeArea(
      child: Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: createNote,
            child: const Icon(Icons.add),
          ),
          body: StreamBuilder<List<NoteData>>(
              stream: ref.watch(notesRepositoryProvider).loadNotes(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const LoadingIndicator();
                }

                if (snapshot.hasError) {
                  return ErrorIndicator(error: "${snapshot.error}");
                }

                final notesData = snapshot.data!;

                if (notesData.isEmpty) {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        "No notes added yet!",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                    ),
                  );
                } else {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: GridView.builder(
                        shrinkWrap: true,
                        itemCount: notesData.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: isSmallestWidth
                                ? 0.827
                                : isNormalWidth
                                    ? 0.756
                                    : isBigWidth
                                        ? 0.91
                                        : isTabletWidth
                                            ? 1
                                            : 1.2),
                        itemBuilder: (context, index) {
                          NoteData note = notesData[index];
                          return NoteCard(
                            note: note,
                            onNoteClicked: (noteId) {
                              navigateToUpdateNoteScreen(noteId);
                            },
                            onNoteStarred: (note) {
                              updateNote(note.copyWith(starred: !note.starred));
                            },
                          );
                        }),
                  );
                }
              })),
    );
  }

  void updateNote(NoteData note) async {
    await ref.watch(notesRepositoryProvider).updateNote(note);
  }

  void navigateToUpdateNoteScreen(String noteId) {
    GoRouter.of(context).push("/note/$noteId");
  }

  void createNote() {
    GoRouter.of(context).push("/note/new");
  }
}

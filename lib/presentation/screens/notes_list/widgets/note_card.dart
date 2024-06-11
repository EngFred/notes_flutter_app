import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_notes/data/database/notes_db.dart';
import 'package:my_notes/utils/utils.dart';

class NoteCard extends StatelessWidget {
  final NoteData note;
  final Function(NoteData note) onNoteStarred;
  final Function(String noteId) onNoteClicked;
  const NoteCard(
      {super.key,
      required this.note,
      required this.onNoteStarred,
      required this.onNoteClicked});

  @override
  Widget build(BuildContext context) {
    bool hasTitle = note.title != null;
    double screenWidth = MediaQuery.of(context).size.width;
    bool isSmallestWidth = screenWidth >= 320 && screenWidth < 371;
    return GestureDetector(
      onTap: () => onNoteClicked(note.id),
      child: Card(
        color: note.color != null ? Color(note.color!) : Colors.black54,
        child: Padding(
          padding: EdgeInsets.all(isSmallestWidth ? 4 : 8),
          child: hasTitle
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      capitalizeFirstLetter(note.title!),
                      maxLines: isSmallestWidth ? 1 : 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 18),
                    ),
                    Text(
                      capitalizeFirstLetter(note.description),
                      style:
                          const TextStyle(color: Colors.white60, fontSize: 15),
                      maxLines: isSmallestWidth ? 3 : 4,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          DateFormat.yMd().format(note.createdAt),
                          style: const TextStyle(
                              color: Colors.white60, fontSize: 13),
                        ),
                        IconButton(
                            onPressed: () {
                              onNoteStarred(note);
                            },
                            icon: Icon(
                              note.starred ? Icons.star : Icons.star_outline,
                              color: Colors.yellowAccent,
                            ))
                      ],
                    )
                  ],
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      capitalizeFirstLetter(note.description),
                      style: const TextStyle(color: Colors.white60),
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          DateFormat.yMd().format(note.createdAt),
                          style: const TextStyle(color: Colors.grey),
                        ),
                        IconButton(
                            onPressed: () {
                              onNoteStarred(note);
                            },
                            icon: Icon(
                                note.starred ? Icons.star : Icons.star_outline,
                                color: Colors.yellowAccent))
                      ],
                    )
                  ],
                ),
        ),
      ),
    );
  }
}

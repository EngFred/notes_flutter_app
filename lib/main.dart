import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:my_notes/presentation/screens/note_detail/create_update_note.dart';
import 'package:my_notes/presentation/screens/notes_list/notes.dart';

void main() {
  runApp(const ProviderScope(child: NotesApp()));
}

class NotesApp extends StatefulWidget {
  const NotesApp({super.key});

  @override
  State<NotesApp> createState() => _NotesAppState();
}

class _NotesAppState extends State<NotesApp> {
  late final _appRouter = GoRouter(
    initialLocation: "/",
    routes: [notesRoute(), createUpdateRoute()],
    errorPageBuilder: (context, state) {
      return MaterialPage(
          key: state.pageKey,
          child: Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(10),
              child: Center(
                child: Text(
                  "${state.error}",
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ));
    },
  );

  RouteBase notesRoute() {
    return GoRoute(
        path: "/",
        builder: (context, state) {
          return const Notes();
        });
  }

  RouteBase createUpdateRoute() {
    return GoRoute(
        path: "/note/:id",
        builder: (context, state) {
          final id = state.pathParameters['id'];
          return CreateUpdateNote(id!);
        });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'My notes',
      routerConfig: _appRouter,
      theme: ThemeData.dark(),
    );
  }
}

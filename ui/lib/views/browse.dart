import 'package:flutter/material.dart';
import 'package:quizrd/models/state.dart';
import 'package:quizrd/models/quiz.dart';
import 'package:provider/provider.dart';
import 'package:quizrd/views/create.dart';
import 'package:quizrd/views/host.dart';

class BrowsePage extends StatefulWidget {
  @override
  State<BrowsePage> createState() => _BrowsePageState();
}

class _BrowsePageState extends State<BrowsePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var appState = context.watch<MyAppState>();
    if (appState.hostQuizId != '') {
      return HostPage(quizId: appState.hostQuizId);
    } else if (appState.editQuizId != '') {
      return CreatePage(quizId: appState.editQuizId);
    } else if (appState.cloneQuizId != '') {
      return CreatePage(quizId: appState.cloneQuizId);
    }
    return Scaffold(
      body: Center(
        child: FutureBuilder<List<Quiz>>(
          future: appState.futureFetchQuizzes,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (appState.quizzes.isEmpty) {
                return Text('No quizzes yet.');
              }

              return Padding(
                padding: const EdgeInsets.all(25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      // Make better use of wide windows with a grid.
                      child: GridView(
                        //padding: const EdgeInsets.all(0),
                        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 400,
                          childAspectRatio: 400 / 400,
                          mainAxisSpacing: 15,
                          crossAxisSpacing: 15,
                        ),
                        children: [
                          for (var quiz in appState.quizzes)
                            Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16)),
                              color: theme.colorScheme.primaryContainer,
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Column(
                                  children: [
                                    Text(quiz.name,
                                        style: TextStyle(
                                            fontSize: 22,
                                            fontWeight: FontWeight.bold)),
                                    Ink.image(
                                      image: NetworkImage(
                                        quiz.imageUrl as String,
                                      ),
                                      height: 220,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        TextButton(
                                            child: Icon(Icons.play_circle,
                                                semanticLabel: 'Start'),
                                            onPressed: () {
                                              return setState(() {
                                                appState.getQuiz(quiz.id);
                                                appState.hostQuizId = quiz.id!;
                                              });
                                            }),
                                        TextButton(
                                            child: Icon(Icons.edit,
                                                semanticLabel: 'Edit'),
                                            onPressed: () {
                                              return setState(() {
                                                appState.getQuiz(quiz.id);
                                                appState.editQuizId = quiz.id!;
                                              });
                                            }),
                                        TextButton(
                                            child: Icon(Icons.content_copy,
                                                semanticLabel: 'Clone'),
                                            onPressed: () {
                                              return setState(() {
                                                appState.getQuiz(quiz.id);
                                                appState.cloneQuizId = quiz.id!;
                                              });
                                            }),
                                        TextButton(
                                            child: Icon(Icons.delete,
                                                semanticLabel: 'Delete'),
                                            onPressed: () {
                                              appState.deleteQuiz(quiz.id);
                                            }),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }

            // By default, show a loading spinner.
            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}

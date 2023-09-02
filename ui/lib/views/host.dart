import 'package:flutter/material.dart';
import 'package:quizrd/models/state.dart';
import 'package:provider/provider.dart';

enum Synchronous { synchronous, asynchronous }

enum Anonymous { anonymous, authenticated }

enum ActivityType { quiz, survey }

enum YN { yes, no }

class HostPage extends StatefulWidget {
  final String quizId;

  @override
  State<HostPage> createState() => _HostPageState();

  HostPage({required this.quizId});
}

final _formKey = GlobalKey<FormState>();

const padding = 6.0;
const columnWidth = 325.0;
const rowHeight = 52.0;

String? strValidator(String? value) {
  if (value == null || value.isEmpty) {
    return 'Missing value';
  }
  return null;
}

String? intValidator(String? value) {
  if (value == null || value.isEmpty) {
    return 'Missing value';
  }
  if (int.tryParse(value) == null) {
    return 'Must be an integer';
  }
  if (int.parse(value) <= 0) {
    return 'Must be an integer greater than zero';
  }
  return null;
}

class _HostPageState extends State<HostPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var appState = context.watch<MyAppState>();
    // Build a Form widget using the _formKey created

    Text genText(String text, {size = 14, weight = FontWeight.normal}) {
      return Text(text,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: size, fontWeight: weight, color: theme.primaryColor));
    }

    TextFormField genTextFormField(label, validator, getter, setter) {
      return TextFormField(
        //style: TextStyle(color: theme.primaryColor),

        initialValue: getter(),
        onChanged: setter,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: label,
        ),
        validator: validator,
      );
    }

    DropdownMenu<String> genDropdownMenu(key, text, current, getter, setter) {
      var initialSelection = current; //getter()[0];
      //if (text == "Quiz Generator") {
      //initialSelection = null;
      //}
      return DropdownMenu<String>(
          textStyle: TextStyle(color: theme.primaryColor),
          key: ValueKey(key),
          controller: TextEditingController(),
          initialSelection: initialSelection,
          onSelected: setter,
          width: columnWidth,
          label: genText(text),
          dropdownMenuEntries: [
            for (var type in getter())
              DropdownMenuEntry(
                label: type,
                value: type,
              ),
          ]);
    }

    void setHostSynch(value) {
      return setState(() {
        appState.hostSynch = value.toString();
      });
    }

    String getHostTimeLimit() {
      return appState.hostTimeLimit;
    }

    void setHostTimeLimit(value) {
      return setState(() {
        appState.hostTimeLimit = value.toString();
      });
    }

    void setHostType(value) {
      return setState(() {
        appState.hostType = value.toString();
      });
    }

    void setHostAnonymous(value) {
      return setState(() {
        appState.hostAnonymous = value.toString();
      });
    }

    void setHostRandomizeQuestions(value) {
      return setState(() {
        appState.hostRandomizeQuestions = value.toString();
      });
    }

    void setHostRandomizeAnswers(value) {
      return setState(() {
        appState.hostRandomizeAnswers = value.toString();
      });
    }

    return FutureBuilder(
        future: appState.futureFetchGenerators,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!.isEmpty) {
              return genText('No generators found.');
            }
            String title = '';
            String snack = '';

            title = 'Host Quiz "${appState.selectedQuizName}"';
            return Hero(
              tag: 'HostPage',
              child: ColorFiltered(
                colorFilter:
                    ColorFilter.mode(Colors.grey, BlendMode.saturation),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                    image: NetworkImage(
                        'https://images.unsplash.com/photo-1498038432885-c6f3f1b912ee?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2340&q=80'),
                    fit: BoxFit.cover,
                  )),
                  child: Center(
                    child: Form(
                        key: _formKey,
                        child: SizedBox(
                          width: 700,
                          child: ListView(children: [
                            // Page title
                            Padding(
                              padding: const EdgeInsets.all(padding * 3),
                              child: genText(title,
                                  size: 30, weight: FontWeight.bold),
                            ),

                            // Synch or Asynch and Time Limit
                            Row(
                              children: [
                                // Sync/Async
                                Padding(
                                  padding: const EdgeInsets.all(padding),
                                  child: SizedBox(
                                    width: columnWidth,
                                    height: rowHeight,
                                    child: genDropdownMenu(
                                        _formKey,
                                        'Synch or Asynch',
                                        appState.hostSynch,
                                        () => ['Synchronous', 'Asynchronous'],
                                        setHostSynch),
                                  ),
                                ),

                                // horizontal spacing
                                SizedBox(width: 16),

                                // Quiz Generator
                                Padding(
                                  padding: const EdgeInsets.all(padding),
                                  child: SizedBox(
                                    width: columnWidth,
                                    height: rowHeight,
                                    child: genTextFormField(
                                        'Per Question Time Limit (seconds)',
                                        intValidator,
                                        getHostTimeLimit,
                                        setHostTimeLimit),
                                  ),
                                ),
                              ],
                            ),

                            // Quiz/Survey and Anonymous
                            Row(
                              children: [
                                // Quiz or Survey
                                Padding(
                                  padding: const EdgeInsets.all(padding),
                                  child: SizedBox(
                                    width: columnWidth,
                                    height: rowHeight,
                                    child: genDropdownMenu(
                                        _formKey,
                                        'Quiz or Survey',
                                        appState.hostType,
                                        () => ['Quiz', 'Survey'],
                                        setHostType),
                                  ),
                                ),

                                // horizontal spacing
                                SizedBox(width: 16),

                                Padding(
                                  padding: const EdgeInsets.all(padding),
                                  child: SizedBox(
                                    width: columnWidth,
                                    height: rowHeight,
                                    child: genDropdownMenu(
                                        _formKey,
                                        'Anonymous or Authenticated',
                                        appState.hostAnonymous,
                                        () => ['Anonymous', 'Autheticated'],
                                        setHostAnonymous),
                                  ),
                                ),
                              ],
                            ),

                            // Randomize Questions and Answers
                            Row(
                              children: [
                                // Randomize Questions
                                Padding(
                                  padding: const EdgeInsets.all(padding),
                                  child: SizedBox(
                                    width: columnWidth,
                                    height: rowHeight,
                                    child: genDropdownMenu(
                                        _formKey,
                                        'Randomize Questions',
                                        appState.hostRandomizeQuestions,
                                        () => ['Yes', 'No'],
                                        setHostRandomizeQuestions),
                                  ),
                                ),

                                // horizontal spacing
                                SizedBox(width: 16),

                                // Randomize Answers
                                Padding(
                                  padding: const EdgeInsets.all(padding),
                                  child: SizedBox(
                                    width: columnWidth,
                                    height: rowHeight,
                                    child: genDropdownMenu(
                                        _formKey,
                                        'Randomize Answers',
                                        appState.hostRandomizeAnswers,
                                        () => ['Yes', 'No'],
                                        setHostRandomizeAnswers),
                                  ),
                                ),
                              ],
                            ),

                            // Submit button
                            SizedBox(height: 20),
                            Padding(
                              padding: const EdgeInsets.all(padding),
                              child: Align(
                                child: ElevatedButton(
                                  onPressed: () async {
                                    // Validate returns true if the form is valid, or false otherwise.
                                    if (_formKey.currentState!.validate()) {
                                      // If the form is valid, display a snackbar. In the real world,
                                      // you'd often call a server or save the information in a database.
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(content: genText(snack)),
                                      );
                                      appState.createOrUpdateQuiz();
                                      setState(() {
                                        appState.cloneQuizId = '';
                                        appState.hostQuizId = '';
                                        appState.editQuizId = '';
                                        appState.selectedIndex = 0;
                                        appState.selectedPageIndex = 0;
                                      });
                                    }
                                  },
                                  child: genText('Start ${appState.hostType}'),
                                ),
                              ),
                            ),
                          ]),
                        )),
                  ),
                ),
              ),
            );
          } else if (snapshot.hasError) {
            return genText('${snapshot.error}');
          }

          // By default, show a loading spinner.
          return const CircularProgressIndicator();
        });
  }
}

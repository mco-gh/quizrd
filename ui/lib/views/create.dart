import 'package:flutter/material.dart';

enum Synch { synchronous, asynchronous }

enum Anon { anonymous, authenticated }

enum ActivityType { quiz, survey }

enum Difficulty { trivial, easy, medium, hard, killer }

enum YN { yes, no }

// Define a custom Form widget.
class CreateQuizForm extends StatefulWidget {
  const CreateQuizForm({super.key});

  @override
  CreateQuizFormState createState() {
    return CreateQuizFormState();
  }
}

// Define a corresponding State class.
// This class holds data related to the form.
class CreateQuizFormState extends State<CreateQuizForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formKey,
      child: SizedBox(
        width: 600,
        child: ListView(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: TextFormField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Quiz name',
                ),
                // The validator receives the text that the user has entered.
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Missing quiz name';
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: TextFormField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Quiz description',
                ),
                // The validator receives the text that the user has entered.
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Missing quiz description';
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: Row(children: [
                SizedBox(
                  width: 281,
                  child: TextFormField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Number of Questions',
                    ),
                    // The validator receives the text that the user has entered.
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Must be an integer greater than zero';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(width: 22),
                SizedBox(
                  width: 281,
                  child: TextFormField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Seconds to respond',
                    ),
                    // The validator receives the text that the user has entered.
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Must be an integer greater than zero';
                      }
                      return null;
                    },
                  ),
                ),
              ]),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: Row(
                children: [
                  DropdownMenu<Difficulty>(
                    width: 181,
                    label: const Text('Difficulty Level'),
                    dropdownMenuEntries: [
                      DropdownMenuEntry(
                        label: 'Trivial',
                        value: Difficulty.trivial,
                      ),
                      DropdownMenuEntry(
                        label: 'Easy',
                        value: Difficulty.easy,
                      ),
                      DropdownMenuEntry(
                        label: 'Medium',
                        value: Difficulty.medium,
                      ),
                      DropdownMenuEntry(
                        label: 'Hard',
                        value: Difficulty.hard,
                      ),
                      DropdownMenuEntry(
                        label: 'Killer',
                        value: Difficulty.killer,
                      ),
                    ],
                  ),
                  const SizedBox(width: 20),
                  DropdownMenu<YN>(
                    width: 181,
                    label: const Text('Randomize Questions'),
                    dropdownMenuEntries: [
                      DropdownMenuEntry(
                        label: 'Yes',
                        value: YN.yes,
                      ),
                      DropdownMenuEntry(
                        label: 'No',
                        value: YN.no,
                      ),
                    ],
                  ),
                  const SizedBox(width: 20),
                  DropdownMenu<YN>(
                    width: 181,
                    label: const Text('Randomize Answers'),
                    dropdownMenuEntries: [
                      DropdownMenuEntry(
                        label: 'Yes',
                        value: YN.yes,
                      ),
                      DropdownMenuEntry(
                        label: 'No',
                        value: YN.no,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: ElevatedButton(
                onPressed: () {
                  // Validate returns true if the form is valid, or false otherwise.
                  if (_formKey.currentState!.validate()) {
                    // If the form is valid, display a snackbar. In the real world,
                    // you'd often call a server or save the information in a database.
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Processing Data')),
                    );
                  }
                },
                child: const Text('Submit'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CreatePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //var theme = Theme.of(context);
    //var appState = context.watch<AppState>();

    return CreateQuizForm();
  }
}

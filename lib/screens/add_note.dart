import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:note_app/app_state.dart';
import 'package:provider/provider.dart';

class AddNote extends StatefulWidget {
  const AddNote({super.key});

  @override
  State<AddNote> createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  DateTime selectDate = DateTime.now();
  DateTime createdAt = DateTime.now();
  DateTime updatedAt = DateTime.now();
  String? errorMessage;


  @override  
  void initState() {
    dateController.text = DateFormat('dd/MM/yyyy').format(DateTime.now());
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Add Note',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 16,),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              child: TextFormField(
                controller: titleController,
                textAlignVertical: TextAlignVertical.center,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  prefixIcon: const Icon(
                    Icons.padding, 
                    size: 16,
                    color: Colors.grey,
                  ),
                  hintText: 'Title',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 32,),
            TextFormField(
              controller: descController,
              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                prefixIcon: const Icon(
                  Icons.note_add,
                  size: 16,
                  color: Colors.grey,
                ),
                hintText: 'Description',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
              minLines: 7,
              maxLines: 100,
            ),
            const SizedBox(height: 16,),
            TextFormField(
              controller: dateController,
              textAlignVertical: TextAlignVertical.center,
              readOnly: true,
              onTap: () async {
                DateTime? newDate = await showDatePicker(
                  context: context,
                  initialDate: selectDate, 
                  firstDate: DateTime.now(), 
                  lastDate: DateTime.now().add(const Duration(days: 365)),
                );

                if (newDate != null) {
                  setState(() {
                    dateController.text = DateFormat('dd/MM/yyyy').format(newDate);
                    selectDate = newDate;
                  });
                }
              },
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                prefixIcon: const Icon(
                  Icons.punch_clock,
                  size: 16,
                  color: Colors.grey,
                ),
                hintText: 'Date',
                labelText: 'Time Schedule',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 32,),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.5,
              height: kToolbarHeight,
              child: TextButton(
                onPressed: () async {
                  final appState = Provider.of<ApplicationState>(context, listen: false);
                  String uid = appState.uid ?? '';
                  if (titleController.text.isEmpty) {
                    setState(() {
                      errorMessage = 'Please enter title';
                    });
                  }
                  if (descController.text.isEmpty) {
                    setState(() {
                      errorMessage = 'Please enter description';
                    });
                  }

                  await _saveNote(uid, titleController.text, descController.text, createdAt, updatedAt, selectDate);
                  Navigator.pop(context);
                },
                style: TextButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Save',
                  style: TextStyle(
                    fontSize: 22,
                    color: Colors.white,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> _saveNote(String userId, String title, String description, DateTime createdAt, DateTime updatedAt, DateTime selectDate) async {
    try {
      await FirebaseFirestore.instance.collection('notes').add({
        'userId': userId,
        'title': title,
        'description': description,
        'createdAt': createdAt,
        'updatedAt': updatedAt,
        'schedule': selectDate,
      });
    } catch (e) {
      setState(() {
        errorMessage = e.toString();
      });
    }
  }

}
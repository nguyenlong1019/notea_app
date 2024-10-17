import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:note_app/app_state.dart';
import 'package:note_app/screens/edit_note.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _search = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<ApplicationState>(context, listen: false);
    String uid = appState.uid ?? '';

    return SafeArea(
      child: Column(
        children: [
          const SizedBox(height: 16,),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            child: TextFormField(
              style: const TextStyle(color: Colors.white),
              controller: _search,
              onChanged: (value) {
                setState(() {
                  
                });
              },
              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.blue,
                prefixIcon: const Icon(
                  Icons.search,
                  size: 16,
                  color: Colors.white,
                ),
                hintText: 'Search for note',
                hintStyle: const TextStyle(color: Colors.white),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          const SizedBox(height: 32,),
          Expanded(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance.collection('notes')
              .orderBy('createdAt')
              .where('userId', isEqualTo: uid)
              .snapshots(), 
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  // print(snapshot.error);
                  return Center(
                    child: Text('Error: ${snapshot.error}'),
                  );
                }
            
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator(),);
                }
            
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Center(child: Text('No notes found.'),);
                }
            
                var notes = snapshot.data!.docs.where((note) {
                  var title = note['title'].toString().toLowerCase();
                  var search = _search.text.toLowerCase();
                  return title.contains(search);
                }).toList();
            
                return ListView.builder(
                  itemCount: notes.length,
                  itemBuilder: (context, index) {
                    var note = notes[index];
            
                    return Padding(
                      padding: const EdgeInsets.only(top: 16, left: 24, right: 24),
                      child: ListTile(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        leading: const Icon(Icons.library_books, color: Colors.white,),
                        title: Text(note['title'], style: const TextStyle(color: Colors.white),),
                        subtitle: Text(
                          note['description'].toString().length > 20 
                          ? '${note['description'].toString().substring(0, 20)}...' 
                          : note['description'], 
                          style: const TextStyle(color: Colors.white, fontSize: 12),),
                        onTap: () {
            
                        },
                        tileColor: Colors.deepPurple[200],
                        selectedTileColor: Colors.deepPurple[500],
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              onPressed: () {
                                // Navigator.push(context, MaterialPageRoute(builder: (context) => const EditNote(
                                //   noteId: note.id,
                                //   currentTitle: note['title'],
                                //   currentDesc: note['description'],
                                //   currentSchedule: note['schedule'] != null
                                //     ? DateTime.parse(note['schedule'])
                                //     : null,
                                // )));
                              }, 
                              icon: const Icon(Icons.edit),
                              color: Colors.white,
                            ),
                            IconButton(
                              onPressed: () {
                                FirebaseFirestore.instance.collection('notes')
                                  .doc(note.id)
                                  .delete();
                              }, 
                              icon: const Icon(Icons.delete),
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );              
              },
            ),
          )
        ],
      ),
    );
  }
}
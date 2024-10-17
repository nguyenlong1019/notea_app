// code edit 



// // edit_note_screen.dart
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';

// class EditNoteScreen extends StatefulWidget {
//   final String noteId;
//   final String currentTitle;
//   final String currentDescription;
//   final DateTime? currentSchedule;

//   const EditNoteScreen({
//     Key? key,
//     required this.noteId,
//     required this.currentTitle,
//     required this.currentDescription,
//     this.currentSchedule,
//   }) : super(key: key);

//   @override
//   _EditNoteScreenState createState() => _EditNoteScreenState();
// }

// class _EditNoteScreenState extends State<EditNoteScreen> {
//   final TextEditingController _titleController = TextEditingController();
//   final TextEditingController _descriptionController = TextEditingController();
//   DateTime? _selectedSchedule;

//   @override
//   void initState() {
//     super.initState();
//     _titleController.text = widget.currentTitle;
//     _descriptionController.text = widget.currentDescription;
//     _selectedSchedule = widget.currentSchedule;
//   }

//   @override
//   void dispose() {
//     _titleController.dispose();
//     _descriptionController.dispose();
//     super.dispose();
//   }

//   Future<void> _updateNote() async {
//     String title = _titleController.text.trim();
//     String description = _descriptionController.text.trim();

//     if (title.isEmpty || description.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Tiêu đề và mô tả không được để trống')),
//       );
//       return;
//     }

//     try {
//       await FirebaseFirestore.instance.collection('notes').doc(widget.noteId).update({
//         'title': title,
//         'description': description,
//         'updated_at': DateTime.now().toIso8601String(),
//         'schedule': _selectedSchedule?.toIso8601String(),
//       });

//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Ghi chú đã được cập nhật')),
//       );

//       Navigator.pop(context); // Quay lại màn hình Home
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Lỗi: $e')),
//       );
//     }
//   }

//   Future<void> _pickSchedule() async {
//     DateTime? pickedDate = await showDatePicker(
//       context: context,
//       initialDate: _selectedSchedule ?? DateTime.now(),
//       firstDate: DateTime.now(),
//       lastDate: DateTime(2100),
//     );

//     if (pickedDate != null) {
//       TimeOfDay? pickedTime = await showTimePicker(
//         context: context,
//         initialTime: TimeOfDay.fromDateTime(_selectedSchedule ?? DateTime.now()),
//       );

//       if (pickedTime != null) {
//         setState(() {
//           _selectedSchedule = DateTime(
//             pickedDate.year,
//             pickedDate.month,
//             pickedDate.day,
//             pickedTime.hour,
//             pickedTime.minute,
//           );
//         });
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Chỉnh sửa ghi chú'),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.save),
//             onPressed: _updateNote,
//           ),
//         ],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             TextField(
//               controller: _titleController,
//               decoration: const InputDecoration(
//                 labelText: 'Tiêu đề',
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             const SizedBox(height: 16),
//             TextField(
//               controller: _descriptionController,
//               maxLines: 5,
//               decoration: const InputDecoration(
//                 labelText: 'Mô tả',
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             const SizedBox(height: 16),
//             Row(
//               children: [
//                 const Text('Lịch nhắc nhở:'),
//                 const SizedBox(width: 16),
//                 Text(_selectedSchedule != null
//                     ? '${_selectedSchedule!.day}/${_selectedSchedule!.month}/${_selectedSchedule!.year} ${_selectedSchedule!.hour}:${_selectedSchedule!.minute}'
//                     : 'Chưa chọn'),
//                 const Spacer(),
//                 ElevatedButton(
//                   onPressed: _pickSchedule,
//                   child: const Text('Chọn ngày'),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }






// code home 

// // home_screen.dart
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:note_app/app_state.dart';
// import 'package:provider/provider.dart';
// import 'edit_note_screen.dart'; // Import màn hình chỉnh sửa

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   final TextEditingController _search = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     final appState = Provider.of<ApplicationState>(context, listen: false);
//     String uid = appState.uid ?? '';

//     return SafeArea(
//       child: Column(
//         children: [
//           SizedBox(
//             width: MediaQuery.of(context).size.width * 0.8,
//             child: TextFormField(
//               controller: _search,
//               textAlignVertical: TextAlignVertical.center,
//               decoration: InputDecoration(
//                 filled: true,
//                 fillColor: Colors.white,
//                 prefixIcon: const Icon(
//                   Icons.search,
//                   size: 16,
//                   color: Colors.grey,
//                 ),
//                 hintText: 'Search for note',
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(30),
//                   borderSide: BorderSide.none,
//                 ),
//               ),
//               onChanged: (value) {
//                 setState(() {}); // Cập nhật UI khi tìm kiếm
//               },
//             ),
//           ),
//           const SizedBox(height: 32,),
//           Expanded(
//             child: StreamBuilder(
//               stream: FirebaseFirestore.instance.collection('notes')
//                 .orderBy('createdAt')
//                 .where('userId', isEqualTo: uid)
//                 .snapshots(),
//               builder: (context, snapshot) {
//                 if (snapshot.hasError) {
//                   return Center(
//                     child: Text('Error: ${snapshot.error}'),
//                   );
//                 }

//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   return const Center(child: CircularProgressIndicator(),);
//                 }

//                 if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
//                   return const Center(child: Text('No notes found.'),);
//                 }

//                 var notes = snapshot.data!.docs.where((note) {
//                   var title = note['title'].toString().toLowerCase();
//                   var search = _search.text.toLowerCase();
//                   return title.contains(search);
//                 }).toList();

//                 return ListView.builder(
//                   itemCount: notes.length,
//                   itemBuilder: (context, index) {
//                     var note = notes[index];

//                     return Padding(
//                       padding: const EdgeInsets.only(top: 16, left: 24, right: 24),
//                       child: ListTile(
//                         title: Text(note['title'], style: const TextStyle(color: Colors.white),),
//                         onTap: () {
//                           // Bạn có thể thêm hành động khi nhấn vào ghi chú, ví dụ mở chi tiết ghi chú
//                         },
//                         tileColor: Colors.deepPurple[200],
//                         selectedTileColor: Colors.deepPurple[500],
//                         trailing: Row(
//                           mainAxisSize: MainAxisSize.min,
//                           children: [
//                             IconButton(
//                               onPressed: () {
//                                 // Mở màn hình chỉnh sửa khi nhấn nút edit
//                                 Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                     builder: (context) => EditNoteScreen(
//                                       noteId: note.id,
//                                       currentTitle: note['title'],
//                                       currentDescription: note['description'],
//                                       currentSchedule: note['schedule'] != null 
//                                         ? DateTime.parse(note['schedule'])
//                                         : null,
//                                     ),
//                                   ),
//                                 );
//                               }, 
//                               icon: const Icon(Icons.edit),
//                               color: Colors.white,
//                             ),
//                             IconButton(
//                               onPressed: () async {
//                                 // Xác nhận trước khi xóa ghi chú
//                                 bool confirm = await showDialog(
//                                   context: context,
//                                   builder: (context) => AlertDialog(
//                                     title: const Text('Xác nhận'),
//                                     content: const Text('Bạn có chắc chắn muốn xóa ghi chú này?'),
//                                     actions: [
//                                       TextButton(
//                                         onPressed: () => Navigator.pop(context, false),
//                                         child: const Text('Hủy'),
//                                       ),
//                                       TextButton(
//                                         onPressed: () => Navigator.pop(context, true),
//                                         child: const Text('Xóa'),
//                                       ),
//                                     ],
//                                   ),
//                                 );

//                                 if (confirm) {
//                                   try {
//                                     await FirebaseFirestore.instance
//                                       .collection('notes')
//                                       .doc(note.id)
//                                       .delete();

//                                     ScaffoldMessenger.of(context).showSnackBar(
//                                       const SnackBar(content: Text('Ghi chú đã được xóa')),
//                                     );
//                                   } catch (e) {
//                                     ScaffoldMessenger.of(context).showSnackBar(
//                                       SnackBar(content: Text('Lỗi: $e')),
//                                     );
//                                   }
//                                 }
//                               }, 
//                               icon: const Icon(Icons.delete),
//                               color: Colors.white,
//                             ),
//                           ],
//                         ),
//                       ),
//                     );
//                   },
//                 );              
//               },
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }





// code phaanf pop up hieenr thij chi tiet note owr main 
// Code phan lich (calender)
// Code phan hen gio notification 
// import 'package:flutter/material.dart';

// class EditNote extends StatefulWidget {
//   final String noteId;
//   final String currentTitle;
//   final String currentDesc;
//   final DateTime? currentSchedule;

//   const EditNote({
//     super.key,
//     required this.noteId,
//     required this.currentTitle,
//     required this.currentDesc,
//     this.currentSchedule
//   });

//   @override
//   State<EditNote> createState() => _EditNoteState();
// }

// class _EditNoteState extends State<EditNote> {
//   final TextEditingController _titleController = TextEditingController();
//   final TextEditingController _descController = TextEditingController();
//   DateTime? _selectedSchedule;

//   @override  
//   void initState() {
//     super.initState();
//     _titleController.text = widget.currentTitle;
//     _descController.text = widget.currentDesc;
//     _selectedSchedule = widget.currentSchedule;
//   }

//   @override   
//   void dispose() {
//     _titleController.dispose();
//     _descController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Theme.of(context).colorScheme.surface,
//       appBar: AppBar(
//         backgroundColor: Theme.of(context).colorScheme.surface,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             const Text(
//               'Add Note',
//               style: TextStyle(
//                 fontSize: 22,
//                 fontWeight: FontWeight.w500,
//               ),
//             ),
//             const SizedBox(height: 16,),
//             SizedBox(
//               width: MediaQuery.of(context).size.width * 0.8,
//               child: TextFormField(
//                 controller: titleController,
//                 textAlignVertical: TextAlignVertical.center,
//                 decoration: InputDecoration(
//                   filled: true,
//                   fillColor: Colors.white,
//                   prefixIcon: const Icon(
//                     Icons.padding, 
//                     size: 16,
//                     color: Colors.grey,
//                   ),
//                   hintText: 'Title',
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(30),
//                     borderSide: BorderSide.none,
//                   ),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 32,),
//             TextFormField(
//               controller: descController,
//               textAlignVertical: TextAlignVertical.center,
//               decoration: InputDecoration(
//                 filled: true,
//                 fillColor: Colors.white,
//                 prefixIcon: const Icon(
//                   Icons.note_add,
//                   size: 16,
//                   color: Colors.grey,
//                 ),
//                 hintText: 'Description',
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(12),
//                   borderSide: BorderSide.none,
//                 ),
//               ),
//               minLines: 7,
//               maxLines: 100,
//             ),
//             const SizedBox(height: 16,),
//             TextFormField(
//               controller: dateController,
//               textAlignVertical: TextAlignVertical.center,
//               readOnly: true,
//               onTap: () async {
//                 DateTime? newDate = await showDatePicker(
//                   context: context,
//                   initialDate: selectDate, 
//                   firstDate: DateTime.now(), 
//                   lastDate: DateTime.now().add(const Duration(days: 365)),
//                 );

//                 if (newDate != null) {
//                   setState(() {
//                     dateController.text = DateFormat('dd/MM/yyyy').format(newDate);
//                     selectDate = newDate;
//                   });
//                 }
//               },
//               decoration: InputDecoration(
//                 filled: true,
//                 fillColor: Colors.white,
//                 prefixIcon: const Icon(
//                   Icons.punch_clock,
//                   size: 16,
//                   color: Colors.grey,
//                 ),
//                 hintText: 'Date',
//                 labelText: 'Time Schedule',
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(12),
//                   borderSide: BorderSide.none,
//                 ),
//               ),
//             ),
//             const SizedBox(height: 32,),
//             SizedBox(
//               width: MediaQuery.of(context).size.width * 0.5,
//               height: kToolbarHeight,
//               child: TextButton(
//                 onPressed: () async {
//                   final appState = Provider.of<ApplicationState>(context, listen: false);
//                   String uid = appState.uid ?? '';
//                   if (titleController.text.isEmpty) {
//                     setState(() {
//                       errorMessage = 'Please enter title';
//                     });
//                   }
//                   if (descController.text.isEmpty) {
//                     setState(() {
//                       errorMessage = 'Please enter description';
//                     });
//                   }

//                   await _saveNote(uid, titleController.text, descController.text, createdAt, updatedAt, selectDate);
//                   Navigator.pop(context);
//                 },
//                 style: TextButton.styleFrom(
//                   backgroundColor: Colors.blue,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                 ),
//                 child: const Text(
//                   'Save',
//                   style: TextStyle(
//                     fontSize: 22,
//                     color: Colors.white,
//                   ),
//                 ),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
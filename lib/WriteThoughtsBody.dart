import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class WriteThoughtsBody extends StatefulWidget {
  const WriteThoughtsBody({super.key});

  @override
  State<WriteThoughtsBody> createState() => _WriteThoughtsBodyState();
}

class _WriteThoughtsBodyState extends State<WriteThoughtsBody> {
  List<Note> notes = [];
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadNotes();
  }

  Future<void> _loadNotes() async {
    final prefs = await SharedPreferences.getInstance();
    final String? notesJson = prefs.getString('cosmic_notes');
    if (notesJson != null) {
      final List<dynamic> decoded = jsonDecode(notesJson);
      setState(() {
        notes = decoded.map((e) => Note.fromJson(e)).toList();
      });
    }
  }

  Future<void> _saveNotes() async {
    final prefs = await SharedPreferences.getInstance();
    final String encoded = jsonEncode(notes.map((n) => n.toJson()).toList());
    await prefs.setString('cosmic_notes', encoded);
  }

  void _addOrUpdateNote({int? index}) async {
    if (_titleController.text.trim().isEmpty &&
        _contentController.text.trim().isEmpty) {
      return;
    }

    setState(() {
      final note = Note(
        title: _titleController.text.trim(),
        content: _contentController.text.trim(),
        createdAt: DateTime.now(),
      );

      if (index != null) {
        notes[index] = note;
      } else {
        notes.insert(0, note); // newest on top
      }
    });

    await _saveNotes();

    _titleController.clear();
    _contentController.clear();
    Navigator.pop(context); // close bottom sheet
  }

  void _deleteNote(int index) async {
    setState(() {
      notes.removeAt(index);
    });
    await _saveNotes();
  }

  void _showNoteEditor({int? index}) {
    final isEdit = index != null;
    if (isEdit) {
      _titleController.text = notes[index!].title;
      _contentController.text = notes[index].content;
    } else {
      _titleController.clear();
      _contentController.clear();
    }

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.9,
          minChildSize: 0.5,
          maxChildSize: 0.95,
          builder: (_, scrollController) {
            return Container(
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.75),
                borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
                border: Border.all(color: Colors.cyanAccent.withOpacity(0.3), width: 1.2),
              ),
              child: Column(
                children: [
                  // Handle bar
                  Container(
                    width: 40,
                    height: 5,
                    margin: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.4),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),

                  Expanded(
                    child: ListView(
                      controller: scrollController,
                      padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
                      children: [
                        TextField(
                          controller: _titleController,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                          decoration: InputDecoration(
                            hintText: "Title",
                            hintStyle: TextStyle(color: Colors.white70),
                            border: InputBorder.none,
                          ),
                        ),
                        const SizedBox(height: 16),
                        TextField(
                          controller: _contentController,
                          maxLines: null,
                          style: const TextStyle(color: Colors.white, fontSize: 16),
                          decoration: InputDecoration(
                            hintText: "Write your thoughts...",
                            hintStyle: TextStyle(color: Colors.white54),
                            border: InputBorder.none,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Action buttons
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        if (isEdit)
                          TextButton.icon(
                            icon: const Icon(Icons.delete_outline, color: Colors.redAccent),
                            label: const Text("Delete", style: TextStyle(color: Colors.redAccent)),
                            onPressed: () {
                              _deleteNote(index!);
                              Navigator.pop(context);
                            },
                          ),
                        const Spacer(),
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text("Cancel", style: TextStyle(color: Colors.white70)),
                        ),
                        const SizedBox(width: 8),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.cyanAccent.withOpacity(0.25),
                            foregroundColor: Colors.cyanAccent,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                          ),
                          onPressed: () => _addOrUpdateNote(index: index),
                          child: Text(isEdit ? "Save" : "Add"),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: false,
      appBar: AppBar(
        backgroundColor: Colors.black.withOpacity(0.4),
        elevation: 0,
        title: const Text(
          "Thoughts",
          style: TextStyle(
            color: Colors.cyanAccent,
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          // Background
          Image.asset(
            'assets/background.jpg',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),


          // Dark overlay
          Container(
            decoration: BoxDecoration(
              gradient: RadialGradient(
                center: Alignment.topCenter,
                radius: 1.8,
                colors: [
                  Colors.transparent,
                  Colors.black.withOpacity(0.6),
                  Colors.black.withOpacity(0.92),
                ],
                stops: const [0.0, 0.4, 1.0],
              ),
            ),
          ),

          // Notes grid
          notes.isEmpty
              ? Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [

                const SizedBox(height: 16),
                Text(
                  "Your cosmic thoughts will appear here...",
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 18,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          )
              : ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: notes.length,
            itemBuilder: (context, index) {
              final note = notes[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: GestureDetector(
                  onTap: () => _showNoteEditor(index: index),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.07),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.white.withOpacity(0.15), width: 1),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.4),
                          blurRadius: 20,
                          spreadRadius: 5,
                        ),
                        BoxShadow(
                          color: Colors.cyanAccent.withOpacity(0.08),
                          blurRadius: 30,
                          spreadRadius: -8,
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (note.title.isNotEmpty)
                            Text(
                              note.title,
                              style: const TextStyle(
                                color: Colors.cyanAccent,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          if (note.title.isNotEmpty) const SizedBox(height: 8),
                          Text(
                            note.content,
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.9),
                              fontSize: 15,
                              height: 1.4,
                            ),
                            maxLines: 6,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 20),
                          Text(
                            "${note.createdAt.day}/${note.createdAt.month}/${note.createdAt.year}",
                            style: TextStyle(
                              color: Colors.white54,
                              fontSize: 12,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.purpleAccent.withOpacity(0.7),
        foregroundColor: Colors.white,
        shape: const CircleBorder(),
        onPressed: () => _showNoteEditor(),
        child: const Icon(Icons.add_rounded, size: 32),
      ),
    );
  }
}


class Note {
  final String title;
  final String content;
  final DateTime createdAt;

  Note({
    required this.title,
    required this.content,
    required this.createdAt,
  });

  Map<String, dynamic> toJson() => {
    'title': title,
    'content': content,
    'createdAt': createdAt.toIso8601String(),
  };

  factory Note.fromJson(Map<String, dynamic> json) => Note(
    title: json['title'] as String,
    content: json['content'] as String,
    createdAt: DateTime.parse(json['createdAt'] as String),
  );
}
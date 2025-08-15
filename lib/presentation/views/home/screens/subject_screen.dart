import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:teachmeiti/utils/consts/const_colors.dart';
import 'package:teachmeiti/utils/consts/const_text.dart';

class SubjectScreen extends StatefulWidget {
  final String subjectId; // Firestore document ID for the subject
  final String subjectName;

  const SubjectScreen({
    Key? key,
    required this.subjectId,
    required this.subjectName,
  }) : super(key: key);

  @override
  State<SubjectScreen> createState() => _SubjectScreenState();
}

class _SubjectScreenState extends State<SubjectScreen> {
  String? currentUserUID;
  final String adminUID = ConstText.admin; // Replace with your admin UID

  @override
  void initState() {
    super.initState();
    _loadCurrentUserUID();
  }

  Future<void> _loadCurrentUserUID() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      currentUserUID = prefs.getString(ConstText.sharedprefIDU);
    });
  }

  Future<void> _showAddAnnouncementDialog() async {
    TextEditingController announcementController = TextEditingController();

    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Add Announcement"),
        content: TextField(
          controller: announcementController,
          decoration: InputDecoration(
            hintText: "Enter announcement details...",
          ),
          maxLines: 3,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: ConstColors.safeareacolor,
            ),
            onPressed: () async {
             try {
                if (announcementController.text.isNotEmpty) {
                  await FirebaseFirestore.instance
                      .collection("subjects")
                      .doc(widget.subjectId)
                      .collection("announcements")
                      .add({
                    "content": announcementController.text,
                    "timestamp": FieldValue.serverTimestamp(),
                    "createdBy": currentUserUID,
                  });
                  Navigator.pop(context);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Announcement cannot be empty")),
                  );
                }
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Failed to add announcement: $e")),
                  
                );
                print("Error adding announcement: $e");
              }
            },
            child: Text("Add"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.subjectName,
          style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
        ),
        backgroundColor: ConstColors.safeareacolor,
      ),
      floatingActionButton: currentUserUID == adminUID
          ? FloatingActionButton(
              onPressed: _showAddAnnouncementDialog,
              backgroundColor: ConstColors.safeareacolor,
              child: Icon(Icons.add),
            )
          : null,
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("subjects")
            .doc(widget.subjectId)
            .collection("announcements")
            .orderBy("timestamp", descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(
              child: Text(
                "No announcements yet",
                style: GoogleFonts.poppins(fontSize: 16),
              ),
            );
          }

          return ListView.builder(
            padding: EdgeInsets.all(12),
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              var doc = snapshot.data!.docs[index];
              var data = doc.data() as Map<String, dynamic>;

              DateTime? time;
              if (data["timestamp"] != null) {
                time = (data["timestamp"] as Timestamp).toDate();
              }

              return Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                elevation: 3,
                margin: EdgeInsets.symmetric(vertical: 8),
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data["content"] ?? "",
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            time != null
                                ? "${time.day}/${time.month}/${time.year} ${time.hour}:${time.minute.toString().padLeft(2, '0')}"
                                : "Unknown time",
                            style: GoogleFonts.poppins(
                              fontSize: 13,
                              color: Colors.grey[600],
                            ),
                          ),
                          if (data["createdBy"] == adminUID)
                            Icon(Icons.verified, color: Colors.blue, size: 18),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

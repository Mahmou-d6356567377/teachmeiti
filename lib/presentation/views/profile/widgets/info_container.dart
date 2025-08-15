
import 'package:flutter/material.dart';

class InfoContainer extends StatelessWidget {
  final String? studentId;
  final String? maritalStatus;
  final String? nationality;
  final String? residence;

  const InfoContainer({
    super.key,
    this.studentId,
    this.maritalStatus,
    this.nationality,
    this.residence,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      
      width: double.infinity,
      padding: const EdgeInsets.all(15.0),
      margin: const EdgeInsets.symmetric(vertical: 15.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'INFO',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          ListTile(
            title: Text('Student ID: $studentId'),
          ),
          ListTile(
            title: Text('Marital Status: $maritalStatus'),
          ),
          ListTile(
            title: Text('Nationality: $nationality'),
          ),
          ListTile(
            title: Text('Residence: $residence'),
          ),
        ],
      ),
    );
  }
}
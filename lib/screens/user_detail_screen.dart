import 'package:flutter/material.dart';
import '../models/user.dart';
import '../services/api_service.dart';

class UserDetailScreen extends StatelessWidget {
  final int userId;

  UserDetailScreen({required this.userId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Pengguna'),
      ),
      body: FutureBuilder<User>(
        future: ApiService().getUser(userId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final user = snapshot.data!;
            return Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(user.avatar),
                  ),
                  SizedBox(height: 16),
                  Text(user.firstName + ' ' + user.lastName,
                      style: TextStyle(fontSize: 20)),
                  SizedBox(height: 8),
                  Text(user.email),
                  // Tampilkan informasi tambahan yang ada di API
                ],
              ),
            );
          }
        },
      ),
    );
  }
}

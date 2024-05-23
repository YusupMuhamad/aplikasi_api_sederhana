import 'package:flutter/material.dart';

class DetailPage extends StatelessWidget {
  final Map<String, String> user;

  const DetailPage({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${user['first_name']} ${user['last_name']}'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (user.containsKey('avatar'))
              CircleAvatar(
                backgroundImage: NetworkImage(user['avatar']!),
                radius: 50.0,
              ),
            const SizedBox(
              height: 20,
            ),
            Text('ID: ${user['id']}'),
            Text('Selamat datang, ${user['first_name']} ${user['last_name']}!'),
            if (user.containsKey('email')) Text('Email: ${user['email']}'),
          ],
        ),
      ),
    );
  }
}

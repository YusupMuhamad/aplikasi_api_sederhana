import 'package:aplikasi_api_sederhana/tambah.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, String>> users = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    var url = Uri.parse("https://reqres.in/api/users");
    var response = await http.get(url);
    var data = jsonDecode(response.body)['data'] as List;

    setState(() {
      users = data
          .map<Map<String, String>>((user) => {
                'id': user['id'].toString(),
                'first_name': user['first_name'],
                'last_name': user['last_name'],
                'avatar': user['avatar']
              })
          .toList();
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: isLoading
          ? const CircularProgressIndicator()
          : UserListView(users: users),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => TambahPengguna()),
          );
        },
        tooltip: 'Tambah Pengguna',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class UserListView extends StatelessWidget {
  final List<Map<String, String>> users;

  const UserListView({super.key, required this.users});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: users.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(users[index]['avatar']!),
          ),
          title: Text(
              '${users[index]['first_name']} ${users[index]['last_name']}'),
          subtitle: Text('ID: ${users[index]['id']}'),
        );
      },
    );
  }
}

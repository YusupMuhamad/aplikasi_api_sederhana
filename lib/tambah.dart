import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TambahPengguna extends StatefulWidget {
  const TambahPengguna({super.key});

  @override
  State<TambahPengguna> createState() => _TambahPenggunaState();
}

class _TambahPenggunaState extends State<TambahPengguna> {
  final _formKey = GlobalKey<FormState>();
  String? name;
  String? job;

  Future<void> submitData() async {
    var response = await http.post(
      Uri.parse('https://reqres.in/api/users'),
      body: {
        'name': name,
        'job': job,
      },
    );

    if (!mounted) return;
    if (response.statusCode == 201) {
      var data = jsonDecode(response.body);
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Data berhasil ditambahkan'),
            content:
                Text('ID: ${data['id']}\nDibuat pada: ${data['createdAt']}'),
          );
        },
      );
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
            title: Text('Error'),
            content: Text('Gagal menambahkan data'),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Pengguna'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Name',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Mohon maaf, harap masukkan nama';
                  }
                  return null;
                },
                onSaved: (value) {
                  name = value;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Job',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Mohon maaf, harap masukkan pekerjaan';
                  }
                  return null;
                },
                onSaved: (value) {
                  job = value;
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      submitData();
                    }
                  },
                  child: const Text('Submit'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

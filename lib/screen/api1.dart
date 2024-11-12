import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PageApiOne extends StatefulWidget {
  const PageApiOne({super.key});

  @override
  State<PageApiOne> createState() => _PageApiOneState();
}

class _PageApiOneState extends State<PageApiOne> {
  List<dynamic> users = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Users List with Avatar',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.purple,
      ),
      body: users.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                final user = users[index];
                final avatarUrl = user['avatar'];
                final name = user['first_name'] + ' ' + user['last_name'];
                final email = user['email'];

                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(avatarUrl),
                  ),
                  title: Text(name),
                  subtitle: Text(email),
                );
              },
            ),
    );
  }

  void fetchData() async {
    const url = 'https://reqres.in/api/users?page=1';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final body = response.body;
    final json = jsonDecode(body);
    setState(() {
      users = json['data'];
    });
  }
}

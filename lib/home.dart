import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:post_api_prac_2/model.dart';

class Homee extends StatefulWidget {
  const Homee({Key? key}) : super(key: key);

  @override
  State<Homee> createState() => _HomeeState();
}

class _HomeeState extends State<Homee> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController jobController = TextEditingController();

  Posting? _posting;

  String urll = "https://reqres.in/api/users";

  Future<Posting?> fetchData(String name, String job) async {
    http.Response response = await http.post(
      Uri.parse(urll),
      body: {
        "name": name,
        "job": job,
      },
    );
    var jsonDecoded = json.decode(response.body);
    Posting posting = await Posting.fromJson(jsonDecoded);

    return posting;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Posting Data'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(hintText: 'Name'),
            ),
            TextField(
              controller: jobController,
              decoration: const InputDecoration(hintText: 'Job'),
            ),
            const SizedBox(height: 20),
            _posting == null
                ? Container()
                : Text(
                    'User ${_posting!.name} is successfully created at ${_posting!.createdAt}'),
            ElevatedButton(
              onPressed: () async {
                //  await   fetchData(nameController.text.toString(),
                //         jobController.text.toString());

                Posting? user = await fetchData(nameController.text.toString(),
                    jobController.text.toString());

                setState(() {
                  _posting = user;
                });
              },
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}

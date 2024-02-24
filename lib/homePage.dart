import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:new_flutter/internet_service/translations_dio.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late String _selectedValueFrom;
  late String _selectedValueTo;
  late TextEditingController _controller;
  late String jsonString;
  late Map<String, dynamic> requestData;

  late String translatedText = '';

  List<List<String>> languages = [
    ['Русский', 'ru'],
    ['English', 'en'],
    ['Deutsch', 'de'],
    ['Spanish', 'es'],
    ['Italian', 'it'],
    ['Slovenian', 'sl'],
    ['Filipino', 'tl'],
    ['Kazach', 'kk'],
    ['Turkish', 'tr']
  ];

  Future<void> translateAndHandleResponse() async {
    final TranslationsDio translationsDio = TranslationsDio();
    jsonString = await rootBundle.loadString('lib/assets/body.json');
    requestData = json.decode(jsonString);
    requestData['texts'] = _controller.text;
    requestData['targetLanguageCode'] = _selectedValueTo;
    requestData['sourceLanguageCode'] = _selectedValueFrom;

    try {
      final jsonResponse = await translationsDio.translateData(requestData);

      print('JSON Response: $jsonResponse');

      setState(() {
        translatedText = jsonResponse['translations'][0]['text'];
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    translateAndHandleResponse();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red[100],
        title: const Text('Translator'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: DropdownButton<String>(
                      hint: const Text(
                        "Language From ",
                        style: TextStyle(fontSize: 16.0),
                      ),
                      icon: const Icon(
                        Icons.translate,
                        color: Colors.pink,
                        size: 26.0,
                      ),
                      items: languages.map((List<String> lang) {
                        return DropdownMenuItem<String>(
                          value: lang[1],
                          child: Text(lang[0]),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedValueFrom = newValue!;
                        });
                      }),
                ),
                Expanded(
                  child: DropdownButton<String>(
                      hint: const Text(
                        "Language To ",
                        style: TextStyle(fontSize: 16.0),
                      ),
                      icon: const Icon(
                        Icons.translate,
                        color: Colors.pink,
                        size: 26.0,
                      ),
                      items: languages.map((List<String> lang) {
                        return DropdownMenuItem<String>(
                          value: lang[1],
                          child: Text(lang[0]),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedValueTo = newValue!;
                        });
                      }),
                ),
              ],
            ),
            const SizedBox(width: 20),
            TextField(
              controller: _controller,
              maxLines: 3,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Colors.red.shade200, width: 2.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Colors.red.shade300, width: 3.0),
                ),
                hintText: 'Enter text',
                hintStyle: const TextStyle(fontSize: 16.0),
              ),
            ),
            const SizedBox(height: 20),
            Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.red.shade400, width: 2.0),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Text(
                  translatedText,
                  style: const TextStyle(fontSize: 16),
                )),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.red.shade100),
              ),
              onPressed: () async {
                await translateAndHandleResponse();
              },
              child: const Text(
                'Translate',
                style: TextStyle(fontSize: 18.0, color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

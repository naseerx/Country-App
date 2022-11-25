import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;

import '../model/country_model.dart';
import 'country_detail_screen.dart';

class CountryListScreen extends StatefulWidget {
  const CountryListScreen({Key? key}) : super(key: key);

  @override
  State<CountryListScreen> createState() => _CountryListScreenState();
}

class _CountryListScreenState extends State<CountryListScreen> {
  late StreamController _streamController;
  late Stream _stream;
  var allCounter = <CountryModel>[];
  var searchList = <CountryModel>[];
  bool isSearching = false;

  searchByName(String value) {
    if (value.isEmpty) {
      setState(() {
        isSearching = false;
      });
    } else {
      searchList = allCounter
          .where((element) =>
              element.name.toLowerCase().contains(value.toLowerCase()))
          .toList();
      if (kDebugMode) {
        print('List $searchList');
      }
      setState(() {
        isSearching = true;
      });
    }
  }

  void getAllCountry() async {
    _streamController.add('loading');
    var url = 'https://restcountries.com/v2/all';
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      for (var myData in jsonData) {
        CountryModel countryModel = CountryModel.fromJSON(myData);
        allCounter.add(countryModel);
        _streamController.add(allCounter);
      }
    } else {
      return _streamController.add('went wrong');
    }
  }

  @override
  void initState() {
    _streamController = StreamController();
    _stream = _streamController.stream;
    getAllCountry();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const SizedBox(width: 08),
            Expanded(
              child: TextField(
                cursorColor: Colors.white,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                    hintText: 'Search Country...',
                    hintStyle: const TextStyle(color: Colors.white70),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: const BorderSide(color: Colors.white),
                    ),
                    enabledBorder: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 18)),
                onChanged: (value) {
                  setState(() {
                    searchByName(value);
                  });
                },
              ),
            ),
          ],
        ),
        toolbarHeight: 80,
      ),
      body: StreamBuilder(
        stream: _stream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data == 'loading') {
              return const CircularProgressIndicator();
            } else if (snapshot.data == 'went wrong') {
              return const Text('something went wrong');
            } else {
              return allCounter.isNotEmpty
                  ? ListView.builder(
                      itemCount: isSearching == false
                          ? allCounter.length
                          : searchList.length,
                      itemBuilder: (context, index) {
                        var myData = isSearching == false
                            ? allCounter[index]
                            : searchList[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: SizedBox(
                            height: 80,
                            child: ListTile(
                              onTap: () {
                                Navigator.of(context)
                                    .push(MaterialPageRoute(builder: (context) {
                                  return CountryDetailScreen(
                                      countryModel: myData);
                                }));
                              },
                              leading: ClipRRect(
                                borderRadius: BorderRadius.circular(15),

                                child: Container(
                                  height: 50,
                                  width: 80,
                                  color: Colors.black,
                                  child: SvgPicture.network(
                                    myData.flag.toString(),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              title: Text(
                                myData.name.toString(),
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                          ),
                        );
                      })
                  : const Center(
                      child: SizedBox(
                        width: 350,
                        child: Text(
                          'No Country.',
                          style: TextStyle(fontSize: 18),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    );
            }
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}

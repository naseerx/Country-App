import 'dart:async';
import 'dart:convert';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

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
        //print(allCounter.length);
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
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white60,
      appBar: AppBar(
        title: const Text('All Countries'),
      ),
      body: StreamBuilder(
        stream: _stream,
        builder: (context, snapshort) {
          if (snapshort.hasData) {
            if (snapshort.data == 'loading') {
              return  const CircularProgressIndicator();
            } else if (snapshort.data == 'went wrong') {
              return const Text('something went wrong');
            } else {
              return ListView.builder(
                  itemCount: allCounter.length,
                  itemBuilder: (context, index) {
                    CountryModel myData = allCounter[index];
                  return  SingleChildScrollView(
                    child: Card(
                      color: Colors.brown,
                        child: ListTile(
                          onTap: (){
                          Navigator.of(context).push(MaterialPageRoute(builder: (context)
                          {
                            return CountryDetailScreen(countryModel: myData);
                          }));

                          },
                          leading:SizedBox(
                            height: 50,
                            width: 80,
                            child: SvgPicture.network(myData.flag.toString(),
                              fit: BoxFit.cover,),
                          ),
                          title: Text(myData.name.toString(),style: const TextStyle(color: Colors.white,fontSize:18,fontWeight: FontWeight.w400),),

                        ) ,
                      ),

                  );
                  }
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

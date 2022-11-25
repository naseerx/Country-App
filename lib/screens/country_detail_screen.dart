import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../model/country_model.dart';

class CountryDetailScreen extends StatefulWidget {
  final CountryModel countryModel;

  const CountryDetailScreen({Key? key, required this.countryModel})
      : super(key: key);

  @override
  State<CountryDetailScreen> createState() => _CountryDetailScreenState();
}

class _CountryDetailScreenState extends State<CountryDetailScreen> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(widget.countryModel.name.toString()),
        toolbarHeight: 80,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(9.0),
              child: Card(
                clipBehavior: Clip.antiAlias,
                child: SizedBox(
                  height: size.height * 0.3,
                  width: size.width * 1,
                  child: SvgPicture.network(
                    widget.countryModel.flag.toString(),
                    fit: BoxFit.cover,
                  ),
                ),

                // shadowColor: Colors.green,
                elevation: 10,
                shape: BeveledRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              widget.countryModel.name.toString(),
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Region : ${widget.countryModel.region}',
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  const Divider(
                    thickness: 2,
                    color: Colors.black,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Capital : ${widget.countryModel.capital}',
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  const Divider(
                    thickness: 2,
                    color: Colors.black,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Area : ${widget.countryModel.area}',
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  const Divider(
                    thickness: 2,
                    color: Colors.black,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Population : ${widget.countryModel.population}',
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  const Divider(
                    thickness: 2,
                    color: Colors.black,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Borders : ${widget.countryModel.borders}',
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

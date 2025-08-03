import 'package:covid_tracker_app_flutter/Services/StateServices.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:covid_tracker_app_flutter/view/details_screen.dart';

class CountryListsScreen extends StatefulWidget {
  const CountryListsScreen({super.key});

  @override
  State<CountryListsScreen> createState() => _CountryListsScreenState();
}

class _CountryListsScreenState extends State<CountryListsScreen> {
  TextEditingController serchController = TextEditingController();
  StateServices stateServices = StateServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: TextFormField(
                controller: serchController,
                decoration: InputDecoration(
                  hintText: "Search your country here",
                  contentPadding: EdgeInsets.symmetric(horizontal: 20),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
                onChanged: (value) {
                  setState(() {});
                },
              ),
            ),
            Expanded(
              child: FutureBuilder(
                future: stateServices.countriesListApi(),
                builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                  if (!snapshot.hasData) {
                    return ListView.builder(
                      itemCount: 4,
                      itemBuilder: (context, index) {
                        return Shimmer.fromColors(
                          baseColor: Colors.grey.shade700,
                          highlightColor: Colors.grey.shade300,
                          child: Column(
                            children: [
                              ListTile(
                                title: Container(
                                  width: 89,
                                  height: 10,
                                  color: Colors.white,
                                ),
                                subtitle: Container(
                                  width: 89,
                                  height: 10,
                                  color: Colors.white,
                                ),
                                leading: Container(
                                  width: 50,
                                  height: 50,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  } else {
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        String name = snapshot.data![index]["country"];
                        if (serchController.text.isEmpty ||
                            name.toLowerCase().contains(
                              serchController.text.toLowerCase(),
                            )) {
                          return Column(
                            children: [
                              ListTile(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => DetailsScreen(
                                        name: snapshot.data![index]["country"],
                                        image: snapshot.data![index]["countryInfo"]["flag"],
                                        totalCases: snapshot.data![index]["cases"],
                                        totalRecovered: snapshot.data![index]["recovered"],
                                        totalDeaths: snapshot.data![index]["deaths"],
                                        active: snapshot.data![index]["active"],
                                        test: snapshot.data![index]["tests"],
                                        todayRecovered: snapshot.data![index]["todayRecovered"],
                                        critical: snapshot.data![index]["critical"],
                                      ),
                                    ),
                                  );
                                },
                                title: Text(snapshot.data![index]["country"]),
                                subtitle: Text(
                                  snapshot.data![index]["cases"].toString(),
                                ),
                                leading: Image(
                                  height: 50,
                                  width: 50,
                                  image: NetworkImage(
                                    snapshot.data![index]["countryInfo"]["flag"],
                                  ),
                                ),
                              ),
                            ],
                          );
                        }
                        else if(name.toLowerCase().contains(serchController.text.toLowerCase())){
                          return Column(
                          children: [
                          ListTile(
                          onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailsScreen(
                                name: snapshot.data![index]["country"],
                                image: snapshot.data![index]["countryInfo"]["flag"],
                                totalCases: snapshot.data![index]["cases"],
                                totalRecovered: snapshot.data![index]["recovered"],
                                totalDeaths: snapshot.data![index]["deaths"],
                                active: snapshot.data![index]["active"],
                                test: snapshot.data![index]["tests"],
                                todayRecovered: snapshot.data![index]["todayRecovered"],
                                critical: snapshot.data![index]["critical"],
                              ),
                            ),
                          );
                        },
                        title: Text(snapshot.data![index]["country"]),
                        subtitle: Text(
                        snapshot.data![index]["cases"].toString(),
                        ),
                        leading: Image(
                        height: 50,
                        width: 50,
                        image: NetworkImage(
                        snapshot.data![index]["countryInfo"]["flag"],
                        ),
                        ),
                        ),
                        ],
                        );
                        }
                        else {
                          return Container();
                        }
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

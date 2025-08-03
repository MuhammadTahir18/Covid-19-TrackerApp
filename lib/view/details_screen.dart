import 'package:covid_tracker_app_flutter/view/world_states.dart';
import 'package:flutter/material.dart';

class DetailsScreen extends StatefulWidget {

  String name,image;
  int totalCases,totalDeaths,totalRecovered,active,critical,todayRecovered,test;
   DetailsScreen({
    super.key,
    required this.name,
    required this.image,
    required this.totalCases,
    required this.totalDeaths,
    required this.totalRecovered,
    required this.active,
    required this.critical,
    required this.todayRecovered,
    required this.test,
  });

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.topCenter,
            children: [
              Padding(
                padding: EdgeInsets.only(top: MediaQuery.of(context).size.height*.067),
                child: Card(
                             child: Column(
                 children: [
                   SizedBox(height:  MediaQuery.of(context).size.height*.06),
                   ReuseableRow(title: "Cases",value: widget.totalCases.toString()),
                   ReuseableRow(title: "Recoveres",value: widget.totalRecovered.toString()),
                   ReuseableRow(title: "TodayRecovered",value: widget.todayRecovered.toString()),
                   ReuseableRow(title: "Critical",value: widget.critical.toString()),
                   ReuseableRow(title: "Deaths",value: widget.totalDeaths.toString()),
                 ],
                             )

                ),
              ),
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(widget.image),
              )
            ],
          )
        ],
      ),
    );
  }
}

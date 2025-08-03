import 'package:covid_tracker_app_flutter/Model/world_states_model.dart';
import 'package:covid_tracker_app_flutter/Services/StateServices.dart';
import 'package:covid_tracker_app_flutter/view/country_lists.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';
class WorldStates extends StatefulWidget {
  const WorldStates({super.key});

  @override
  State<WorldStates> createState() => _WorldStatesState();
}

class _WorldStatesState extends State<WorldStates>with TickerProviderStateMixin {

  late AnimationController _controller=AnimationController(
      duration: Duration(seconds: 3),
      vsync: this)..repeat();

  void dispose(){
    _controller.dispose();
  }

  final colorList=<Color>[
    Color(0xff4285f4),
    Color(0xff1aa260),
    Color(0xffde5246),

  ];
  @override
  Widget build(BuildContext context) {
    StateServices stateServices=StateServices();
    return  Scaffold(
      // backgroundColor: Colors.black,
      body: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: Column(
              children: [
             SizedBox(height: MediaQuery.of(context).size.height*0.01,),
              FutureBuilder(
                  future: stateServices.fetchworkedStatesRecord(),
                  builder: (context,AsyncSnapshot<WorldStatesModel> snapshot){

                    if(!snapshot.hasData){
                      return Expanded(
                        flex: 1,
                          child: SpinKitCircle(
                            color: Colors.white,
                            size: 50.0,
                            controller: _controller,
                          ),

                      );
                    }
                    else{
                        return Column(
                          children: [
                            PieChart(
                              dataMap: {
                                "Total":double.parse(snapshot.data!.cases.toString()),
                                "Recoverd":double.parse(snapshot.data!.recovered!.toString()),
                                "Deaths":double.parse(snapshot.data!.deaths.toString())
                              },
                              chartRadius: MediaQuery.of(context).size.width/3.2,
                              legendOptions: LegendOptions(
                                  legendPosition: LegendPosition.left
                              ),
                              animationDuration: Duration(seconds:2 ),
                              chartType: ChartType.ring,
                              colorList: colorList,
                              chartValuesOptions: ChartValuesOptions(
                                showChartValuesInPercentage: true
                              ),
                            ),
                            Padding(
                              padding:EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height*.06),
                              child: Card(
                                child: Column(
                                  children: [
                                    ReuseableRow(title: "Total", value: snapshot.data!.cases.toString()),
                                    ReuseableRow(title: "Recovered", value: snapshot.data!.recovered.toString()),
                                    ReuseableRow(title: "Deaths", value: snapshot.data!.deaths.toString()),
                                    ReuseableRow(title: "Critical", value: snapshot.data!.critical.toString()),
                                    ReuseableRow(title: "Today Deaths", value: snapshot.data!.todayDeaths.toString()),
                                    ReuseableRow(title: "Today Recovered", value: snapshot.data!.todayRecovered.toString()),
                                  ],
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap:(){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>CountryListsScreen()));
                                },
                              child: Container(
                                height: 50,
                                child: Center(child: Text("Track Countries")),
                                decoration: BoxDecoration(
                                    color: Color(0xff1aa260),
                                    borderRadius: BorderRadius.circular(10)
                                ),
                              ),
                            )
                          ],
                        );
                    }
                  }
              ),


              ],
            ),
          )
      ),
    );
  }
}

class ReuseableRow extends StatelessWidget {
  String title,value;
   ReuseableRow({super.key,required this.title,required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 10,right: 10,top: 10,bottom: 5),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title),
              Text(value ),

            ],
          ),
          SizedBox(height: 5,),
          Divider()
        ],
      ),
    );
  }
}


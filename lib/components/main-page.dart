import 'package:flutter/material.dart';
//import 'package:myapp/main.dart';

//import 'package:intl/intl.dart';

//import 'package:gradient_widgets/gradient_widgets.dart';

final deepBlue = const Color(0xFF1e6bfe);
final lightBlue = const Color(0xFF2cdee6);
final bgBlue = const Color(0xFF0e1323);

class MainPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MainPageState();
  }
}

class MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: lightBlue,
        onPressed: () {
          navigateToSubPage(context);
        },
        child: Icon(Icons.add),
      ),
      backgroundColor: bgBlue,
      appBar: PreferredSize(
          preferredSize: Size(20.0, 100.0),
          child: Container(
            height: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [deepBlue, lightBlue]),
            ),
            child: Container(
              margin: EdgeInsets.fromLTRB(20, 50, 0, 0),
              child: Text(
                "Time Space",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold),
              ),
            ),
          )),
      body: Center(
        child: NewAlarm(),
      ),
    );
  }

  Future navigateToSubPage(context) async {
    Navigator.push(context, MaterialPageRoute(builder: (context) => SubPage()));
  }
}

class NewAlarm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return NewAlarmState();
  }

}

int counter = 1;

class NewAlarmState extends State<NewAlarm> {
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(10),
      itemCount: counter,
      itemBuilder: (context, int counter) {
        return Container(
          alignment: Alignment.centerLeft,
          //child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 22.0, vertical: 6.0),
            child: Text('Alarm ${counter+1}',
                style: TextStyle(color: Colors.white)),
          ),
          //),
          height: 50,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                deepBlue,
                lightBlue,
              ],
            ),
            borderRadius: BorderRadius.circular(10.0),
          ),
        );
      },
      separatorBuilder: (BuildContext context, int counter) => const Divider(),
    );
  }
}


// Sub page code starts HERE:

class SubPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SubPageState();
  }
}

class CustomTextField extends StatefulWidget {
  @override
  createState() => SubPageState();
}

class SubPageState extends State<SubPage> {
  @override
  Widget build(BuildContext context) {
    return buildScaffold(context);
  }

  //Controller Portion Code:
  final myController = TextEditingController();

  @override
  void initState() {
    super.initState();
    myController.addListener(printLatestValue);
  }

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  printLatestValue() {
    print('${myController.text}');
  }


  // Back to MainPage function:
  void backToMainPage(context) {
    Navigator.pop(context);
  }

  // Time Picker functions and variables:
  TimeOfDay selectedTime = TimeOfDay.now();
  Future<Null> selectTime({
    @required BuildContext context,
    @required TimeOfDay initialTime,
    TransitionBuilder builder,
  }) async {
    assert(context != null);
    assert(initialTime != null);
    assert(debugCheckHasMaterialLocalizations(context));

    final TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null && picked != selectedTime)
      setState(() {
        selectedTime = picked;
      });
  }

  Scaffold buildScaffold(BuildContext context) {
    return Scaffold(
        backgroundColor: bgBlue,
        appBar: PreferredSize(
            preferredSize: Size(null, 100.0),
            child: Container(
              height: 95,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [deepBlue, lightBlue]),
              ),
              child: Container(
                margin: EdgeInsets.fromLTRB(10, 50, 10, 0),
                child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      IconButton(
                        padding: EdgeInsets.only(bottom: 20),
                        onPressed: () {
                          backToMainPage(context);
                        },
                        icon: Icon(Icons.clear, size: 30, color: Colors.white),
                      ),
                      Text(
                        "Add Alarm",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold),
                      ),
                      IconButton(
                        padding: EdgeInsets.only(bottom: 15),
                        onPressed: () {
                          setState(() {
                            counter++;
                          });
                          backToMainPage(context);
                        },
                        icon: Icon(Icons.done, size: 30, color: Colors.white),
                      )
                    ]),
              ),
            )),
        body: Column(
          children: <Widget>[
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Container(
                  padding: EdgeInsets.fromLTRB(0, 40, 0, 40),
                  child: new Theme(
                      data: Theme.of(context).copyWith(
                        primaryColor: lightBlue,
                        accentColor: deepBlue,
                        dialogBackgroundColor: bgBlue,
                      ),
                      child: new Builder(
                          builder: (context) => new FlatButton(
                            onPressed: () {
                              selectTime(
                                  context: context,
                                  initialTime: selectedTime);
                            },
                            child: Text(
                              '${selectedTime.hourOfPeriod} : ${selectedTime.minute} ',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold),
                            ),
                          ))))
            ]),
            Row(children: <Widget>[
              Expanded(
                child: Padding(
                    padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child: TextField(
                      controller: myController,
                      style: TextStyle(color: Colors.white, fontSize: 18),
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: deepBlue, width: 5),
                            borderRadius: BorderRadius.circular(10)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: lightBlue, width: 5),
                            borderRadius: BorderRadius.circular(10)),

                        //border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                        contentPadding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                        hintStyle:
                        TextStyle(color: Colors.white38, fontSize: 18),
                        hintText: 'Enter name of Alarm',
                      ),
                      onTap: () {
                        print("Add alarm name");
                      },
                      onSubmitted : (text) {
                        /*setState(() {
                         text;
                        });*/
                      },
                    )),
              )
            ])
          ],
        ));
  }
}
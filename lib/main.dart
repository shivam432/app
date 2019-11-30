import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttertoast/fluttertoast.dart';

void main() => runApp(MaterialApp(
      home: Student_dashboard(),
    ));

class Student_dashboard extends StatefulWidget {
  @override
  _Student_dashboardState createState() => _Student_dashboardState();
}

// Widget nameTemplate(name) {
//   return Row(
//     children: <Widget>[
//       Container(
//         child: Card(
//           margin: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 16.0),
//           child: Center(
//               child: Text(
//             name,
//             style: TextStyle(
//               color: Colors.amber,
//               fontWeight: FontWeight.bold,
//               fontSize: 20.0,
//             ),
//           )),
//         ),
//       ),
//       Container(
//         child: Card(
//           margin: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 16.0),
//           child: Center(
//               child: Text(
//             name,
//             style: TextStyle(
//               color: Colors.amber,
//               fontWeight: FontWeight.bold,
//               fontSize: 20.0,
//             ),
//           )),
//         ),
//       )
//     ],
//   );
// }
bool color = true;

class _Student_dashboardState extends State<Student_dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white54,
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        title: Text('Attendance DashBoard'),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                showSearch(context: context, delegate: DataSearch());
              }),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            DrawerHeader(
                decoration: BoxDecoration(
                    gradient: LinearGradient(colors: <Color>[
                  Colors.deepOrange,
                  Colors.orange,
                ])),
                child: Center(
                  child: Text(
                    'COGNITRON',
                    style: TextStyle(
                      fontSize: 35.0,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                )),
          ],
        ),
      ),
      body: Container(
        margin: EdgeInsets.fromLTRB(0, 20, 2, 0),
        padding: EdgeInsets.fromLTRB(5, 2, 5, 5),
        child: GridView(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2), //for 2 items in a row
          children: names.map((title) {
            return GestureDetector(
              child: Container(
                margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                child: Card(
                  color: color ? Colors.green : Colors.red,
                  margin: const EdgeInsets.fromLTRB(0, 0, 0, 60),
                  child: getCardByTitle(title.toUpperCase()),
                ),
              ),
              onTap: () {
                setState(() {
                  color ? color = false : color = true;
                });
                  Fluttertoast.showToast(
                      msg: title + " click",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      backgroundColor: Colors.white,
                      textColor: Colors.black,
                      fontSize: 16.0);
              },
            );
          }).toList(),
        ),
      ),
    );
  }
}

Column getCardByTitle(String title) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      Container(
        margin: EdgeInsets.fromLTRB(5, 0, 0, 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(child: color ? Icon(Icons.check_box) : Icon(Icons.clear)),
            Container(
              width: 100,
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[700],
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      )
    ],
  );
}

final names = [
  "shivam",
  "supreeth",
  "manthan",
  "sambhav",
  "sanskar",
  "ragu",
  "Dhanush",
  "harsh vardhan",
  "mohit",
  "ravi",
  "hrithik",
  "salman",
  "allu arjun",
  "christy",
  "yash",
  "alia",
  "anushka sharma",
  "sumanth",
];
final recentnames = ["shivam", "sambhav", "sanskar"];

class DataSearch extends SearchDelegate<String> {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query = "";
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container(
      height: 150,
      width: 150,
      child: Card(
        color: Colors.green,
        child: Center(
          child: Text(
            query,
            style: TextStyle(
              color: Colors.white,
              fontSize: 29.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionList = query.isEmpty
        ? recentnames
        : names.where((n) => n.startsWith(query.toLowerCase())).toList();
    return ListView.builder(
      itemBuilder: (context, index) => ListTile(
        onTap: () {
          showResults(context);
        },
        leading: Icon(Icons.person),
        title: RichText(
          text: TextSpan(
              text: suggestionList[index].substring(0, query.length),
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
              children: [
                TextSpan(
                  text: suggestionList[index].substring(query.length),
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                )
              ]),
        ),
      ),
      itemCount: suggestionList.length,
    );
  }
}

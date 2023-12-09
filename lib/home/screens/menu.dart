import 'package:flutter/material.dart';
import 'package:project/home/screens/home_page.dart';
import 'package:project/home/widget/left_drawer.dart';
import 'package:project/leaderboard/screens/leaderboard_page.dart';
import 'package:project/main/screens/book_list.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 4,
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: Image.asset(
                'assets/logolong.png',  
                height: 40,             
              ),
              centerTitle: true,
          backgroundColor: Color(0xFF2C343F), 
          foregroundColor: Colors.white,
          elevation: 0,                         
          bottom: TabBar(
            unselectedLabelColor: Colors.blueGrey[500],
            labelColor: Colors.white,
            tabs: const <Widget>[
              Tab(
                icon: Icon(Icons.newspaper),
                text: "Feeds",
              ),
              Tab(
                icon: Icon(Icons.leaderboard),
                text: "Leaderboard",
              ),
              Tab(
                icon: Icon(Icons.local_library),
                text: "All Books",
              ),
              Tab(
                icon: Icon(Icons.checklist),
                text: "Readlists",
              ),
            ],
          ),
        ),
        drawer: const LeftDrawer(),
        body: TabBarView(
          children: <Widget>[

            const HomeFeedsPage(),

            const LeaderboardPage(),

            const BooksPage(),

            //Replace with Readlists Page
            ListView.builder(
              itemCount: 25,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text('$index'),
                );
              },
            ),

          ]
        ),
      )
    );
  }
}

import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => new _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> with SingleTickerProviderStateMixin {
  
  TabController profileTabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    profileTabController = new TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    profileTabController.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    
    Widget _tabBody() {
      return TabBarView(
        controller: profileTabController,
        physics: ScrollPhysics(),
        children: <Widget>[
          InformationTab(),
          HistoryTab()
        ],
      );
    }

    Widget _tabPill({String title}) {
      return Flex(
        direction: Axis.horizontal,
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Chip(
                backgroundColor: Colors.teal,
                label: Center(heightFactor: 0.0, child: Text(title)),
                labelStyle: TextStyle(color: Colors.white),
              ),
            )
          ),
        ],
      );
    }

    return new Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text("User"),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      bottomNavigationBar: new Material(
        //color: Colors.teal,
        child: new TabBar(
          controller: profileTabController,
          tabs: <Widget>[
            new Tab(
              child: _tabPill(title: "Information"),
              //text: "Information",
            ),
            new Tab(
              child: _tabPill(title: "History"),
              //text: "History",
            )
          ],
        ),
      ),
      body: _tabBody(),
    );
  }
}

//Widget for info tab
class InformationTab extends StatefulWidget {
  @override
  _InformationTabState createState() => new _InformationTabState();
}

class _InformationTabState extends State<InformationTab> {
  @override
  Widget build(BuildContext context) {

    Widget _backContent() {
      return Container(
        width: MediaQuery.of(context).size.width,
        color: Colors.red,
        height: 500.0,
        child: CircleAvatar(
          radius: 5.0,
          backgroundImage: AssetImage("assets/account_pictures/user_1.jpg"),
        ),
      );
    }

    Widget _frontContent() {
      return Container();
    }


    return SingleChildScrollView(
      child: Stack(
        children: <Widget>[
          _backContent(), _frontContent()
        ],
      ),
    );
  }
}


//Widget for history tab
class HistoryTab extends StatefulWidget {
  @override
  _HistoryTabState createState() => new _HistoryTabState();
}

class _HistoryTabState extends State<HistoryTab> {
  @override
  Widget build(BuildContext context) {
    return new Container();
  }
}
import 'package:flutter/material.dart';
import 'package:monginis_app/widgets/custom_widgets.dart';
import 'package:monginis_app/pages/home_page.dart';

class NoPage extends StatefulWidget {
  @override
  _NoPageState createState() => new _NoPageState();
}

class _NoPageState extends State<NoPage>
    with SingleTickerProviderStateMixin {
  TabController tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = new TabController(length: 1, vsync: this);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new NewAppBar(
        bgColor: Theme.of(context).scaffoldBackgroundColor,
        context: context,
      ),
      body: new TabBarView(
        controller: tabController,
        physics: ScrollPhysics(),
        children: <Widget>[
          HomePage(),
        ],
      ),
      bottomNavigationBar: new Material(
        //color: Colors.teal,
        child: new TabBar(
          controller: tabController,
          tabs: <Widget>[
            new Tab(
              icon: new Icon(Icons.store_mall_directory),
              //text: "Shop",
            ),
          ],
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:selendra_marketplace_app/screens/home/components/body.dart';
import 'package:selendra_marketplace_app/constants.dart';
import 'package:selendra_marketplace_app/screens/home/components/search.dart';
import 'package:selendra_marketplace_app/screens/cart/cart.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:selendra_marketplace_app/auth/auth_services.dart';

class HomeScreen extends StatefulWidget {

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin{

  GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();
  TabController controller;
  ScrollController scrollController;
  List<Tab> tabs = [];
  List<String> titles = ['Fruits','Vegetable','Housing','Ingredients','Crops','Lands'];

  String myEmail;
  String myName;
  String myImageUrl;

  @override
  void initState() {
    super.initState();
    controller = new TabController(vsync: this, length: 6);
    scrollController = ScrollController();
    getCurrentUser();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    scrollController.dispose();
    super.dispose();
  }

  void getCurrentUser()async {
    FirebaseAuth _auth = await FirebaseAuth.instance;
    FirebaseUser user = await _auth.currentUser();
    setState(() {
      if (user!=null){
        for (UserInfo profile in user.providerData) {
          // Id of the provider (ex: google.com)
          String providerId = profile.providerId;

          // UID specific to the provider
          String uid = profile.uid;

          print(providerId);

          // Name, email address, and profile photo Url
          myName = profile.displayName;
          myEmail = profile.email;
          myImageUrl = profile.photoUrl;

        }
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldState,
      drawer: _buildDrawer(),
      body: _buildAppBar(),
    );
  }

  Widget _buildAppBar(){
    return SafeArea(
      child: NestedScrollView(
        controller: scrollController,
        headerSliverBuilder: (BuildContext context,bool boxIsScroll){
          return <Widget>[
            SliverAppBar(
              floating: true,
              pinned: true,
              primary: true,
              centerTitle: true,
              forceElevated: boxIsScroll,
              brightness: Brightness.light,
              elevation: 0,
              backgroundColor: Colors.white,
              title: Text(
                'SELENDRA',
                style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.search,color: kDefualtColor,),
                  onPressed: (){
                    showSearch(context: context, delegate: SearchProducts());
                  },
                ),
                IconButton(
                  icon: Icon(Icons.shopping_cart,color: kDefualtColor,),
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>CartScreen()));
                  },
                ),
              ],
              leading: IconButton(
                icon: Icon(Icons.menu,color: kDefualtColor,),
                onPressed: (){
                  _scaffoldState.currentState.openDrawer();
                },
              ),
              bottom: TabBar(
                controller: controller,
                isScrollable: true,
                indicatorColor: kDefualtColor,
                unselectedLabelColor: Colors.grey,
                labelColor: kDefualtColor,
                labelStyle: TextStyle(fontSize: 14,fontWeight: FontWeight.w500),
                tabs: <Widget>[
                  Tab(text:'Fruits',),
                  Tab(text:'Vegetable',),
                  Tab(text:'Housing',),
                  Tab(text:'Ingredient',),
                  Tab(text:'Crops',),
                  Tab(text:'Lands',),
                ],
              ),
            ),
          ];
        },
        body: Body(controller),
      ),
    );
  }

  Widget _buildDrawer() {
    return SafeArea(
      child: Container(
        child: Drawer(
          child: ListView(
            children: <Widget>[
              UserAccountsDrawerHeader(
                accountName: Text('$myName'),
                accountEmail: Text('$myEmail'),
                currentAccountPicture: CircleAvatar(
                  backgroundImage: NetworkImage('$myImageUrl'),
                ),
              ),
              ListTile(
                leading: Icon(Icons.home),
                title:Text(
                  'Home',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12
                  ),
                ),
                onTap: (){
                  Navigator.pop(context);
                },
                dense: true,
                contentPadding: EdgeInsets.symmetric(vertical: 0.0,horizontal: 16.0),
              ),//Home
              ListTile(
                leading: Icon(Icons.add_circle_outline),
                title:Text(
                  'Add a Listing',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12
                  ),
                ),
                onTap: (){
                  print('Add a Listing');
                },
                dense: true,
                contentPadding: EdgeInsets.symmetric(vertical: 0.0,horizontal: 16.0),
              ),//Add a List
              Container(
                height: 2,
                margin: EdgeInsets.only(left: 20.0,right: 20.0),
                color: Colors.grey[300],
              ),
              ListTile(
                leading: Icon(Icons.shopping_basket),
                title:Text(
                  'Purchases',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12
                  ),
                ),
                onTap: (){
                  print('Purchases');
                },
                dense: true,
                contentPadding: EdgeInsets.symmetric(vertical: 0.0,horizontal: 16.0),
              ),
              ListTile(
                leading: Icon(Icons.list),
                title:Text(
                  'Listing',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12
                  ),
                ),
                onTap: (){
                  print('Listing');
                },
                dense: true,
                contentPadding: EdgeInsets.symmetric(vertical: 0.0,horizontal: 16.0),
              ),
              ListTile(
                leading: Icon(Icons.monetization_on),
                title:Text(
                  'Sales',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12
                  ),
                ),
                onTap: (){
                  print('Sales');
                },
                dense: true,
                contentPadding: EdgeInsets.symmetric(vertical: 0.0,horizontal: 16.0),
              ),
              Container(
                height: 2,
                margin: EdgeInsets.only(left: 20.0,right: 20.0),
                color: Colors.grey[300],
              ),
              ListTile(
                leading: Icon(Icons.message),
                title:Text(
                  'Messages',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12
                  ),
                ),
                onTap: (){
                  print('Messages');
                },
                dense: true,
                contentPadding: EdgeInsets.symmetric(vertical: 0.0,horizontal: 16.0),
              ),
              ListTile(
                leading: Icon(Icons.notifications),
                title:Text(
                  'Notification',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12
                  ),
                ),
                onTap: (){
                  print('Messages');
                },
                dense: true,
                contentPadding: EdgeInsets.symmetric(vertical: 0.0,horizontal: 16.0),
              ),
              ListTile(
                leading: Icon(Icons.help),
                title:Text(
                  'Help',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12
                  ),
                ),
                onTap: (){
                  print('Help');
                },
                dense: true,
                contentPadding: EdgeInsets.symmetric(vertical: 0.0,horizontal: 16.0),
              ),
              ListTile(
                leading: Icon(Icons.input),
                title:Text(
                  'Sign Out',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12
                  ),
                ),
                onTap: (){
                  signOut(context);
                },
                dense: true,
                contentPadding: EdgeInsets.symmetric(vertical: 0.0,horizontal: 16.0),
              ),
            ],
          ),
        ),
      ),
    );
  }


}

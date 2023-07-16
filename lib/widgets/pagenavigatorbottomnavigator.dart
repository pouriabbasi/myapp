import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../models/globalvar.dart';
import '../page/allproductofalluserpage.dart';
import '../page/homepage.dart';
import '../page/setting.dart';

List page=[
  HomePage(),
  AllProductOfAllUserPage(),
  SettingPage(),
];
late Widget iconNavigationBarItem;

class PageNavigatorBottomNavigator extends StatefulWidget {
  const PageNavigatorBottomNavigator({Key? key}) : super(key: key);

  @override
  _PageNavigatorBottomNavigatorState createState() => _PageNavigatorBottomNavigatorState();
}

class _PageNavigatorBottomNavigatorState extends State<PageNavigatorBottomNavigator> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // if(userRoll=='Common'){
    //   setState(() {
    //     iconNavigationBarItem=Icon(Icons.settings);
    //   });
    // }else{
    //   setState(() {
    //     iconNavigationBarItem=Icon(Icons.admin_panel_settings_sharp);
    //   });
    // }

    // if(userRoll=='Common'){
    //   // page.remove(page.last);
    //   setState(() {
    //     page.add(
    //         SettingPage()
    //     );
    //   });
    // }else{
    //   setState(() {
    //     page.add(
    //         AdminPage()
    //     );
    //   });
    // }
  }

  int index=0;

  var _scaffoldKay=GlobalKey<ScaffoldState>();
  
  @override
  Widget build(BuildContext context) {
    // final arge = ModalRoute.of(context).settings.arguments ;
    final size=MediaQuery.of(context).size;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        key: _scaffoldKay,
        drawer: ClipRRect(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(180)),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  blue,
                  lightBlue,
                  deepBlue,
                ]
              )
            ),
            width: 50,
            child: ListView(
              children: [
              IconButton(
                      onPressed: (){
                        Navigator.of(context).pushNamed('/ShowUserPage');
                      },
                      padding: EdgeInsets.all(10),
                  icon: Icon(Icons.person,color: white,),
                  ),
                userRoll=='Admin'?
                IconButton(
                  onPressed: ()=>Navigator.of(context).pushNamed('/AdminPage'),
                  padding: EdgeInsets.all(10),
                  icon: Icon(Icons.admin_panel_settings_sharp,color: white,),
                ) :
                    Container(),
                IconButton(
                      onPressed: (){
                        Navigator.of(context).pushNamed('/SearchPage',);
                      },
                      padding: EdgeInsets.symmetric(vertical: 10),
                    icon: Icon(Icons.search,color: white,),
                  ),
                IconButton(
                  onPressed: (){
                    FirebaseAuth.instance.signOut().then((_) => Navigator.of(context).pushReplacementNamed('/LoginPage'));
                  },
                  icon: Icon(Icons.login_outlined,color: white,),
                  padding:  EdgeInsets.all(10),
                ),
              ],
            ),
          ),
        ),
        backgroundColor: Colors.grey[900],
        body: Stack(
          children: [
            Container(
              color: blue,
            ),
            Positioned(
              top: 60,
              left: 0.0,
              right: 0.0,
              bottom: 0.0,
              child: page[index],
            ),
            Positioned(
                right: 10,
                top: 20,
                child: IconButton(
                  icon: const Icon(
                    Icons.menu,
                    color: Colors.white,
                  ),
                  onPressed: () =>  _scaffoldKay.currentState!.openDrawer(),
                )),
            Positioned(
                right: size.width - 50,
                top: 20,
                child: IconButton(
                  onPressed: (){},
                  icon: const Icon(
                    Icons.shopping_cart,
                    color: Colors.white,
                    size: 30,
                  ),
                )
            )
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          unselectedItemColor: Colors.white,
          selectedItemColor: lightBlue,
          backgroundColor: deepBlue,
          elevation: 0.0,
          iconSize: 25.0,
          selectedIconTheme: IconThemeData(size: 35),
          currentIndex: index,
          onTap: (int a){
            setState(() {
              index=a;
            });
            page[index];
          },
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home,),
              label:'Home',
            ),
            BottomNavigationBarItem(icon: Icon(Icons.article,),
                label:'Product'
            ),
            BottomNavigationBarItem(
                icon: Icon( Icons.settings
                ) ,
                label: 'Settings')
          ]
        ),
      ),
    );
  }
}
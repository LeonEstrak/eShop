import 'package:flutter/material.dart';
import 'package:shopwork/home/merchantPages/MerchantPageHome.dart';
import 'package:shopwork/home/merchantPages/MerchantPageProfile.dart';

class MerchantHome extends StatefulWidget {
  @override
  _MerchantHomeState createState() => _MerchantHomeState();
}

class _MerchantHomeState extends State<MerchantHome> {

  final PageController _controller = PageController(keepPage: true);

  int selectedIndex = 0;

  //TODO:Create a Floating Action Button center in the center which adds items to the list

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      appBar: AppBar(
//        title: Text("Home",style: TextStyle(color: Colors.black87),),
//        backgroundColor: Colors.white70,
//      ),
      body: _buildPageView(),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildBottomNavigationBar(){
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(
          icon:Icon(Icons.home),
          title: Text("Home"),
        ),
        BottomNavigationBarItem(
            icon: Icon(Icons.person),
            title: Text("Profile")
        )
      ],
      onTap: (index){
        setState(() {
          selectedIndex = index;
          _controller.animateToPage(index, duration: Duration(milliseconds: 500), curve: Curves.ease);
        });
      },
      currentIndex: selectedIndex,
    );
  }


  Widget _buildPageView(){
    return PageView(
      controller: _controller,
      onPageChanged: (index){
        setState(() {
          selectedIndex = index;
        });
      },
      children: <Widget>[
        MerchantPageHome(),
        MerchantPageProfile()
      ],
    );
  }

}

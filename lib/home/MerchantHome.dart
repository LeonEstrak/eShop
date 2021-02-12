import 'package:flutter/material.dart';
import 'package:shopwork/home/merchantPages/AddCard.dart';
import 'package:shopwork/home/merchantPages/MerchantPageHome.dart';
import 'package:shopwork/home/merchantPages/MerchantPageProfile.dart';

class MerchantHome extends StatefulWidget {
  @override
  _MerchantHomeState createState() => _MerchantHomeState();
}

class _MerchantHomeState extends State<MerchantHome> {

  final PageController _controller = PageController(keepPage: true);

  int selectedIndex = 0;

//  String itemName; int itemQty; double itemPrice;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildPageView(),
      bottomNavigationBar: _buildBottomNavigationBar(),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: (){
            setState(() {
              showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
                  builder: (context) => AddCard(),
              );
//              Navigator.pushNamed(context, "/AddCard");
              MerchantPageHome.setCounter(MerchantPageHome.getCounter()+1);
            });
          }
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
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

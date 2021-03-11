import 'package:flutter/material.dart';
import 'package:shopwork/home/merchantPages/AddCard.dart';
import 'package:shopwork/home/merchantPages/MerchantPageHome.dart';
import 'package:shopwork/home/merchantPages/MerchantPageProfile.dart';
import 'package:shopwork/home/merchantPages/Orders.dart';

///
/// ## Merchant Home
/// This is the home page for a Merchant user type. The body of the Scaffold is a build PageView
/// function, swiping the body of the Scaffold changes the page, so does the use of the bottom
/// Navigation Bar. The bottom Navigation bar is persistent over the changing body pages.
/// Floating Action Button being a part of the MerchantHome Scaffold is also persistent over
/// the changing pages `yet`
/// Pressing the floating action button causes a Modal sheet to extend up requesting info for
/// appending a new item to the GridView list.
///
/// Look up [PageView] on flutter docs
///
class MerchantHome extends StatefulWidget {
  @override
  _MerchantHomeState createState() => _MerchantHomeState();
}

/// Email ID: merchant@gmail.com
/// Password: merchant
class _MerchantHomeState extends State<MerchantHome> {
  final PageController _controller = PageController(keepPage: true);

  ///Specifies the current selection of the Bottom Navigation Bar.
  ///Default set to the first page i.e at the 0th position.
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   elevation: 0,
      //   iconTheme: IconThemeData(color: Colors.black87),
      //   backgroundColor: Colors.transparent,
      //   centerTitle: true,
      //   title: Text(
      //     "Shop",
      //     style: TextStyle(
      //       fontSize: 30,
      //       color: Colors.black87,
      //       fontWeight: FontWeight.bold,
      //     ),
      //   ),
      // ),
      drawer: Drawer(
        child: MerchantPageProfile(),
      ),
      body: _buildPageView(),
      bottomNavigationBar: _buildBottomNavigationBar(),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            setState(() {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(30))),
                builder: (context) => AddCard(),
              );
            });
          }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget _buildBottomNavigationBar() {
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          title: Text("Home"),
        ),
        BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart), title: Text("Orders")),
      ],
      onTap: (index) {
        setState(() {
          selectedIndex = index;
          _controller.animateToPage(index,
              duration: Duration(milliseconds: 500), curve: Curves.ease);
        });
      },
      currentIndex: selectedIndex,
    );
  }

  Widget _buildPageView() {
    return PageView(
      controller: _controller,
      onPageChanged: (index) {
        setState(() {
          selectedIndex = index;
        });
      },
      children: <Widget>[MerchantPageHome(), Orders()],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:shopwork/home/customerPages/BottomPaymentSheet.dart';
import 'package:shopwork/home/customerPages/CustomerCartPage.dart';
import 'package:shopwork/home/customerPages/CustomerHomePage.dart';
import 'package:shopwork/home/customerPages/CustomerProfilePage.dart';

class CustomerHome extends StatefulWidget {
  @override
  _CustomerHomeState createState() => _CustomerHomeState();
}

///Email ID: customer@gmail.com
///Password: customer

class _CustomerHomeState extends State<CustomerHome> {
  final PageController _controller = PageController(keepPage: true);

  ///Specifies the current selection of the Bottom Navigation Bar.
  ///Default set to the first page i.e at the 0th position.
  int selectedIndex = 0;

  conditionallyShowBottomSheet() {
    if (selectedIndex == 1) return BottomPaymentSheet();
    return Container(
      height: 0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomerProfilePage(),
      body: _buildPageView(),
      bottomSheet: AnimatedContainer(
        height:
            selectedIndex == 0 ? 0 : MediaQuery.of(context).size.height / 12,
        duration: Duration(seconds: 1),
        curve: Curves.easeOutCubic,
        child: BottomPaymentSheet(),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
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
      children: <Widget>[CustomerHomePage(), CustomerCartPage()],
    );
  }

  Widget _buildBottomNavigationBar() {
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: "Home",
        ),
        BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: "Cart"),
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
}

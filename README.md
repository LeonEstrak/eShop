[![Build Status](https://www.travis-ci.com/LeonEstrak/eShop.svg?branch=master)](https://www.travis-ci.com/LeonEstrak/eShop)

# eShop

A shopping application created for small-time shop owners who would like to sell their products to the local people.

**Featrues:**
- A custom login and registration page
- Two Different User Interfaces which depends on whether the user is a Merchant or Customer
- All Users can upload a profile picture
- Merchants can Name their shop, and may modify it at any point of time.
- All Merchants can keep track of their Inventory directly through the Application
- All Customers can view Merchants Inventory and place orders on the basis of it
- Once items have been added to cart by the user, the user can see the total amount at the bottom of the screen
- Once orders have been placed by the Customer, the Merchant can view the placed orders in his application along with the neccessary details of the customer such as name, address and profile picture(if uploaded by customer)

**Codebase:**
- Flutter has been used to develop the front-end Application
- Firebase has been used for the backend of the application along with Firestore as the NoSQL database paradigm
- All items related operation are CRUD compliant
- Travis has been setup for automatic build checks

# Usage 

To run this project setting up of an android-sdk environment is a prerequisite. It can done by using **sdkmanager** cmd-line tool or downloading of Android Studio which will assist in downloading the necessary utilities such as platform-tools, build-tools, platforms. Refer https://developer.android.com/studio

After setting up of android-sdk environment, setting up of flutter-sdk environment is necessary.
Refer https://flutter.dev/docs/get-started/install

After complete setup of the development environment, clone this repository into your machine and run

    flutter pub get

Now you may open the project in your desired editor or IDE and run the project using

    flutter run

# Future Scope

- [X] Cache All Incoming Images to reduce data consumption and item load times
- [ ] Integrate Google OAuth
- [ ] Implement testing and Automate it with Travis
- [ ] Improve UI for Item viewing page
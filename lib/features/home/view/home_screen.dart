import 'package:e_commerce/features/home/sensitive_pay_data.dart';
import 'package:e_commerce/features/home/view/search/search_screen.dart';
import 'package:e_commerce/features/home/widget/category_list.dart';
import 'package:flutter/material.dart';
import 'package:pay_with_paymob/pay_with_paymob.dart';
import '../../auth/logic/model/user_data.dart';
import '../widget/custom_product_list.dart';
import '../widget/custom_search_field.dart';

class HomeScreen extends StatefulWidget {
  final UserDataModel model;

  const HomeScreen({
    super.key,
    required this.model,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController searchController = TextEditingController();

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    PaymentData.initialize(
      apiKey: SensitivePayData.apiKey,
      iframeId: SensitivePayData.iframeId,
      integrationCardId: SensitivePayData.integrationCardId,
      integrationMobileWalletId: SensitivePayData.integrationMobileWalletId,

      userData: UserData(
        email: widget.model.email, // Optional: Defaults to 'NA'
        name: widget.model.name, // Optional: Defaults to 'NA'
      ),

      // Optional Style Customizations
      style: Style(
        primaryColor: Colors.blueAccent,
        scaffoldColor: Colors.white,
        appBarBackgroundColor: Colors.blueAccent,
        appBarForegroundColor: Colors.white,
        textStyle: TextStyle(),
        buttonStyle: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(horizontal: 40, vertical: 16),
            foregroundColor: Colors.white,
            backgroundColor: Colors.blueAccent,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20))),
        circleProgressColor: Colors.blueAccent,
        unselectedColor: Colors.grey,
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column(
            children: [
              CustomSearchField(
                onPressed: () {
                  if (searchController.text.isNotEmpty) {
                    String query = searchController.text;
                    searchController.clear();

                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SearchScreen(
                            query: query,
                          ),
                        ));
                  }
                },
                controller: searchController,
              ),
              SizedBox(
                height: 10,
              ),
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(
                        "assets/images/ecom.gif",
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "Popular",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 25),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 100,
                        child: CategoryList(),
                      ),
                      Text(
                        "Recently Products",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 22),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      CustomProductList()
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

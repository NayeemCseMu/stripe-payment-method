import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payment_method_stripe/module/dashboard/controller/controller.dart';
import 'package:payment_method_stripe/service/payment_service.dart';
// import 'package:progress_dialog/progress_dialog.dart';

class HomePage extends StatefulWidget {
  static final String routeName = "/home";

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  late Controller _controller;
  onItemPress(BuildContext context, int index) async {
    switch (index) {
      case 0:
        payViaNewCard(context);
        break;
      case 1:
        // Navigator.pushNamed(context, '/existing-cards');
        break;
    }
  }

  payViaNewCard(BuildContext context) async {
    var response = await _controller.paymentController();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(response.message!),
        duration:
            new Duration(milliseconds: response.success == true ? 1200 : 3000),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    PaymentService.instance.init();
    _controller = Get.put(Controller());
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Obx(
        () => Container(
          height: MediaQuery.of(context).size.height * 0.5,
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Expanded(child: ListView.separated(
                  itemBuilder: (context, index) {
                    Icon? icon;
                    Text? text;

                    switch (index) {
                      case 0:
                        icon =
                            Icon(Icons.add_circle, color: theme.primaryColor);
                        text = Text('Pay via new card');
                        break;
                      case 1:
                        icon =
                            Icon(Icons.credit_card, color: theme.primaryColor);
                        text = Text('Pay via existing card');
                        break;
                    }

                    return InkWell(
                      onTap: () {
                        onItemPress(context, index);
                      },
                      child: ListTile(
                        title: text!,
                        leading: icon!,
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => Divider(
                    color: theme.primaryColor,
                  ),
                  itemCount: 2),),
              if (_controller.isLoading.value) CircularProgressIndicator(),
            ],
          ),
        ),
      ),
    );
    // ;
  }
}

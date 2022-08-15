import 'package:flutter/material.dart';

class OptionsScreen extends StatefulWidget {
  const OptionsScreen({Key? key}) : super(key: key);

  @override
  State<OptionsScreen> createState() => _OptionsScreenState();
}

class _OptionsScreenState extends State<OptionsScreen> {
  int tabIndex = 0;

  TextEditingController productCon = TextEditingController();
  TextEditingController descriptCon = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: const Color(0xFF006FAF),
        leading: IconButton(
          onPressed: () {
            //pop to previous screen
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
      ),
      backgroundColor: const Color(0xFF006FAF),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 10.0,
        ),
        child: Column(
          children: [
            Row(
              children: [
                GestureDetector(
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: Text(
                      'Orders',
                      style: TextStyle(
                        fontSize: 20.0,
                        color: tabIndex == 0
                            ? const Color(0xFFFFFFFF)
                            : const Color(0xFF80B7D7),
                      ),
                    ),
                  ),
                  onTap: () {
                    if (tabIndex == 0) {
                      return;
                    }
                    setState(() {
                      tabIndex = 0;
                    });
                  },
                ),
                GestureDetector(
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: Text(
                      'Request',
                      style: TextStyle(
                        fontSize: 20.0,
                        color: tabIndex == 1
                            ? const Color(0xFFFFFFFF)
                            : const Color(0xFF80B7D7),
                      ),
                    ),
                  ),
                  onTap: () {
                    if (tabIndex == 1) {
                      return;
                    }
                    setState(() {
                      tabIndex = 1;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 10.0),
            tabIndex == 0 ? orderTab() : requestsTab(),
          ],
        ),
      ),
    );
  }

  Widget requestsTab() {
    return Expanded(
      child: GestureDetector(
        child: Column(
          children: [
            TextField(
              controller: productCon,
              style: const TextStyle(
                fontSize: 17.0,
                color: Colors.white,
              ),
              decoration: const InputDecoration(
                filled: true,
                fillColor: Color(0xFF80B7D7),
                hintText: 'Product',
                hintStyle: TextStyle(
                  color: Color(0xFF006FAF),
                  fontSize: 18.0,
                ),
                enabledBorder: InputBorder.none,
              ),
            ),
            const SizedBox(height: 5.0),
            TextField(
              controller: descriptCon,
              style: const TextStyle(
                fontSize: 17.0,
                color: Colors.white,
              ),
              decoration: const InputDecoration(
                filled: true,
                fillColor: Color(0xFF80B7D7),
                hintText: 'Description...',
                hintStyle: TextStyle(
                  color: Color(0xFF006FAF),
                  fontSize: 18.0,
                ),
                enabledBorder: InputBorder.none,
              ),
            ),
            const Spacer(),
            GestureDetector(
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 10.0),
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                width: 100.0,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: const Center(
                  child: Text(
                    'Send',
                    style: TextStyle(
                      color: Color(0xFF006FAF),
                    ),
                  ),
                ),
              ),
              onTap: () {
                // send request logic
              },
            ),
          ],
        ),
        onTap: () {
          FocusScope.of(context).unfocus();
        },
      ),
    );
  }

  Widget orderTab() {
    return const Expanded(
      child: Center(
        child: Text(
          'Order disappears after being picked',
          style: TextStyle(
            color: Colors.white,
            fontSize: 14.0,
          ),
        ),
      ),
    );
  }
}

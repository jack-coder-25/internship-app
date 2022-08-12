import 'package:flutter/material.dart';

class ReferralsPage extends StatefulWidget {
  const ReferralsPage({Key? key}) : super(key: key);

  @override
  State<ReferralsPage> createState() => _ReferralsPageState();
}

class _ReferralsPageState extends State<ReferralsPage> {
  String dropdownvalue = 'All';
  var items = ['All', 'Paid', 'Unpaid'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Your Referrals",
          style: TextStyle(fontSize: 18, color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0.0,
        leading: BackButton(
          color: Colors.black,
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "No Referrals found",
                  style: TextStyle(fontSize: 18),
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.red, width: 1.0),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(3.0, 2.0, 3.0, 2.0),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton(
                          elevation: 0,
                          value: dropdownvalue,
                          icon: const Icon(Icons.arrow_drop_down),
                          isDense: true,
                          items: items.map((String items) {
                            return DropdownMenuItem(
                              value: items,
                              child: Text(
                                items,
                                style: const TextStyle(
                                  fontSize: 18,
                                  color: Colors.black,
                                ),
                              ),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              dropdownvalue = newValue!;
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 435),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(10, 40),
                    textStyle: const TextStyle(fontSize: 18),
                    primary: Colors.orange,
                    onPrimary: Colors.white,
                  ),
                  onPressed: () {},
                  child: const Text("Refer your Friend"),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

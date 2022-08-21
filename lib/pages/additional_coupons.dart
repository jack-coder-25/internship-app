import 'package:app/constants/colors.dart';
import 'package:app/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dialogs/flutter_dialogs.dart';
import 'package:provider/provider.dart';

class AdditionalCouponsPage extends StatefulWidget {
  const AdditionalCouponsPage({Key? key}) : super(key: key);

  @override
  State<AdditionalCouponsPage> createState() => _AdditionalCouponsPageState();
}

class _AdditionalCouponsPageState extends State<AdditionalCouponsPage> {
  UserObject? user;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      user = context.watch<UserObject?>();
      setState(() {});

      if (user?.profile?.data?.subscription == null) {
        Navigator.pushReplacementNamed(context, '/subscription');
      }
    });
  }

  final List<Tab> tabs = <Tab>[
    const Tab(text: 'Other Coupons'),
    const Tab(text: 'Vendor Coupons'),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
          title: const Text('Additional coupons'),
          leading: BackButton(
            onPressed: () => Navigator.pop(context),
          ),
          bottom: TabBar(
            unselectedLabelColor: Colors.white.withOpacity(0.3),
            indicatorColor: Colors.white,
            tabs: tabs,
          ),
        ),
        body: const TabBarView(
          children: <Widget>[
            OtherCouponsGrid(),
            VendorCouponsGrid(),
          ],
        ),
      ),
    );
  }
}

void _showConfirmationAlert(BuildContext context) {
  showPlatformDialog(
    context: context,
    builder: (_) => BasicDialogAlert(
      title: const Text(
        "Vendor Coupon",
        textAlign: TextAlign.center,
      ),
      content: SizedBox(
        height: 350.0,
        width: 380.0,
        child: Column(
          children: [
            const Icon(
              Icons.euro,
              size: 80.0,
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text("Vendor"),
                Text("WELLINGTON PLAZA"),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text("Service"),
                Text("CLUB"),
              ],
            ),
            const SizedBox(height: 10),
            const Text(
              "Coupon Validity Period",
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text("From Date"),
                Text("2021-11-12"),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text("To Date"),
                Text("2023-11-12"),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text("Coupon"),
                Text("ZT9ZAA5GK"),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text("Coupon Amount"),
                Text(
                  "₹5",
                  style: TextStyle(
                    color: Colors.green,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text("Buy Amount"),
                Text(
                  "₹1",
                  style: TextStyle(
                    color: Colors.green,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
      actions: <Widget>[
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              primary: Colors.white,
            ),
            child: const Text(
              "Cancel",
              style: TextStyle(
                color: ColorConstants.red,
              ),
            ),
          ),
        ),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              primary: ColorConstants.red,
            ),
            child: const Text("Buy"),
          ),
        ),
      ],
    ),
  );
}

class OtherCouponsGrid extends StatelessWidget {
  const OtherCouponsGrid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white30,
      child: GridView.count(
        crossAxisCount: 2,
        childAspectRatio: 0.95,
        padding: const EdgeInsets.all(4.0),
        mainAxisSpacing: 16.0,
        crossAxisSpacing: 4.0,
        children: <String>[
          'https://tse3.mm.bing.net/th?id=OIP.G7XrM7DhByJRg2Z-Z3zSkAHaE7&pid=Api&P=0',
          'https://www.gannett-cdn.com/-mm-/05b227ad5b8ad4e9dcb53af4f31d7fbdb7fa901b/c=0-64-2119-1259/local/-/media/USATODAY/USATODAY/2014/08/13/1407953244000-177513283.jpg?width=2119&height=1195&fit=crop&format=pjpg&auto=webp',
          'https://media.architecturaldigest.com/photos/57e42deafe422b3e29b7e790/master/pass/JW_LosCabos_2015_MainExterior.jpg',
          'https://media.cntraveler.com/photos/57d864b9b77fe35639ae1a55/master/pass/Pool-HardRockHotelGoa-India-CRHotel.jpg',
          'https://static.wixstatic.com/media/4ca580_7b34df5c048745379053beed7f2916e6~mv2_d_2492_1669_s_2.jpg/v1/fill/w_2492,h_1669,al_c/4ca580_7b34df5c048745379053beed7f2916e6~mv2_d_2492_1669_s_2.jpg',
          'https://www.losinj-hotels.com/assets/Bellevue/Gallery/bellevue-hotel-2.jpg',
        ].map((String url) {
          return GridTile(
            child: Column(
              children: [
                Image.network(
                  height: 140.0,
                  url,
                  fit: BoxFit.cover,
                ),
                const SizedBox(height: 5),
                const Text("Vendor Coupon"),
                ElevatedButton(
                  onPressed: () {
                    _showConfirmationAlert(context);
                  },
                  style: TextButton.styleFrom(
                    primary: Colors.white,
                    backgroundColor: Colors.red,
                  ),
                  child: const Text(
                    'ZT977BZAQV ',
                    style: TextStyle(fontSize: 24),
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}

class VendorCouponsGrid extends StatelessWidget {
  const VendorCouponsGrid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white30,
      child: GridView.count(
        crossAxisCount: 2,
        childAspectRatio: 0.95,
        padding: const EdgeInsets.all(4.0),
        mainAxisSpacing: 16.0,
        crossAxisSpacing: 4.0,
        children: <String>[
          'https://tse3.mm.bing.net/th?id=OIP.G7XrM7DhByJRg2Z-Z3zSkAHaE7&pid=Api&P=0',
          'https://www.gannett-cdn.com/-mm-/05b227ad5b8ad4e9dcb53af4f31d7fbdb7fa901b/c=0-64-2119-1259/local/-/media/USATODAY/USATODAY/2014/08/13/1407953244000-177513283.jpg?width=2119&height=1195&fit=crop&format=pjpg&auto=webp',
          'https://media.architecturaldigest.com/photos/57e42deafe422b3e29b7e790/master/pass/JW_LosCabos_2015_MainExterior.jpg',
          'https://media.cntraveler.com/photos/57d864b9b77fe35639ae1a55/master/pass/Pool-HardRockHotelGoa-India-CRHotel.jpg',
          'https://static.wixstatic.com/media/4ca580_7b34df5c048745379053beed7f2916e6~mv2_d_2492_1669_s_2.jpg/v1/fill/w_2492,h_1669,al_c/4ca580_7b34df5c048745379053beed7f2916e6~mv2_d_2492_1669_s_2.jpg',
          'https://www.losinj-hotels.com/assets/Bellevue/Gallery/bellevue-hotel-2.jpg',
        ].map((String url) {
          return GridTile(
            child: Column(
              children: [
                Image.network(
                  height: 140.0,
                  url,
                  fit: BoxFit.cover,
                ),
                const SizedBox(height: 5),
                const Text("Vendor Coupon"),
                ElevatedButton(
                  onPressed: () {
                    _showConfirmationAlert(context);
                  },
                  style: TextButton.styleFrom(
                    primary: Colors.white,
                    backgroundColor: Colors.red,
                  ),
                  child: const Text(
                    'ZT977BZAQV ',
                    style: TextStyle(fontSize: 24),
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}

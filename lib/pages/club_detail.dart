import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class ClubDetailPage extends StatefulWidget {
  const ClubDetailPage({Key? key}) : super(key: key);

  @override
  State<ClubDetailPage> createState() => _ClubDetailPageState();
}

class _ClubDetailPageState extends State<ClubDetailPage> {
  final controller = PageController();
  bool isLastPage = false;

  YoutubePlayerController youtubePlayerController = YoutubePlayerController(
    initialVideoId: 'LXb3EKWsInQ',
    flags: const YoutubePlayerFlags(
      autoPlay: false,
      mute: true,
    ),
  );

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  height: 220.0,
                  child: PageView(
                    controller: controller,
                    onPageChanged: (index) {
                      setState(() => isLastPage = index == 5);
                    },
                    children: [
                      Center(
                        child: Image.asset(
                          "assets/images/2a880090-a0e0-4a81-baf5-a4575db0c91a.jpg",
                          width: double.infinity,
                          height: 220.0,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Center(
                        child: Image.asset(
                          "assets/images/009a652c-def4-489b-b2e6-00a6b080311b.jpg",
                          width: double.infinity,
                          height: 220.0,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Center(
                        child: Image.asset(
                          "assets/images/48651f50-b91c-41ff-b571-3fad35a65222.jpg",
                          width: double.infinity,
                          height: 220.0,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Center(
                        child: Image.asset(
                          "assets/images/a819e8b4-0d2a-4f51-8274-c8155e34abf7.jpg",
                          width: double.infinity,
                          height: 220.0,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 15,
                  child: SmoothPageIndicator(
                    controller: controller,
                    count: 4,
                    effect: const WormEffect(
                      activeDotColor: Color.fromARGB(255, 255, 0, 0),
                      dotColor: Colors.black,
                      spacing: 16,
                    ),
                    onDotClicked: ((index) => controller.animateToPage(
                          index,
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeIn,
                        )),
                  ),
                ),
                Positioned(
                  top: 15,
                  left: 0,
                  child: BackButton(
                    color: Colors.white,
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                "Our Services",
                textAlign: TextAlign.left,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            GridView.count(
              crossAxisCount: 3,
              childAspectRatio: 0.95,
              mainAxisSpacing: 10,
              padding: const EdgeInsets.all(16.0),
              crossAxisSpacing: 4.0,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              children: <String>[
                'https://tse3.mm.bing.net/th?id=OIP.G7XrM7DhByJRg2Z-Z3zSkAHaE7&pid=Api&P=0',
                'https://www.gannett-cdn.com/-mm-/05b227ad5b8ad4e9dcb53af4f31d7fbdb7fa901b/c=0-64-2119-1259/local/-/media/USATODAY/USATODAY/2014/08/13/1407953244000-177513283.jpg?width=2119&height=1195&fit=crop&format=pjpg&auto=webp',
                'https://media.architecturaldigest.com/photos/57e42deafe422b3e29b7e790/master/pass/JW_LosCabos_2015_MainExterior.jpg',
                'https://media.cntraveler.com/photos/57d864b9b77fe35639ae1a55/master/pass/Pool-HardRockHotelGoa-India-CRHotel.jpg',
              ].map((String url) {
                return GridTile(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/club-service-detail');
                    },
                    child: Column(
                      children: [
                        Image.network(
                          height: 130.0,
                          url,
                          fit: BoxFit.cover,
                          loadingBuilder: ((
                            context,
                            child,
                            loadingProgress,
                          ) {
                            if (loadingProgress == null) return child;
                            return Container(color: Colors.grey);
                          }),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 10.0),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                "Video",
                textAlign: TextAlign.left,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            YoutubePlayer(
              controller: youtubePlayerController,
              showVideoProgressIndicator: true,
              progressColors: const ProgressBarColors(
                playedColor: Colors.red,
                handleColor: Colors.red,
              ),
            ),
            const SizedBox(height: 10.0),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                "Contact Us",
                textAlign: TextAlign.left,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 10.0),
            Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    "Phone",
                    textAlign: TextAlign.left,
                  ),
                  Text(
                    "+919790985285",
                    textAlign: TextAlign.right,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    "Email",
                    textAlign: TextAlign.left,
                  ),
                  Text(
                    "customercare@bvcindia.com",
                    textAlign: TextAlign.right,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    "Address",
                    textAlign: TextAlign.left,
                  ),
                  Text(
                    "No 781, Rayala Towers, 2nd Floor, \n Anna Salai, Mount Road, Chennai - 600002 \n (Opposite Rageja Towers & LIC Building)",
                    textAlign: TextAlign.right,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

import 'package:mci/pages/club_service_detail.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:mci/constants/colors.dart';
import 'package:mci/constants/constants.dart';
import 'package:mci/models/user.dart';
import 'package:mci/models/vendor.dart';
import 'package:mci/utils/api_service.dart';
import 'package:mci/utils/authentication_service.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class ClubDetailPageArguments {
  String vendorId;

  ClubDetailPageArguments({
    required this.vendorId,
  });
}

class ClubDetailPage extends StatefulWidget {
  const ClubDetailPage({Key? key}) : super(key: key);

  @override
  State<ClubDetailPage> createState() => _ClubDetailPageState();
}

class _ClubDetailPageState extends State<ClubDetailPage> {
  ClubDetailPageArguments? args;
  YoutubePlayerController? youtubePlayerController;
  final controller = PageController();
  bool isLastPage = false;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (args == null && args?.vendorId == null) {
        var modalRoute = ModalRoute.of(context);
        args = modalRoute?.settings.arguments as ClubDetailPageArguments;
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    youtubePlayerController?.dispose();
    super.dispose();
  }

  Widget loadingSpinner() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const [
          CircularProgressIndicator(
            color: ColorConstants.red,
          ),
        ],
      ),
    );
  }

  Widget errorScreen(String? error) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(error ?? "Something went wrong"),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Future<UserObject?> getUser() async {
      AuthenticationService authService = context.read<AuthenticationService>();
      return (await authService.getUser());
    }

    return Scaffold(
      body: FutureBuilder<UserObject?>(
        future: getUser(),
        builder: ((context, userSnapshot) {
          if (userSnapshot.hasData) {
            return FutureBuilder<VendorDetailResponse>(
              future: ApiService.instance.getVendorDetails(
                userSnapshot.data!.authToken,
                args!.vendorId,
              ),
              builder: ((context, snapshot) {
                Widget children;

                if (snapshot.hasData) {
                  var slides = snapshot.data!.data!.slides!;

                  if (snapshot.data?.data?.video != null) {
                    youtubePlayerController = YoutubePlayerController(
                      initialVideoId: YoutubePlayer.convertUrlToId(
                        snapshot.data!.data!.video!,
                      )!,
                      flags: const YoutubePlayerFlags(
                        autoPlay: false,
                        mute: true,
                      ),
                    );
                  }

                  children = SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            SizedBox(
                              height: 220.0,
                              child: slides.isNotEmpty
                                  ? PageView(
                                      controller: controller,
                                      onPageChanged: (index) {
                                        setState(() {
                                          isLastPage =
                                              index == slides.length - 1;
                                        });
                                      },
                                      children: slides
                                          .map(
                                            (slide) => Center(
                                              child: Image.network(
                                                "${ApiConstants.uploadsPath}/${slide.image}",
                                                width: double.infinity,
                                                height: 220.0,
                                                fit: BoxFit.cover,
                                                errorBuilder: (((
                                                  context,
                                                  error,
                                                  stackTrace,
                                                ) {
                                                  return const Center(
                                                    child: Text(
                                                      'Cannot Load Image',
                                                    ),
                                                  );
                                                })),
                                                loadingBuilder: ((
                                                  context,
                                                  child,
                                                  loadingProgress,
                                                ) {
                                                  if (loadingProgress == null) {
                                                    return child;
                                                  }
                                                  return Container(
                                                    color: Colors.grey,
                                                  );
                                                }),
                                              ),
                                            ),
                                          )
                                          .toList(),
                                    )
                                  : null,
                            ),
                            Positioned(
                              bottom: 15,
                              child: SmoothPageIndicator(
                                controller: controller,
                                count: slides.length,
                                effect: const WormEffect(
                                  activeDotColor: Color.fromARGB(
                                    255,
                                    255,
                                    0,
                                    0,
                                  ),
                                  dotColor: Colors.black,
                                  spacing: 16,
                                ),
                                onDotClicked: ((index) =>
                                    controller.animateToPage(
                                      index,
                                      duration: const Duration(
                                        milliseconds: 500,
                                      ),
                                      curve: Curves.easeIn,
                                    )),
                              ),
                            ),
                            Positioned(
                              top: 20,
                              left: 0,
                              child: BackButton(
                                color: Colors.white,
                                onPressed: () => Navigator.pop(context),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              child: snapshot.data!.data!.mapLink != null
                                  ? Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: InkWell(
                                        onTap: () async {
                                          await launchUrl(
                                            Uri.parse(
                                              snapshot.data!.data!.mapLink!,
                                            ),
                                          );
                                        },
                                        child: const Icon(
                                          Icons.location_on,
                                          size: 32,
                                        ),
                                      ),
                                    )
                                  : null,
                            )
                          ],
                        ),
                        Container(
                          child: snapshot.data!.data!.categories!.isNotEmpty
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.all(16.0),
                                      child: Text(
                                        "Our Services",
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    GridView.count(
                                      crossAxisCount: 3,
                                      childAspectRatio: 0.95,
                                      mainAxisSpacing: 10,
                                      padding: const EdgeInsets.all(16.0),
                                      crossAxisSpacing: 4.0,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      children: snapshot.data!.data!.categories!
                                          .map((category) => GridTile(
                                                child: GestureDetector(
                                                  onTap: () {
                                                    Navigator.pushNamed(
                                                      context,
                                                      '/club-service-detail',
                                                      arguments:
                                                          ClubServicesDetailPageArguments(
                                                        vendorCategoryId:
                                                            category.id!,
                                                      ),
                                                    );
                                                  },
                                                  child: Column(
                                                    children: [
                                                      Image.network(
                                                        height: 130.0,
                                                        "${ApiConstants.uploadsPath}/${category.image}",
                                                        fit: BoxFit.cover,
                                                        loadingBuilder: ((
                                                          context,
                                                          child,
                                                          loadingProgress,
                                                        ) {
                                                          if (loadingProgress ==
                                                              null) {
                                                            return child;
                                                          }
                                                          return Container(
                                                            height: 130.0,
                                                            color: Colors.grey,
                                                          );
                                                        }),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ))
                                          .toList(),
                                    ),
                                  ],
                                )
                              : null,
                        ),
                        Container(
                          child: youtubePlayerController != null
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(height: 10.0),
                                    const Padding(
                                      padding: EdgeInsets.all(16.0),
                                      child: Text(
                                        "Video",
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    YoutubePlayer(
                                      controller: youtubePlayerController!,
                                      showVideoProgressIndicator: true,
                                      progressColors: const ProgressBarColors(
                                        playedColor: Colors.red,
                                        handleColor: Colors.red,
                                      ),
                                    ),
                                  ],
                                )
                              : null,
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
                          padding: const EdgeInsets.only(
                            left: 16.0,
                            right: 16.0,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Phone",
                                textAlign: TextAlign.left,
                              ),
                              Text(
                                snapshot.data?.data?.phone ?? '-',
                                textAlign: TextAlign.right,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 16.0,
                            right: 16.0,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Email",
                                textAlign: TextAlign.left,
                              ),
                              Text(
                                snapshot.data?.data?.email ?? '-',
                                textAlign: TextAlign.right,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 16.0,
                            right: 16.0,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Address",
                                textAlign: TextAlign.left,
                              ),
                              Flexible(
                                child: Text(
                                  snapshot.data!.data!.address!,
                                  overflow: TextOverflow.clip,
                                  textAlign: TextAlign.right,
                                  style: const TextStyle(
                                    fontSize: 15.0,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  );
                } else if (snapshot.hasError) {
                  children = errorScreen(snapshot.error.toString());
                } else {
                  children = loadingSpinner();
                }

                return Container(child: children);
              }),
            );
          } else if (userSnapshot.hasError) {
            return errorScreen(userSnapshot.error.toString());
          } else {
            return loadingSpinner();
          }
        }),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class SubscriptionPage extends StatefulWidget {
  const SubscriptionPage({Key? key}) : super(key: key);

  @override
  State<SubscriptionPage> createState() => _SubscriptionPageState();
}

class _SubscriptionPageState extends State<SubscriptionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Subscription Page"),
        backgroundColor: const Color.fromARGB(255, 255, 0, 0),
        leading: const BackButton(
          color: Color.fromARGB(255, 251, 240, 240),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16.0, 30.0, 16.0, 0),
          child: Column(
            children: [
              Card(
                color: Colors.grey,
                clipBehavior: Clip.antiAlias,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Ink.image(
                      image: const AssetImage(
                        'assets/images/2a880090-a0e0-4a81-baf5-a4575db0c91a.jpg',
                      ),
                      colorFilter: ColorFilter.mode(
                        Colors.black.withOpacity(0.6),
                        BlendMode.dstATop,
                      ),
                      height: 180,
                      fit: BoxFit.fill,
                      child: InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, '/subscription-detail');
                        },
                      ),
                    ),
                    const Text(
                      'MCI BUSSINESS',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(212, 255, 253, 253),
                        fontSize: 24,
                        shadows: <Shadow>[
                          Shadow(
                            offset: Offset(10.0, 10.0),
                            blurRadius: 8.0,
                            color: Color.fromARGB(255, 72, 33, 33),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Card(
                color: Colors.grey,
                clipBehavior: Clip.antiAlias,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    Ink.image(
                      image: const AssetImage(
                        'assets/images/79c4bc85-9afe-494e-9af2-8fc51a0eaf6a.jpg',
                      ),
                      colorFilter: ColorFilter.mode(
                        Colors.black.withOpacity(0.6),
                        BlendMode.dstATop,
                      ),
                      height: 180,
                      fit: BoxFit.fill,
                      child: InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, '/subscription-detail');
                        },
                      ),
                    ),
                    const Text(
                      'MCI DIAMOND',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(211, 251, 251, 251),
                        fontSize: 24,
                        shadows: <Shadow>[
                          Shadow(
                            offset: Offset(10.0, 10.0),
                            blurRadius: 8.0,
                            color: Color.fromARGB(255, 72, 33, 33),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Card(
                color: Colors.grey,
                clipBehavior: Clip.antiAlias,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Ink.image(
                      image: const AssetImage(
                        'assets/images/a109b8fb-194f-4bb7-9fb4-5a62210341f9.jpg',
                      ),
                      colorFilter: ColorFilter.mode(
                        Colors.black.withOpacity(0.6),
                        BlendMode.dstATop,
                      ),
                      height: 180,
                      fit: BoxFit.fill,
                      child: InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, '/subscription-detail');
                        },
                      ),
                    ),
                    const Text(
                      'MCI PLATINUM',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 255, 254, 254),
                        fontSize: 24,
                        shadows: <Shadow>[
                          Shadow(
                            offset: Offset(10.0, 10.0),
                            blurRadius: 8.0,
                            color: Color.fromARGB(255, 72, 33, 33),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Card(
                color: Colors.grey,
                clipBehavior: Clip.antiAlias,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Ink.image(
                      image: const AssetImage(
                        'assets/images/168ef967-9f54-4e55-961c-699d3d514178.jpg',
                      ),
                      colorFilter: ColorFilter.mode(
                        Colors.black.withOpacity(0.6),
                        BlendMode.dstATop,
                      ),
                      height: 180,
                      fit: BoxFit.fill,
                      child: InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, '/subscription-detail');
                        },
                      ),
                    ),
                    const Text(
                      'MCI ELITE',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(212, 255, 255, 255),
                        fontSize: 24,
                        shadows: <Shadow>[
                          Shadow(
                            offset: Offset(10.0, 10.0),
                            blurRadius: 8.0,
                            color: Color.fromARGB(255, 72, 33, 33),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Card(
                color: Colors.grey,
                clipBehavior: Clip.antiAlias,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Ink.image(
                      image: const AssetImage(
                        'assets/images/524f92e3-ab90-45ef-96e6-9df9cd6bbf62.jpg',
                      ),
                      colorFilter: ColorFilter.mode(
                        Colors.black.withOpacity(0.6),
                        BlendMode.dstATop,
                      ),
                      height: 180,
                      fit: BoxFit.fill,
                      child: InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, '/subscription-detail');
                        },
                      ),
                    ),
                    const Text(
                      'MCI SIGNATURE',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(212, 246, 245, 245),
                        fontSize: 24,
                        shadows: <Shadow>[
                          Shadow(
                            offset: Offset(10.0, 10.0),
                            blurRadius: 8.0,
                            color: Color.fromARGB(255, 72, 33, 33),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Card(
                color: Colors.grey,
                clipBehavior: Clip.antiAlias,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Ink.image(
                      image: const AssetImage(
                        'assets/images/48651f50-b91c-41ff-b571-3fad35a65222.jpg',
                      ),
                      colorFilter: ColorFilter.mode(
                        Colors.black.withOpacity(0.6),
                        BlendMode.dstATop,
                      ),
                      height: 180,
                      fit: BoxFit.fill,
                      child: InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, '/subscription-detail');
                        },
                      ),
                    ),
                    const Text(
                      'MCI AMBASSADOR',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(212, 255, 253, 253),
                        fontSize: 24,
                        shadows: <Shadow>[
                          Shadow(
                            offset: Offset(10.0, 10.0),
                            blurRadius: 8.0,
                            color: Color.fromARGB(255, 72, 33, 33),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Card(
                color: Colors.grey,
                clipBehavior: Clip.antiAlias,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Ink.image(
                      image: const AssetImage(
                        'assets/images/48651f50-b91c-41ff-b571-3fad35a65222.jpg',
                      ),
                      colorFilter: ColorFilter.mode(
                        Colors.black.withOpacity(0.6),
                        BlendMode.dstATop,
                      ),
                      height: 180,
                      fit: BoxFit.fill,
                      child: InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, '/subscription-detail');
                        },
                      ),
                    ),
                    const Text(
                      'SAMPLE TEST',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(212, 255, 253, 253),
                        fontSize: 24,
                        shadows: <Shadow>[
                          Shadow(
                            offset: Offset(10.0, 10.0),
                            blurRadius: 8.0,
                            color: Color.fromARGB(255, 72, 33, 33),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

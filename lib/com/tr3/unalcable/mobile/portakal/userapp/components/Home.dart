import 'package:flutter/material.dart';
import 'package:portakal_mobile_user_app/com/tr3/unalcable/mobile/portakal/models/NotificationModel.dart';
import 'package:portakal_mobile_user_app/com/tr3/unalcable/mobile/portakal/stores/NotificationStore.dart';
import 'package:portakal_mobile_user_app/com/tr3/unalcable/mobile/portakal/userapp/components/NotificationCardComp.dart';
import 'package:portakal_mobile_user_app/com/tr3/unalcable/mobile/portakal/userapp/services/RestApiService.dart';
import 'package:portakal_mobile_user_app/com/tr3/unalcable/mobile/portakal/userapp/services/TokenService.dart';

class Home extends StatefulWidget {
  const Home({super.key, required this.title});

  final String title;

  @override
  State<Home> createState() => _Home();
}

class _Home extends State<Home> with WidgetsBindingObserver {
  get child => null;
  List<dynamic> notificationData = List.empty(growable: true);

  @override
  void initState() {
    notificationStore.subscribe(notificationHandler);
    super.initState();
    _fetchNotifications();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  void notificationHandler(NotificationModel notification) {
    setState(() {
      notificationData.add(notification);
      notificationData.sort((a, b) {
        // Timestamp değerlerini kullanarak sıralama yap
        var aTimestamp = a.date ?? 0;
        var bTimestamp = b.date ?? 0;
        return bTimestamp.compareTo(aTimestamp);
      });
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.resumed) {
      RestApiService restApiService = RestApiService();
      TokenService tokenService = await TokenService.getInstance();
      var newData = await restApiService.get(
          "/mobile/user-app/notifications?startDate=${notificationData.first.date + 1000}&endDate=${DateTime.now().millisecondsSinceEpoch}");

      setState(() {
        newData.forEach((item) {
          NotificationModel notification = NotificationModel(
              item['message'] ?? "",
              item['title'] ?? "",
              item['date'] ?? "",
              item['notificationType'] ?? "");
          notificationStore.add(notification);
        });
      });
    } else if (state == AppLifecycleState.paused) {
      // Uygulama arka plana alındığında burası çalışır.
    }
  }

  void _fetchNotifications() async {
    RestApiService restApiService = RestApiService();
    TokenService tokenService = await TokenService.getInstance();
    var newData = await restApiService.get(
        "/mobile/user-app/notifications?startDate=${DateTime.now().subtract(Duration(days: 365)).millisecondsSinceEpoch}");

    setState(() {
      notificationData.clear(); // Eski verileri temizle
      newData.forEach((item) {
        NotificationModel notification = NotificationModel(
            item['message'] ?? "",
            item['title'] ?? "",
            item['date'] ?? "",
            item['notificationType'] ?? "");

        notificationStore.add(notification);
        notificationData.sort((a, b) {
          var aTimestamp = a.date ?? 0;
          var bTimestamp = b.date ?? 0;
          return bTimestamp.compareTo(aTimestamp);
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: DefaultTabController(
      length: 4,
      child: Scaffold(
          appBar: AppBar(
            titleSpacing: MediaQuery.of(context).size.width / 20,
            automaticallyImplyLeading: false,
            centerTitle: true,
            backgroundColor: Color(0xFFF9A826),
            toolbarHeight: MediaQuery.of(context).size.height / 6,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                    top: Radius.zero, bottom: Radius.circular(30))),
            title: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    const Text(
                      "Merhaba, Osman",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 4,
                    ),
                    const Icon(
                      Icons.person,
                      size: 50,
                    ),
                  ],
                ),
                const Row(
                  children: [
                    Text(
                      "Bildirimleri Aşağıdan Görebilirsin",
                      style: TextStyle(fontSize: 15),
                    ),
                  ],
                ),
              ],
            ),
            bottom: TabBar(
              labelColor: Colors.white,
              indicatorColor: Colors.transparent,
              dividerColor: Colors.transparent,
              padding: EdgeInsets.only(bottom: 7 , left: 7),
              isScrollable: true,
              tabAlignment: TabAlignment.start,
              labelPadding: EdgeInsets.all(5),
              tabs: [
                Tab(
                    child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: Color(0xFFFF5C00)),
                        child: const Row(
                          children: [
                            Padding(padding: EdgeInsets.only(left: 5 , right: 0) , child:  Icon(Icons.menu)),
                           
                            Align(
                              alignment: Alignment.center,
                              child: Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Text(
                                  "Hepsi",
                                ),
                              ),
                            ),
                          ],
                        ))),
                Tab(
                    child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Color(0xFF21283F)),
                  child: const Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Text("Örnek"),
                    ),

                  ),
                )),
                Tab(
                    child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Color(0xFF21283F)),
                  child: const Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text("Örnek1"),
                    ),
                  ),
                )),
                Tab(
                    child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Color(0xFF21283F)),
                  child: const Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text("Örnek2"),
                    ),
                  ),
                )),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              ListView.builder(
                itemCount: notificationData.length,
                itemBuilder: (context, index) {
                  return NotificationCardComp(
                      notification: notificationData[index]);
                },
              ),
              Icon(Icons.directions_transit),
              Icon(Icons.directions_bike),
               Icon(Icons.directions_bike),
            ],
          )

          // This trailing comma makes auto-formatting nicer for build methods.
          ),
    ));
  }
}

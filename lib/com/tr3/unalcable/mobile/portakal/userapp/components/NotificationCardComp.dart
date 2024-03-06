import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:portakal_mobile_user_app/com/tr3/unalcable/mobile/portakal/models/NotificationModel.dart';

class NotificationCardComp extends StatelessWidget {
  final NotificationModel notification;

  NotificationCardComp({Key? key, required this.notification})
      : super(key: key);

  String stripHtmlTags(String htmlText) {
    RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);
    return htmlText.replaceAll(exp, '');
  }

  var formatter = DateFormat('dd/MM/yyyy');

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40.0),
        color: Colors.red,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Stack(
        
        children: [
         
          ListTile(
            dense: false,
            isThreeLine: false,
            contentPadding: EdgeInsets.all(0),
            leading: Container(
              width: MediaQuery.of(context).size.width / 3,
              child: const Column(children: [
                 Align(
                    alignment: AlignmentDirectional.center,
                    child: Icon(
                      Icons.notifications,
                      size: 20,
                    ),
                  ),
              ],)
            ),
            title: Padding(
              padding: const EdgeInsets.only(right: 45),
              child: Text(
                notification.title,
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 15),
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 7),
                Text(
                  stripHtmlTags(notification.message),
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
                const SizedBox(height: 7),
                Container(
                  alignment: AlignmentDirectional.bottomEnd,
                  padding: EdgeInsets.only(right: 15),
                  child: Text(
                    formatter.format(
                        DateTime.fromMillisecondsSinceEpoch(notification.date)),
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
            onTap: () {
              print("Notification Tapped: ${notification.message}");
            },
          ),
          Positioned(
            top: 10.0,
            right: 18.0,
            child: Container(
              padding: EdgeInsets.all(4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.white.withOpacity(0.8),
              ),
              child: Text(
                "örnek",
                style: TextStyle(color: Colors.black, fontSize: 12),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

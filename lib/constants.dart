import 'package:flutter/material.dart';

const kSendButtonTextStyle = TextStyle(
  color: Colors.lightBlueAccent,
  fontWeight: FontWeight.bold,
  fontSize: 18.0,
);

const kMessageTextFieldDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  hintText: 'Type your message here...',
  border: InputBorder.none,
);

const kMessageContainerDecoration = BoxDecoration(
  border: Border(
    top: BorderSide(color: Colors.lightBlueAccent, width: 2.0),
  ),
);


AppBar buildAppBar(String city, String group) {
  return AppBar(
    backgroundColor: Colors.transparent,
    elevation: 0,
    flexibleSpace: Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromARGB(255, 176, 106, 231),
            Color.fromARGB(255, 166, 112, 231),
            Color.fromARGB(255, 131, 123, 231),
            Color.fromARGB(255, 104, 132, 231),
          ],
          transform: GradientRotation(90),
        ),
      ),
    ),
    title: Container(
      padding: EdgeInsets.only(top: 0, bottom: 0, right: 0),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.only(top: 0, bottom: 0, right: 0),
            child: InkWell(
              child: SizedBox(
                  height: 44,
                  width: 44,
                  child: CircleAvatar(
                    radius: 22,
                  )
              ),
            ),
          ),
          SizedBox(
            width: 15,
          ),
          Container(
            width: 180,
            padding: EdgeInsets.only(top: 0, bottom: 0, right: 0),
            child: Row(children: [
              SizedBox(
                width: 180,
                height: 44,
                child: GestureDetector(
                  onTap: () {},
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        group,
                        overflow: TextOverflow.clip,
                        maxLines: 1,
                        style: TextStyle(
                          fontFamily: 'Avenir',
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        city,
                        overflow: TextOverflow.clip,
                        maxLines: 1,
                        style: TextStyle(
                          fontFamily: 'Avenir',
                          fontWeight: FontWeight.normal,
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontSize: 14,
                        ),
                      )
                    ],
                  ),
                ),
              )
            ]),
          )
        ],
      ),
    ),
  );
}

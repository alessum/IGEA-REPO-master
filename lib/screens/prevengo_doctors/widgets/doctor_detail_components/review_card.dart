import 'package:flutter/material.dart';
import 'package:igea_app/models/review.dart';

class DoctorReviewCard extends StatelessWidget {
  const DoctorReviewCard({
    Key key,
    @required this.review,
  }) : super(key: key);

  final Review review;

  @override
  Widget build(BuildContext context) {
    Size media = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(25))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ListTile(
            leading: Image.asset(
              'assets/icons/user.png',
              width: media.height * .04,
            ),
            contentPadding: EdgeInsets.zero,
            horizontalTitleGap: 0,
            title: Text(
              review.username,
              style: TextStyle(fontFamily: 'Book', fontSize: media.width * .05),
            ),
          ),
          Container(
            width: media.width * .8,
            child: Text(
              review.title,
              style:
                  TextStyle(fontFamily: 'Gotham', fontSize: media.width * .05),
            ),
          ),
          Container(
            height: media.height * .04,
            width: media.width * .27,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) => Icon(
                Icons.star_rate_rounded,
                color:
                    index < review.rating ? Colors.black87 : Colors.grey[400],
                size: media.width * .055,
              ),
              physics: NeverScrollableScrollPhysics(),
              itemCount: 5,
            ),
          ),
          Container(
            width: media.width * .8,
            child: Text(
              review.message,
              style: TextStyle(fontFamily: 'Book', fontSize: media.width * .04),
            ),
          ),
        ],
      ),
    );
  }
}

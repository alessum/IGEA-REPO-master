import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:igea_app/blocs/prevengo_doctors/bloc_doctor_detail.dart';
import 'package:igea_app/models/doctor.dart';
import 'package:igea_app/models/review.dart';
import 'package:igea_app/screens/prevengo_doctors/widgets/doctor_detail_components/address_row.dart';
import 'package:igea_app/screens/prevengo_doctors/widgets/doctor_detail_components/contact_pill.dart';
import 'package:igea_app/screens/prevengo_doctors/widgets/doctor_detail_components/doctor_header.dart';
import 'package:igea_app/screens/prevengo_doctors/widgets/doctor_detail_components/medical_service_pill.dart';
import 'package:igea_app/screens/prevengo_doctors/widgets/doctor_detail_components/review_card.dart';
import 'package:igea_app/screens/prevengo_doctors/widgets/doctor_detail_components/visit_pill.dart';
import 'package:igea_app/screens/prevengo_doctors/GMaps.dart';

class DoctorDetailScreen extends StatefulWidget {
  const DoctorDetailScreen({Key key}) : super(key: key);

  @override
  _DoctorDetailScreenState createState() => _DoctorDetailScreenState();
}

class _DoctorDetailScreenState extends State<DoctorDetailScreen> {
  DoctorDetailBloc bloc;

  @override
  Widget build(BuildContext context) {
    Size media = MediaQuery.of(context).size;
    bloc = DoctorDetailBlocProvider.of(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black87,
          ),
        ),
        title: Text(
          'I nostri medici',
          style: TextStyle(
            fontFamily: 'Gotham',
            fontSize: media.width * .08,
            color: Colors.black87,
          ),
        ),
      ),
      body: Align(
        alignment: Alignment.bottomCenter,
        child: SingleChildScrollView(
          child: StreamBuilder<Doctor>(
            stream: bloc.getDoctorDetails,
            builder: (context, snapshot) => snapshot.hasData
                ? Container(
                    width: media.width,
                    decoration: BoxDecoration(
                        color: Colors.blueGrey[50],
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(media.width * .2))),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        DoctorHeader(
                          doctorName: snapshot.data.name,
                          doctorSpecialization: snapshot.data.specialization,
                        ),
                        SizedBox(height: media.height * .03),
                        ContactPill(
                          contact: snapshot.data.phoneNumber,
                          contactIcon: Icon(
                            Icons.phone,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: media.height * .01),
                        ContactPill(
                          contact: snapshot.data.email,
                          contactIcon: Icon(
                            Icons.mail,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: media.height * .02),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: media.width * .05),
                          child: VisitPill(),
                        ),
                        SizedBox(height: media.height * .03),
                        DoctorAddressRow(
                          address: snapshot.data.address,
                        ),
                        SizedBox(height: media.height * .02),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => GMaps(doctor: snapshot.data)),
                            );
                          },
                          child: Container(
                            height: 150,
                            margin: EdgeInsets.symmetric(horizontal: 20),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(25)),
                              image: DecorationImage(
                                image: NetworkImage(
                                    'https://ichi.pro/assets/images/max/724/1*UzmjsSZkY4m7S_nBXMC9AQ.png'),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: media.height * .02),
                        Container(
                          padding: EdgeInsets.all(13),
                          margin: EdgeInsets.symmetric(
                              horizontal: media.width * .05),
                          decoration: BoxDecoration(
                            color: Colors.lightBlue[100],
                            borderRadius: BorderRadius.all(Radius.circular(50)),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Curriculum Vitae',
                                style: TextStyle(
                                  fontSize: media.width * .04,
                                  fontFamily: 'Book',
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(5),
                                width: media.width * .25,
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(25)),
                                  border: Border.all(
                                      color: Colors.black87, width: 1.5),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Text('Scarica'),
                                    Icon(
                                      Icons.keyboard_arrow_down_sharp,
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(height: media.height * .02),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: media.width * .07),
                          child: Text(
                            'Prestazioni offerte',
                            style: TextStyle(
                              fontSize: media.width * .05,
                              fontFamily: 'Book',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(height: media.height * .01),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: media.width * .06),
                          child: Wrap(
                            direction: Axis.horizontal,
                            spacing: 10,
                            runSpacing: 5,
                            children: (() {
                              List<Widget> medicalServicePills = [];
                              snapshot.data.medicalServices.forEach((element) {
                                medicalServicePills.add(MedicalServicePill(
                                    medicalService: element));
                              });
                              return medicalServicePills;
                            }()),
                          ),
                        ),
                        SizedBox(height: media.height * .02),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: media.width * .07),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Recensioni',
                            style: TextStyle(
                              fontSize: media.width * .05,
                              fontFamily: 'Book',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(height: media.height * .01),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: media.width * .06),
                          alignment: Alignment.centerLeft,
                          child: StreamBuilder<List<Review>>(
                            stream: bloc.getReviews,
                            builder: (context, snapshot) => snapshot.hasData
                                ? ListView.separated(
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) =>
                                        DoctorReviewCard(
                                      review: snapshot.data[index],
                                    ),
                                    itemCount: snapshot.data.length,
                                    separatorBuilder: (context, _) => SizedBox(
                                      height: media.height * .01,
                                    ),
                                  )
                                : CircularProgressIndicator(),
                          ),
                        ),
                      ],
                    ),
                  )
                : Center(child: CircularProgressIndicator()),
          ),
        ),
      ),
    );
  }
}

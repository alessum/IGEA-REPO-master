import 'package:flutter/material.dart';
import 'package:igea_app/blocs/prevengo_doctors/bloc_doctor_detail.dart';
import 'package:igea_app/blocs/prevengo_doctors/bloc_doctor_list.dart';
import 'package:igea_app/models/doctor.dart';
import 'package:igea_app/models/medical_service.dart';
import 'package:igea_app/screens/prevengo_doctors/doctor_detail.dart';
import 'package:igea_app/screens/prevengo_doctors/widgets/doctor_card.dart';

class DoctorsProposedScreen extends StatefulWidget {
  const DoctorsProposedScreen({key}) : super(key: key);

  @override
  _DoctorsScreenState createState() => _DoctorsScreenState();
}

class _DoctorsScreenState extends State<DoctorsProposedScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _typeAheadController = TextEditingController();

  DoctorListBloc bloc;

  @override
  Widget build(BuildContext context) {
    Size media = MediaQuery.of(context).size;
    bloc = DoctorListBlocProvider.of(context);
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
      body: Container(
        padding: EdgeInsets.all(13),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(20, 5, 20, 0),
              // margin: EdgeInsets.symmetric(horizontal: media.width * 0.04),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(25)),
                color: Colors.blueGrey[50],
                // border: Border.all(width: .05),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Form(
                    key: this._formKey,
                    child: Container(
                      width: media.width * .7,
                      margin: EdgeInsets.all(0),
                      child: TextField(
                        controller: _typeAheadController,
                        onChanged: (value) => null,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.zero,
                          border: InputBorder.none,
                          labelText: "Cerca un medico o specializzazione",
                          labelStyle: TextStyle(fontSize: media.width * .035),
                        ),
                      ),
                    ),
                  ),
                  Icon(
                    Icons.close,
                    size: media.width * 0.05,
                    color: Colors.black87,
                  ),
                  // StreamBuilder<bool>(
                  //     stream: bloc.getFilterIcon,
                  //     builder: (context, snapshot) {
                  //       return GestureDetector(
                  //         onTap: () {
                  //           this._formKey.currentState.save();
                  //           if (snapshot.hasData) {
                  //             if (snapshot.data) {
                  //               bloc.resetFilter();
                  //               this._typeAheadController.text = '';
                  //             }
                  //           }
                  //           bloc.updateFilterIcon.add(
                  //               snapshot.hasData ? !snapshot.data : false);
                  //         },
                  //         child: StreamBuilder<bool>(
                  //             stream: bloc.getFilterIcon,
                  //             builder: (context, snapshot) {
                  //               return Icon(
                  //                 snapshot.hasData
                  //                     ? snapshot.data
                  //                         ? Icons.close
                  //                         : Icons.search
                  //                     : Icons.search,
                  //                 size: media.width * 0.07,
                  //               );
                  //             }),
                  //       );
                  //     })
                ],
              ),
            ),
            Container(
              height: media.height * .7,
              child: StreamBuilder<Map<String, Doctor>>(
                stream: bloc.getDoctorList,
                builder: (context, snapshot) => snapshot.hasData
                    ? ListView.separated(
                        itemBuilder: (context, index) => DoctorCard(
                          doctor: snapshot
                              .data[snapshot.data.keys.elementAt(index)],
                          ontap: (value) => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DoctorDetailBlocProvider(
                                doctorKey: snapshot.data.keys.elementAt(index),
                                child: DoctorDetailScreen(),
                              ),
                            ),
                          ),
                        ),
                        separatorBuilder: (context, _) => SizedBox(
                          height: 10,
                        ),
                        itemCount: snapshot.data.length,
                      )
                    : Center(
                        child: CircularProgressIndicator(),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

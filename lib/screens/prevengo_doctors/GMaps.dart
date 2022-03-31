import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:igea_app/models/doctor.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GMaps extends StatefulWidget {
  final Doctor doctor;
  GMaps({Key key, this.doctor}) : super(key: key);

  @override
  _GMapsState createState() => _GMapsState();

}

class _GMapsState extends State<GMaps> {

  Doctor _doctor;
  final LatLng _center = const LatLng(45.187764, 9.1558951);
  final Map<String, Marker> _markers = {};

  Future<void> _onMapCreated(GoogleMapController controller) async {
    _doctor = widget.doctor;

    setState(() {
      _markers.clear();
      Marker marker = Marker(
        markerId: MarkerId(_doctor.name),
        position: LatLng(45.19816783788422,9.17795986540285), //todo: replaces with real coordinates
        infoWindow: InfoWindow(
          title: _doctor.name + ", " + _doctor.clinicName,
          snippet: _doctor.address,
        )
      );
      _markers[_doctor.clinicName] = marker;
    });
  }

 @override
  Widget build(BuildContext context) {
    Size media = MediaQuery.of(context).size;
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
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: _center,
          zoom: 11.0,
        ),
        markers: _markers.values.toSet(),
      ),
    );
  }
}

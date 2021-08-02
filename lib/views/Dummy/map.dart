import 'package:flutter/material.dart';
import 'package:flutter_application_3/views/Dummy/directions.dart';
import 'package:flutter_application_3/views/Dummy/path.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Mapscreen extends StatefulWidget {


  @override
  _MapscreenState createState() => _MapscreenState();
}

class _MapscreenState extends State<Mapscreen> {
  GoogleMapController googleMapController;
  Marker origin;
  Marker destination;
  PathDir info;
  static const camerapos=CameraPosition(target: LatLng(37.773972, -122.431297),
  zoom: 11.5,);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(onPressed: ()=>googleMapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: destination.position,zoom: 14.5,tilt: 50.0))), child: Text('Destination',style: TextStyle(color: Colors.white),)),
          TextButton(onPressed: ()=>googleMapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: origin.position,zoom: 15.4,tilt: 50.0))), child: Text('Origin',style: TextStyle(color: Colors.white),))
        ],
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          GoogleMap(
            myLocationButtonEnabled: false,
            myLocationEnabled: false,
            initialCameraPosition: camerapos,
            onMapCreated: (controller)=>googleMapController=controller,
            markers: {
              if(origin !=null) origin,
              if(destination!=null) destination,
            },
            polylines: {
              if(info !=null)
                Polyline(polylineId: const PolylineId('overview_polyline'),
                  color: Colors.red,
                  width: 5,
                  points: info.polylinePoints.map((e) => LatLng(e.longitude, e.latitude)).toList(),
                )
            },
            onLongPress: _addmarker,


          ),
          if(info!=null)
            Positioned(
              top: 20.0,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 6.0,horizontal: 12.0),
                decoration: BoxDecoration(
                  color: Colors.yellowAccent,
                  borderRadius: BorderRadius.circular(20.0),
                  boxShadow: [BoxShadow(
                    color: Colors.black26,
                    offset: Offset(0,2),
                    blurRadius: 6.0,
                  )]
                ),
                child: Text(
                  '${info.totalDistance},${info.totalDuration}',
                  style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600),

                ),
              ),
            )
        ],
      ),
          floatingActionButton: FloatingActionButton(
            onPressed: (){
              googleMapController.animateCamera(info!=null?CameraUpdate.newLatLngBounds(info.bounds, 100):CameraUpdate.newCameraPosition(camerapos),
              );
            },
            child: Icon(Icons.center_focus_strong_outlined),
          ),
    );
  }
  void _addmarker(LatLng pos)async{
    if(origin == null || (origin != null && destination !=null)){
      setState(() {
        origin = Marker(
          markerId:  const MarkerId('origin'),
          infoWindow:  const InfoWindow(title: 'Origin'),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
          position: pos,
        );
        destination=null;
        info=null;

      });

    } else{
      setState(() {
        destination=Marker(
          markerId: const MarkerId('destination'),
          infoWindow: const InfoWindow(title: 'Destination'),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
          position: pos,
        );
      });
      final directions =await Direction()
      .getpath(origin: origin.position, destination: destination.position);
      setState(()=>info=directions);
    }
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:iconsax/iconsax.dart';
import 'package:ride_share/common/widgets/list_tiles/payment_tile.dart';
import 'package:ride_share/common/widgets/search/search_bar.dart';
import 'package:ride_share/common/widgets/search/search_container.dart';
import 'package:ride_share/features/ride_share/screens/select_address_screen/widget/bottom_drawer.dart';
import 'package:ride_share/utils/constants/colors.dart';
import 'package:ride_share/utils/constants/sizes.dart';
import '../../../../common/widgets/clipper/handle_notch_clipper.dart';
import '../../cubit/location/location_cubit.dart';

class SelectAddressScreen extends StatefulWidget {
  const SelectAddressScreen({super.key});

  @override
  State<SelectAddressScreen> createState() => _SelectAddressScreenState();
}

class _SelectAddressScreenState extends State<SelectAddressScreen> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocationCubit, LocationState>(
      builder: (context, state) {
        LatLng? userLocation;

        if (state is LocationSuccess && state is! LocationLoading) {
          final address = state;
          // Assuming you've parsed and stored the lat/lng
          userLocation = LatLng(address.latitude, address.longitude);
        }

        return Stack(
          children: [
            // Full-Screen Google Map
            Positioned.fill(
              child: GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: userLocation ?? const LatLng(0.0, 0.0),
                  zoom: 16,
                ),
                myLocationEnabled: true,
                zoomControlsEnabled: false,
                mapType: MapType.normal,
                markers:
                    userLocation != null
                        ? {
                          Marker(
                            markerId: const MarkerId('user-location'),
                            position: userLocation,
                          ),
                        }
                        : {},
              ),
            ),

            Positioned(
              top: 30,
              left: 20,
              child: Container(
                width: 50,
                height: 50,
                padding: EdgeInsets.only(left: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: Colors.white,
                ),
                child: IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.black,
                    size: 20,
                  ),
                ),
              ),
            ),
            // Bottom Sheet with cutout notch
            BottomDrawer(),
          ],
        );
      },
    );
  }
}

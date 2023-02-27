import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/common/constants/handle_status.enum.dart';
import 'package:mobile/modules/map/bottom_sheet_bloc/map_bottom_sheet.bloc.dart';
import 'package:mobile/modules/map/bottom_sheet_bloc/map_bottom_sheet.state.dart';

class MapBottomSheetView extends StatelessWidget {
  const MapBottomSheetView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => MapBottomsheetBloc(),
      child: BlocListener<MapBottomsheetBloc, MapBottomsheetState>(
        listener: (context, state) {},
        child: const _MapBottomSheetView(),
      ),
    );
  }
}

class _MapBottomSheetView extends StatelessWidget {
  const _MapBottomSheetView();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MapBottomsheetBloc, MapBottomsheetState>(
      builder: (context, state) => DraggableScrollableSheet(
        initialChildSize: 0.4,
        minChildSize: 0.2,
        maxChildSize: 0.75,
        expand: false,
        builder: (context, scrollController) => Column(
          children: [
            Icon(
              Icons.remove,
              color: Colors.grey[600],
            ),
            Container(
              child: state.status == HandleStatus.loading
                  ? Container(
                      padding: const EdgeInsets.only(top: 50),
                      alignment: Alignment.center,
                      child: const CircularProgressIndicator(),
                    )
                  : Expanded(
                      child: ListView.separated(
                        controller: scrollController,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) => ListTile(
                          title: Text('Item $index'),
                        ),
                        separatorBuilder: (context, index) => const Divider(),
                        itemCount: 100,
                      ),
                    ),
            )
          ],
        ),
      ),
    );
  }
}

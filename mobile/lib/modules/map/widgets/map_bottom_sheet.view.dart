import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/common/constants/handle_status.enum.dart';
import 'package:mobile/modules/map/bloc/bottom_sheet_bloc/map_bottom_sheet.bloc.dart';
import 'package:mobile/modules/map/widgets/bottom_sheet_header.widget.dart';

class CampaignBottomSheet extends StatelessWidget {
  const CampaignBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MapBottomsheetBloc, MapBottomsheetState>(
      builder: (context, state) {
        return DraggableScrollableSheet(
          initialChildSize: 0.4,
          minChildSize: 0.2,
          maxChildSize: 0.8,
          expand: false,
          builder: (context, scrollController) {
            return CustomScrollView(
              physics: const ClampingScrollPhysics(),
              controller: scrollController,
              slivers: [
                SliverFillRemaining(
                  fillOverscroll: true,
                  child: Column(
                    children: [
                      const BottomSheetHeader(),
                      Container(
                        child: state.status == HandleStatus.loading
                            ? Container(
                                padding: const EdgeInsets.only(top: 50),
                                alignment: Alignment.center,
                                child: const CircularProgressIndicator(),
                              )
                            : Expanded(
                                child: ListView.separated(
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) => ListTile(
                                    title: Text('Item $index'),
                                  ),
                                  separatorBuilder: (context, index) =>
                                      const Divider(),
                                  itemCount: 100,
                                ),
                              ),
                      ),
                    ],
                  ),
                )
              ],
            );
          },
        );
      },
    );
  }
}

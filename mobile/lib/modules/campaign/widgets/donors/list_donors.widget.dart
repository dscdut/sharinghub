import 'package:flutter/material.dart';
import 'package:mobile/data/models/user.model.dart';
import 'package:mobile/modules/campaign/widgets/donors/item_donor.widget.dart';

class ListDonorsWidget extends StatelessWidget {
  const ListDonorsWidget({
    super.key,
    required this.users,
  });

  final List<UserModel> users;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (context, index) => ItemDonorWidget(
        user: users[index],
      ),
      separatorBuilder: (context, index) => const Divider(
        height: 10,
        color: Colors.transparent,
      ),
      itemCount: users.length,
    );
  }
}

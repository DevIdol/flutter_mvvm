import 'package:flutter/material.dart';

import '../../../provider/provider.dart';
import '../../../utils/utils.dart';
import '../../../widgets/widgets.dart';

class ProfileImageSection extends StatelessWidget {
  final UserUpsertState state;
  final UserUpsertViewModel viewModel;
  final BuildContext context;

  const ProfileImageSection({
    super.key,
    required this.state,
    required this.viewModel,
    required this.context,
  });

  @override
  Widget build(BuildContext context) {
    final imageData = state.imageData;
    final profileUrl = state.profile;

    return Column(
      children: [
        GestureDetector(
          onTap: () async {
            final image = await viewModel.imageData();
            if (image == null) {
              if (context.mounted) {
                showSnackBar(context, Messages.validateImgMsg);
              }
            } else {
              viewModel.setImageData(image);
            }
          },
          child: CircleAvatar(
            radius: 60,
            backgroundColor: Colors.grey[300],
            backgroundImage: imageData != null
                ? MemoryImage(imageData)
                : (profileUrl != null && profileUrl.isNotEmpty)
                    ? NetworkImage(profileUrl)
                    : null,
            child: (imageData == null &&
                    (profileUrl == null || profileUrl.isEmpty))
                ? const Icon(Icons.camera_alt, size: 40, color: Colors.white)
                : null,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          Messages.selectImg,
          style: const TextStyle(color: Colors.grey),
        ),
      ],
    );
  }
}

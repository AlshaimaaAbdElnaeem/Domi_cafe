import 'package:flutter/material.dart';

class ProfileWidget extends StatelessWidget {
  final String name;
  final String email;
  final String imageUrl;
  final bool isEditing;
  final TextEditingController nameController;
  final VoidCallback onEdit;
  final VoidCallback onSave;
  final VoidCallback onLogout;
  final VoidCallback onPickImage;

  const ProfileWidget({
    super.key,
    required this.name,
    required this.email,
    required this.imageUrl,
    required this.isEditing,
    required this.nameController,
    required this.onEdit,
    required this.onSave,
    required this.onLogout,
    required this.onPickImage,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // الصورة مع زر تعديل الصورة
        Stack(
          alignment: Alignment.bottomRight,
          children: [
            CircleAvatar(
              radius: 55,
              backgroundImage: imageUrl.isNotEmpty
                  ? NetworkImage(imageUrl)
                  : const AssetImage("assets/images/default_avatar.png")
                      as ImageProvider,
            ),
            GestureDetector(
              onTap: onPickImage,
              child: CircleAvatar(
                radius: 18,
                backgroundColor: Colors.blue,
                child: const Icon(Icons.edit, color: Colors.white, size: 20),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),

        // الاسم editable
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 200,
              child: TextField(
                controller: nameController,
                enabled: isEditing,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                ),
                decoration: const InputDecoration(
                  border: InputBorder.none,
                ),
              ),
            ),
            IconButton(
              icon: Icon(isEditing ? Icons.check : Icons.edit),
              onPressed: isEditing ? onSave : onEdit,
            ),
          ],
        ),
        const SizedBox(height: 6),

        Text(
          email,
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey.shade600,
          ),
        ),
        const SizedBox(height: 30),

        // Logout
        SizedBox(
          width: 180,
          height: 48,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF92400E),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
            onPressed: onLogout,
            child: const Text(
              "Logout",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

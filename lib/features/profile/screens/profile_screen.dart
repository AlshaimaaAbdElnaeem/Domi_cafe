import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../cubit/profile_cubit.dart';
import '../cubit/profile_state.dart';
import '../widgets/profile_widget.dart';
import 'package:domi_cafe/features/auth/presentation/screens/auth_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late final ProfileCubit _cubit;
  final nameController = TextEditingController();
  bool isEditing = false;

  @override
  void initState() {
    super.initState();
    _cubit = ProfileCubit();
    _cubit.loadProfile();
  }

  @override
  void dispose() {
    _cubit.close();
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _cubit,
      child: BlocConsumer<ProfileCubit, ProfileState>(
        listener: (context, state) {
          if (state is ProfileError) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.message)));
          } else if (state is ProfileUpdated) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Profile updated')),
            );
            _cubit.loadProfile();
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.transparent,
              foregroundColor: Colors.black,
              title: const Text(
                'My Profile',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              centerTitle: true,
            ),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: _buildBody(state),
            ),
          );
        },
      ),
    );
  }

  Widget _buildBody(ProfileState state) {
    if (state is ProfileLoading || state is ProfileInitial) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state is ProfileLoaded) {
      if (nameController.text.isEmpty) {
        nameController.text = state.name;
      }

      return ProfileWidget(
        name: state.name,
        email: state.email,
        imageUrl: state.photoURL,
        isEditing: isEditing,
        nameController: nameController,
        onEdit: () => setState(() => isEditing = true),
        onSave: () {
          _cubit.updateName(nameController.text.trim());
          setState(() => isEditing = false);
        },
        onLogout: () async {
          await _cubit.logout();
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => const AuthScreen()),
            (route) => false,
          );
        },
        onPickImage: () async {
          final picker = ImagePicker();
          final pickedFile =
              await picker.pickImage(source: ImageSource.gallery);
          if (pickedFile == null) return;

          final file = File(pickedFile.path);
          await _cubit.updatePhoto(file);
        },
      );
    }

    if (state is ProfileError) {
      return Center(child: Text('Error: ${state.message}'));
    }

    return const SizedBox.shrink();
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:projex_app/state/task_provider.dart';
import 'package:projex_app/state/user_provider.dart';
import 'package:transparent_image/transparent_image.dart';

class FacePile extends ConsumerStatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  FacePile({
    Key? key,
    this.faceSize = 48,
    this.facePercentOverlap = 0.1,
    this.leftOffset = 0,
  }) : super(key: key);

  final double faceSize;
  final double facePercentOverlap;
  final double leftOffset;

  @override
  FacePileState createState() => FacePileState();
}

class FacePileState extends ConsumerState<FacePile> with SingleTickerProviderStateMixin {
  final _visibleUsers = <String>[];
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _syncUsersWithPile();
    });
  }

  @override
  void didUpdateWidget(FacePile oldWidget) {
    super.didUpdateWidget(oldWidget);

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _syncUsersWithPile();
    });
  }

  void _syncUsersWithPile() {
    setState(() {
      final users = ref.read(taskProvider).assignedToIds;
      final newUsers = users.where(
        (user) => _visibleUsers.where((visibleUser) => visibleUser == user).isEmpty,
      );

      for (final newUser in newUsers) {
        _visibleUsers.add(newUser);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final users = ref.watch(taskProvider.select((value) => value.assignedToIds));
    return LayoutBuilder(
      builder: (context, constraints) {
        final facesCount = _visibleUsers.length;

        double facePercentVisible = 1.0 - widget.facePercentOverlap;

        final maxIntrinsicWidth =
            facesCount > 1 ? (1 + (facePercentVisible * (facesCount - 1))) * widget.faceSize : widget.faceSize;

        if (maxIntrinsicWidth > constraints.maxWidth) {
          facePercentVisible = ((constraints.maxWidth / widget.faceSize) - 1) / (facesCount - 1);
        }
        if (constraints.maxWidth < widget.faceSize) {
          // There isn't room for a single face. Show nothing.
          return const SizedBox();
        }

        return SizedBox(
          height: widget.faceSize,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              for (var i = 0; i < facesCount; i++)
                AnimatedPositioned(
                  key: ValueKey(_visibleUsers[i]),
                  top: 0,
                  height: widget.faceSize,
                  left: widget.leftOffset + i * facePercentVisible * widget.faceSize,
                  width: widget.faceSize,
                  duration: const Duration(milliseconds: 250),
                  curve: Curves.easeInOut,
                  child: ProviderScope(
                    overrides: [
                      selectedUserProvider.overrideWithValue(_visibleUsers[i]),
                    ],
                    child: AppearingAndDisappearingFace(
                      showFace: users.contains(_visibleUsers[i]),
                      faceSize: widget.faceSize,
                      onDisappear: () {
                        setState(() {
                          _visibleUsers.removeAt(i);
                        });
                      },
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}

class AppearingAndDisappearingFace extends StatefulWidget {
  const AppearingAndDisappearingFace({
    Key? key,
    required this.faceSize,
    required this.showFace,
    required this.onDisappear,
  }) : super(key: key);

  final double faceSize;
  final bool showFace;
  final VoidCallback onDisappear;

  @override
  AppearingAndDisappearingFaceState createState() => AppearingAndDisappearingFaceState();
}

class AppearingAndDisappearingFaceState extends State<AppearingAndDisappearingFace>
    with SingleTickerProviderStateMixin {
  late AnimationController _scaleController;
  late Animation _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _scaleController = AnimationController(vsync: this, duration: const Duration(milliseconds: 500))
      ..addStatusListener((status) {
        if (status == AnimationStatus.dismissed) {
          widget.onDisappear();
        }
      });
    _scaleAnimation = CurvedAnimation(
      parent: _scaleController,
      curve: Curves.elasticOut,
    );

    _syncScaleAnimationWithWidget();
  }

  @override
  void didUpdateWidget(AppearingAndDisappearingFace oldWidget) {
    super.didUpdateWidget(oldWidget);

    _syncScaleAnimationWithWidget();
  }

  void _syncScaleAnimationWithWidget() {
    if (widget.showFace && !_scaleController.isCompleted && _scaleController.status != AnimationStatus.forward) {
      _scaleController.forward();
    } else if (!widget.showFace &&
        !_scaleController.isDismissed &&
        _scaleController.status != AnimationStatus.reverse) {
      _scaleController.reverse();
    }
  }

  @override
  void dispose() {
    _scaleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.faceSize,
      height: widget.faceSize,
      child: Center(
        child: AnimatedBuilder(
          animation: _scaleAnimation,
          builder: (context, child) {
            return Transform.scale(
              scale: _scaleAnimation.value,
              child: AvatarCircle(
                size: widget.faceSize,
                nameLabelColor: const Color(0xFF222222),
                backgroundColor: const Color(0xFF888888),
              ),
            );
          },
        ),
      ),
    );
  }
}

class AvatarCircle extends ConsumerWidget {
  const AvatarCircle({
    Key? key,
    this.size = 48,
    required this.nameLabelColor,
    required this.backgroundColor,
  }) : super(key: key);

  final double size;
  final Color nameLabelColor;
  final Color backgroundColor;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: backgroundColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 5,
            offset: const Offset(0, 3),
          )
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                user.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: nameLabelColor,
                  fontSize: 8,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          FadeInImage.memoryNetwork(
            placeholder: kTransparentImage,
            image: user.profilePicture.link,
            fadeInDuration: const Duration(milliseconds: 250),
          ),
        ],
      ),
    );
  }
}

import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:collection/collection.dart';
import 'package:eduplanner/eduplanner.dart';
import 'package:eduplanner/gen/assets/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_modular/flutter_modular.dart';
import 'package:yaml/yaml.dart';

/// A widget that allows selecting a demo user to log in as.
class DemoUserSelector extends StatefulWidget {
  /// A widget that allows selecting a demo user to log in as.
  const DemoUserSelector({super.key, this.onLogin});

  /// Callback to be called when the user logs in successfully.
  final void Function()? onLogin;

  @override
  State<DemoUserSelector> createState() => _DemoUserSelectorState();
}

class _DemoUserSelectorState extends State<DemoUserSelector> {
  bool loggingIn = false;

  Future<void> login(String username, String password) async {
    setState(() {
      loggingIn = true;
    });

    final auth = Modular.get<AuthRepository>();

    final success = await auth.authenticate(
      username: username,
      password: password,
    );

    if (!mounted) return;

    setState(() {
      loggingIn = false;
    });

    if (success) {
      widget.onLogin?.call();
    }
  }

  Future<(String, List<User>)>? _demoUsersFuture;

  @override
  void initState() {
    super.initState();

    _demoUsersFuture = _getDemoUsers();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _demoUsersFuture,
      builder: (context, asyncSnapshot) {
        if (asyncSnapshot.hasError) {
          return Center(
            child: Text(context.t.auth_demoUserSelector_noUserError).color(context.theme.colorScheme.error),
          );
        }

        if (!asyncSnapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        final (password, users) = asyncSnapshot.data!;

        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(context.t.auth_demoUserSelector_selectUser).fontSize(18).bold(),
            Spacing.largeVertical(),
            SizedBox(
              height: MediaQuery.sizeOf(context).height * 0.5,
              child: SingleChildScrollView(
                child: Column(
                  children: users
                      .map(
                        (user) => Padding(
                          padding: const EdgeInsets.all(8),
                          child: HoverBuilder(
                            onTap: () => login(user.username, password),
                            builder: (context, hover) => Container(
                              decoration: BoxDecoration(
                                color: hover ? context.theme.colorScheme.primary.withValues(alpha: 0.1) : context.theme.colorScheme.surface,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Padding(
                                padding: PaddingAll(),
                                child: Row(
                                  children: [
                                    UserProfileImage(userId: user.id),
                                    Spacing.mediumHorizontal(),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(user.fullname, style: context.textTheme.titleMedium),
                                        if (user.capabilities.hasStudent)
                                          Text(user.vintage?.humanReadable ?? UserCapability.student.translate(context))
                                              .color(context.theme.colorScheme.primary),
                                        if (!user.capabilities.hasStudent)
                                          Text(user.capabilities.map((e) => e.translate(context)).join(', '))
                                              .color(context.theme.colorScheme.primary),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                      .toList()
                      .show(),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

/// Loads demo users from assets/demo/users.yml
Future<(String, List<User>)> _getDemoUsers() async {
  final data = await rootBundle.loadString(Assets.demo.users);
  final users = loadYaml(data);

  final password = users['password'] as String;
  final userList = <User>[];

  for (final user in users['users']) {
    final vintage = user['class'] as String?;
    final fullname = user['name'] as String;
    final username = fullname.replaceAll(' ', '_').toLowerCase();

    final capabilities = (user['capabilities'] as YamlList).map((e) => UserCapability.values.byName(e)).toList();

    final capabilitiesBitMask = capabilities.fold<int>(0, (previousValue, element) => previousValue | element.value);

    userList.add(
      User(
        username: username,
        firstname: fullname.split(' ').first,
        lastname: fullname.split(' ').last,
        id: username.hashCode,
        vintage: Vintage.values.firstWhereOrNull((v) => v.humanReadable == vintage),
        capabilitiesBitMask: capabilitiesBitMask,
      ),
    );
  }

  return (password, userList);
}

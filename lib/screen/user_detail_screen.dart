import 'package:flutter/material.dart';
import 'package:login/api/user_model.dart';

class UserDetailScreen extends StatelessWidget {
  final UserModel user;

  const UserDetailScreen({super.key, required this.user});

  Color _getAvatarColor(String name) {
    final colors = [
      const Color.fromARGB(255, 202, 171, 255),
      Colors.indigo,
      Colors.teal,
      Colors.blue,
      Colors.pink,
      Colors.orange,
    ];
    return colors[name.hashCode % colors.length];
  }

  @override
  Widget build(BuildContext context) {
    final avatarColor = _getAvatarColor(user.name);

    return Scaffold(
      appBar: AppBar(
        title: const Text('User Details'),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // User Header Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [avatarColor.withValues(alpha: 0.8), avatarColor],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: avatarColor.withValues(alpha: 0.3),
                    blurRadius: 12,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.white,
                    child: Text(
                      user.name.isNotEmpty ? user.name[0].toUpperCase() : 'U',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: avatarColor,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    user.name,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '@${user.username}',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white.withValues(alpha: 0.9),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Contact Info Card
            _buildSectionCard(
              context,
              title: 'Contact Information',
              icon: Icons.contact_mail_outlined,
              children: [
                _buildInfoTile(
                  icon: Icons.email_outlined,
                  title: 'Email',
                  value: user.email,
                ),
                const Divider(),
                _buildInfoTile(
                  icon: Icons.phone_outlined,
                  title: 'Phone',
                  value: user.phone,
                ),
                const Divider(),
                _buildInfoTile(
                  icon: Icons.language_outlined,
                  title: 'Website',
                  value: user.website,
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Address Card
            if (user.address != null)
              _buildSectionCard(
                context,
                title: 'Address',
                icon: Icons.location_on_outlined,
                children: [
                  _buildInfoTile(
                    icon: Icons.home_outlined,
                    title: 'Street',
                    value: '${user.address!.suite}, ${user.address!.street}',
                  ),
                  const Divider(),
                  _buildInfoTile(
                    icon: Icons.location_city_outlined,
                    title: 'City & Zipcode',
                    value: '${user.address!.city}, ${user.address!.zipcode}',
                  ),
                  if (user.address!.geo != null) ...[
                    const Divider(),
                    _buildInfoTile(
                      icon: Icons.map_outlined,
                      title: 'Coordinates',
                      value:
                          'Lat: ${user.address!.geo!.lat}, Lng: ${user.address!.geo!.lng}',
                    ),
                  ],
                ],
              ),
            const SizedBox(height: 16),

            // Company Card
            if (user.company != null)
              _buildSectionCard(
                context,
                title: 'Company',
                icon: Icons.business_outlined,
                children: [
                  _buildInfoTile(
                    icon: Icons.domain_outlined,
                    title: 'Company Name',
                    value: user.company!.name,
                  ),
                  const Divider(),
                  _buildInfoTile(
                    icon: Icons.format_quote_outlined,
                    title: 'Catchphrase',
                    value: user.company!.catchPhrase,
                  ),
                  const Divider(),
                  _buildInfoTile(
                    icon: Icons.work_outline,
                    title: 'Business',
                    value: user.company!.bs,
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionCard(
    BuildContext context, {
    required String title,
    required IconData icon,
    required List<Widget> children,
  }) {
    final theme = Theme.of(context);
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: theme.colorScheme.primary),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.primary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _buildInfoTile({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 20, color: Colors.grey[600]),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value.isNotEmpty ? value : 'N/A',
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

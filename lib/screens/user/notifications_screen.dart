import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../models/notification.dart';
import '../../services/api_service.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  _NotificationsScreenState createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  final ApiService _apiService = ApiService();

  IconData _typeIcon(String type) {
    switch (type) {
      case 'new_job':
        return Icons.work_outline_rounded;
      case 'status_update':
        return Icons.assignment_outlined;
      case 'message':
        return Icons.chat_bubble_outline_rounded;
      default:
        return Icons.notifications_outlined;
    }
  }

  Color _typeColor(String type) {
    switch (type) {
      case 'new_job':
        return Colors.blue;
      case 'status_update':
        return Colors.orange;
      case 'message':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  String _typeLabel(String type) {
    switch (type) {
      case 'new_job':
        return 'Lowongan Baru';
      case 'status_update':
        return 'Status';
      case 'message':
        return 'Pesan';
      default:
        return 'Umum';
    }
  }

  @override
  Widget build(BuildContext context) {
    final notifications = _apiService.getNotifications();

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: const Text('Notifikasi'),
        elevation: 0,
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                _apiService.markAllNotificationsAsRead();
              });
            },
            child: const Text(
              'Tandai Semua',
              style: TextStyle(
                color: Color(0xFF4F46E5),
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
      body: notifications.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: const Color(0xFF4F46E5).withOpacity(0.08),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.notifications_off_outlined,
                      size: 56,
                      color: Color(0xFF4F46E5),
                    ),
                  )
                      .animate()
                      .scale(duration: 600.ms, curve: Curves.easeOutBack),
                  const SizedBox(height: 20),
                  Text(
                    'Belum ada notifikasi',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Colors.grey[700],
                    ),
                  )
                      .animate()
                      .fadeIn(delay: 200.ms),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: notifications.length,
              itemBuilder: (context, index) {
                final notif = notifications[index];
                return _buildNotificationCard(notif)
                    .animate()
                    .fadeIn(delay: (index * 80).ms, duration: 500.ms)
                    .slideX(begin: 0.1, end: 0, duration: 500.ms, curve: Curves.easeOut);
              },
            ),
    );
  }

  Widget _buildNotificationCard(AppNotification notif) {
    final typeColor = _typeColor(notif.type);

    return GestureDetector(
      onTap: () {
        setState(() {
          _apiService.markNotificationAsRead(notif.id);
        });
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: notif.isRead ? Colors.white : typeColor.withOpacity(0.04),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: notif.isRead ? Colors.grey.shade100 : typeColor.withOpacity(0.15),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.02),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        typeColor.withOpacity(0.15),
                        typeColor.withOpacity(0.08),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Icon(
                    _typeIcon(notif.type),
                    color: typeColor,
                    size: 24,
                  ),
                ),
                if (!notif.isRead)
                  Positioned(
                    top: -1,
                    right: -1,
                    child: Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        color: typeColor,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                    )
                        .animate(onPlay: (controller) => controller.repeat())
                        .scale(begin: const Offset(1, 1), end: const Offset(1.4, 1.4), duration: 1.seconds)
                        .then()
                        .scale(begin: const Offset(1.4, 1.4), end: const Offset(1, 1), duration: 1.seconds),
                  ),
              ],
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: typeColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          _typeLabel(notif.type),
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            color: typeColor,
                          ),
                        ),
                      ),
                      const Spacer(),
                      Text(
                        _timeAgo(notif.createdAt),
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.grey[400],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    notif.title,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: notif.isRead ? FontWeight.w600 : FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    notif.message,
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey[600],
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _timeAgo(DateTime dt) {
    final diff = DateTime.now().difference(dt);
    if (diff.inMinutes < 1) return 'Baru saja';
    if (diff.inMinutes < 60) return '${diff.inMinutes} menit yang lalu';
    if (diff.inHours < 24) return '${diff.inHours} jam yang lalu';
    if (diff.inDays == 1) return 'Kemarin';
    return '${diff.inDays} hari yang lalu';
  }
}


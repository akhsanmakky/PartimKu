import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../services/api_service.dart';
import '../user/chat_screen.dart';

class CompanyChatListScreen extends StatelessWidget {
  final ApiService _apiService = ApiService();

  CompanyChatListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final messages = _apiService.getAllChatMessages();

    final partnerIds = <String>{};
    final conversations = <Map<String, dynamic>>[];
    for (final msg in messages) {
      final partnerId = msg.senderId == _apiService.currentUserId ? msg.receiverId : msg.senderId;
      if (!partnerIds.contains(partnerId)) {
        partnerIds.add(partnerId);
        conversations.add({
          'partnerId': partnerId,
          'partnerName': msg.senderId == _apiService.currentUserId ? msg.senderName : msg.senderId == partnerId ? msg.senderName : 'User',
          'lastMessage': msg.message,
          'timestamp': msg.timestamp,
        });
      }
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: const Text('Chat dengan Pelamar'),
        elevation: 0,
      ),
      body: conversations.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.chat_bubble_outline_rounded, size: 64, color: Colors.grey[300]),
                  const SizedBox(height: 16),
                  Text('Belum ada chat', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.grey[600])),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: conversations.length,
              itemBuilder: (context, index) {
                final conv = conversations[index];
                return _buildChatTile(context, conv)
                    .animate()
                    .fadeIn(delay: (index * 100).ms, duration: 500.ms)
                    .slideY(begin: 0.2, end: 0, duration: 500.ms, curve: Curves.easeOut);
              },
            ),
    );
  }

  Widget _buildChatTile(BuildContext context, Map<String, dynamic> conv) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ChatScreen(
              companyId: conv['partnerId'],
              companyName: conv['partnerName'],
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 12, offset: const Offset(0, 4)),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [const Color(0xFF4F46E5).withOpacity(0.15), const Color(0xFF7C3AED).withOpacity(0.15)]),
                borderRadius: BorderRadius.circular(14),
              ),
              child: const Icon(Icons.person_rounded, color: Color(0xFF4F46E5)),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    conv['partnerName'],
                    style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    conv['lastMessage'],
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 13, color: Colors.grey[600]),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

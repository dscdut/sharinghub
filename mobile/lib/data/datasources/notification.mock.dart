abstract class NotificationMock {
  static dynamic get listAllNotis => [
        {
          'content': 'You have a new donation from John Doe',
          'time': '1 hour ago',
          'isRead': true,
        },
        {
          'content': 'Your campaign has been approved',
          'time': '2 hours ago',
          'isRead': false,
        },
        {
          'content': 'Your campaign has been rejected',
          'time': '3 hours ago',
          'isRead': true,
        },
        {
          'content': 'Your campaign has been approved',
          'time': '4 hours ago',
          'isRead': true,
        },
        {
          'content': 'Your campaign has been rejected',
          'time': '5 hours ago',
          'isRead': false,
        },
        {
          'content': 'Your campaign has been approved',
          'time': '6 hours ago',
          'isRead': true,
        },
        {
          'content': 'Your campaign has been rejected',
          'time': '7 hours ago',
          'isRead': true,
        },
        {
          'content': 'Your campaign has been approved',
          'time': '8 hours ago',
          'isRead': false,
        },
        {
          'content': 'Your campaign has been rejected',
          'time': '9 hours ago',
          'isRead': true,
        },
      ];

  static dynamic get listUnreadNotis => [
        {
          'content': 'You have a new donation from Okeke Chinedu',
          'time': '1 hour ago',
          'isRead': false,
        },
        {
          'content': 'Your campaign has been approved',
          'time': '2 hours ago',
          'isRead': false,
        },
        {
          'content': 'Your campaign has been rejected',
          'time': '3 hours ago',
          'isRead': false,
        },
      ];
}

/// ===============================================================
/// Twimzi Routes
/// ===============================================================
library;

abstract final class AppRoutes {
  AppRoutes._();

  // ===============================================================
  // Splash
  // ===============================================================

  static const String splash = '/';

  // ===============================================================
  // Authentication
  // ===============================================================

  static const String login = '/login';

  static const String register = '/register';

  static const String forgotPassword = '/forgot-password';

  static const String verifyEmail = '/verify-email';

  // ===============================================================
  // Home
  // ===============================================================

  static const String home = '/home';

  // ===============================================================
  // Search
  // ===============================================================

  static const String search = '/search';

  // ===============================================================
  // Business
  // ===============================================================

  static const String businesses = '/businesses';

  static const String businessDetails = '/business';

  static const String createBusiness = '/business/create';

  static const String editBusiness = '/business/edit';

  // ===============================================================
  // Products
  // ===============================================================

  static const String products = '/products';

  static const String productDetails = '/product';

  static const String createProduct = '/product/create';

  static const String editProduct = '/product/edit';

  // ===============================================================
  // Services
  // ===============================================================

  static const String services = '/services';

  static const String serviceDetails = '/service';

  static const String createService = '/service/create';

  static const String editService = '/service/edit';

  // ===============================================================
  // Booking
  // ===============================================================

  static const String bookings = '/bookings';

  static const String bookingDetails = '/booking';

  // ===============================================================
  // Offers
  // ===============================================================

  static const String offers = '/offers';

  // ===============================================================
  // Reviews
  // ===============================================================

  static const String reviews = '/reviews';

  // ===============================================================
  // Notifications
  // ===============================================================

  static const String notifications = '/notifications';

  // ===============================================================
  // Chat
  // ===============================================================

  static const String chats = '/chats';

  static const String chatDetails = '/chat';

  // ===============================================================
  // Community
  // ===============================================================

  static const String community = '/community';

  // ===============================================================
  // Profile
  // ===============================================================

  static const String profile = '/profile';

  static const String editProfile = '/profile/edit';

  // ===============================================================
  // Settings
  // ===============================================================

  static const String settings = '/settings';

  // ===============================================================
  // AI Assistant
  // ===============================================================

  static const String aiAssistant = '/ai-assistant';
}
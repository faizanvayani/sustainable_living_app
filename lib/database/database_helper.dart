import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/user.dart';
import '../models/carbon_footprint.dart';
import '../models/eco_product.dart';
import '../models/challenge.dart';
import '../models/recipe.dart';
import '../models/energy_tip.dart';
import '../models/certification.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('sustainable_living.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';
    const intType = 'INTEGER NOT NULL';
    const realType = 'REAL NOT NULL';

    // Users Table
    await db.execute('''
      CREATE TABLE users (
        id $idType,
        username $textType,
        email TEXT UNIQUE NOT NULL,
        password $textType,
        profile_image TEXT,
        created_at $textType
      )
    ''');

    // Carbon Footprint Table
    await db.execute('''
      CREATE TABLE carbon_footprint (
        id $idType,
        user_id $intType,
        date $textType,
        transportation $realType,
        energy_usage $realType,
        food_consumption $realType,
        total_footprint $realType,
        FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE
      )
    ''');

    // Eco Products Table
    await db.execute('''
      CREATE TABLE eco_products (
        id $idType,
        product_name $textType,
        category $textType,
        description TEXT,
        image_url TEXT,
        price $realType,
        rating $realType,
        created_at $textType
      )
    ''');

    // Challenges Table
    await db.execute('''
      CREATE TABLE challenges (
        id $idType,
        challenge_name $textType,
        description TEXT,
        duration $intType,
        difficulty $textType,
        points $intType
      )
    ''');

    // User Challenges Table
    await db.execute('''
      CREATE TABLE user_challenges (
        id $idType,
        user_id $intType,
        challenge_id $intType,
        status $textType,
        progress $intType,
        created_at $textType,
        FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE,
        FOREIGN KEY (challenge_id) REFERENCES challenges (id) ON DELETE CASCADE
      )
    ''');

    // Waste Tracker Table
    await db.execute('''
      CREATE TABLE waste_tracker (
        id $idType,
        user_id $intType,
        date $textType,
        waste_type $textType,
        quantity $realType,
        recycled INTEGER NOT NULL,
        FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE
      )
    ''');

    // Recipes Table
    await db.execute('''
      CREATE TABLE recipes (
        id $idType,
        recipe_name $textType,
        category $textType,
        ingredients TEXT,
        instructions TEXT,
        carbon_impact $textType,
        image_url TEXT
      )
    ''');

    // Energy Tips Table
    await db.execute('''
      CREATE TABLE energy_tips (
        id $idType,
        tip_title $textType,
        tip_content TEXT,
        category $textType,
        savings_potential $textType
      )
    ''');

    // Certifications Table
    await db.execute('''
      CREATE TABLE certifications (
        id $idType,
        cert_name $textType,
        cert_type $textType,
        cert_description TEXT,
        image_url TEXT
      )
    ''');

    // Community Posts Table
    await db.execute('''
      CREATE TABLE community_posts (
        id $idType,
        user_id $intType,
        post_title $textType,
        post_content TEXT,
        likes INTEGER DEFAULT 0,
        created_at $textType,
        FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE
      )
    ''');

    // Contact Queries Table
    await db.execute('''
      CREATE TABLE contact_queries (
        id $idType,
        name $textType,
        email $textType,
        contact_number TEXT,
        message TEXT,
        created_at $textType
      )
    ''');

    // Insert sample data
    await _insertSampleData(db);
  }

  Future<void> _insertSampleData(Database db) async {
    final now = DateTime.now().toIso8601String();

    // Sample Eco Products
    final products = [
      {'product_name': 'Reusable Water Bottle', 'category': 'Household', 'description': 'Eco-friendly stainless steel bottle', 'price': 25.99, 'rating': 4.5, 'created_at': now},
      {'product_name': 'Bamboo Toothbrush', 'category': 'Personal Care', 'description': 'Biodegradable bamboo toothbrush', 'price': 5.99, 'rating': 4.8, 'created_at': now},
      {'product_name': 'Organic Cotton Bag', 'category': 'Shopping', 'description': 'Reusable shopping bag', 'price': 12.99, 'rating': 4.6, 'created_at': now},
      {'product_name': 'Solar Phone Charger', 'category': 'Energy', 'description': 'Portable solar charging device', 'price': 45.99, 'rating': 4.3, 'created_at': now},
      {'product_name': 'Compost Bin', 'category': 'Kitchen', 'description': 'Kitchen composting container', 'price': 35.99, 'rating': 4.7, 'created_at': now},
      {'product_name': 'LED Light Bulbs Pack', 'category': 'Energy', 'description': 'Energy efficient LED bulbs (4-pack)', 'price': 18.99, 'rating': 4.9, 'created_at': now},
      {'product_name': 'Reusable Food Wraps', 'category': 'Kitchen', 'description': 'Beeswax food wraps set', 'price': 15.99, 'rating': 4.4, 'created_at': now},
      {'product_name': 'Eco Laundry Detergent', 'category': 'Household', 'description': 'Plant-based laundry detergent', 'price': 22.99, 'rating': 4.6, 'created_at': now},
    ];
    for (var product in products) {
      await db.insert('eco_products', product);
    }

    // Sample Challenges
    final challenges = [
      {'challenge_name': 'Plastic-Free Week', 'description': 'Avoid single-use plastics for 7 days', 'duration': 7, 'difficulty': 'Medium', 'points': 100},
      {'challenge_name': 'Zero Waste Month', 'description': 'Minimize waste to near zero for 30 days', 'duration': 30, 'difficulty': 'Hard', 'points': 500},
      {'challenge_name': 'Meatless Monday', 'description': 'Go vegetarian every Monday for a month', 'duration': 4, 'difficulty': 'Easy', 'points': 50},
      {'challenge_name': 'Energy Saver Challenge', 'description': 'Reduce electricity usage by 20%', 'duration': 14, 'difficulty': 'Medium', 'points': 150},
      {'challenge_name': 'Walk to Work Week', 'description': 'Walk or bike to work instead of driving', 'duration': 7, 'difficulty': 'Easy', 'points': 80},
      {'challenge_name': 'Local Food Challenge', 'description': 'Only buy locally sourced food for 2 weeks', 'duration': 14, 'difficulty': 'Medium', 'points': 120},
    ];
    for (var challenge in challenges) {
      await db.insert('challenges', challenge);
    }

    // Sample Recipes
    final recipes = [
      {'recipe_name': 'Veggie Stir-Fry', 'category': 'Dinner', 'ingredients': 'Mixed vegetables, soy sauce, ginger, garlic, rice', 'instructions': 'Heat oil in wok. Stir-fry vegetables on high heat. Add sauce and serve with rice.', 'carbon_impact': 'Low'},
      {'recipe_name': 'Quinoa Salad', 'category': 'Lunch', 'ingredients': 'Quinoa, cucumber, tomatoes, lemon, olive oil, herbs', 'instructions': 'Cook quinoa. Chop vegetables. Mix all ingredients with dressing.', 'carbon_impact': 'Very Low'},
      {'recipe_name': 'Lentil Soup', 'category': 'Dinner', 'ingredients': 'Lentils, carrots, celery, onion, vegetable broth, spices', 'instructions': 'Sauté vegetables. Add lentils and broth. Simmer until tender.', 'carbon_impact': 'Low'},
      {'recipe_name': 'Chickpea Curry', 'category': 'Dinner', 'ingredients': 'Chickpeas, coconut milk, curry spices, tomatoes, onion', 'instructions': 'Cook chickpeas with spices. Add coconut milk and simmer.', 'carbon_impact': 'Low'},
      {'recipe_name': 'Overnight Oats', 'category': 'Breakfast', 'ingredients': 'Oats, almond milk, fruits, nuts, honey', 'instructions': 'Mix all ingredients in jar. Refrigerate overnight. Enjoy cold.', 'carbon_impact': 'Very Low'},
      {'recipe_name': 'Bean Burrito Bowl', 'category': 'Lunch', 'ingredients': 'Black beans, rice, avocado, salsa, lettuce, lime', 'instructions': 'Layer ingredients in bowl. Top with salsa and lime.', 'carbon_impact': 'Low'},
    ];
    for (var recipe in recipes) {
      await db.insert('recipes', recipe);
    }

    // Sample Energy Tips
    final tips = [
      {'tip_title': 'Switch to LED Bulbs', 'tip_content': 'Replace traditional bulbs with LED to save up to 75% energy and reduce electricity bills significantly.', 'category': 'Lighting', 'savings_potential': 'High'},
      {'tip_title': 'Unplug Devices', 'tip_content': 'Unplug electronics when not in use to prevent phantom energy drain that can account for 10% of your bill.', 'category': 'General', 'savings_potential': 'Medium'},
      {'tip_title': 'Use Smart Thermostat', 'tip_content': 'Install a programmable thermostat to optimize heating and cooling, saving up to 30% on energy costs.', 'category': 'Heating/Cooling', 'savings_potential': 'High'},
      {'tip_title': 'Energy Star Appliances', 'tip_content': 'Choose Energy Star certified appliances that use 10-50% less energy than standard models.', 'category': 'Appliances', 'savings_potential': 'High'},
      {'tip_title': 'Maximize Natural Light', 'tip_content': 'Open curtains during day to reduce artificial lighting needs and save on electricity.', 'category': 'Lighting', 'savings_potential': 'Medium'},
      {'tip_title': 'Improve Insulation', 'tip_content': 'Better home insulation can reduce heating and cooling costs by up to 20%.', 'category': 'Heating/Cooling', 'savings_potential': 'High'},
      {'tip_title': 'Cold Water Washing', 'tip_content': 'Wash clothes in cold water to save energy - heating water accounts for 90% of washing machine energy use.', 'category': 'Appliances', 'savings_potential': 'Medium'},
      {'tip_title': 'Air Dry Clothes', 'tip_content': 'Line dry clothes instead of using electric dryer to save significant energy.', 'category': 'Appliances', 'savings_potential': 'Medium'},
    ];
    for (var tip in tips) {
      await db.insert('energy_tips', tip);
    }

    // Sample Certifications
    final certifications = [
      {'cert_name': 'Fair Trade', 'cert_type': 'Ethical', 'cert_description': 'Ensures fair wages and safe working conditions for producers in developing countries.'},
      {'cert_name': 'Energy Star', 'cert_type': 'Energy', 'cert_description': 'Products meet strict energy efficiency guidelines set by EPA and DOE.'},
      {'cert_name': 'USDA Organic', 'cert_type': 'Food', 'cert_description': 'Certified organic farming practices without synthetic pesticides or GMOs.'},
      {'cert_name': 'Rainforest Alliance', 'cert_type': 'Environmental', 'cert_description': 'Promotes sustainable farming and forest management practices.'},
      {'cert_name': 'Cradle to Cradle', 'cert_type': 'Product', 'cert_description': 'Products designed for circular economy with zero waste principles.'},
      {'cert_name': 'LEED Certified', 'cert_type': 'Building', 'cert_description': 'Leadership in Energy and Environmental Design for sustainable buildings.'},
      {'cert_name': 'FSC Certified', 'cert_type': 'Forest', 'cert_description': 'Responsibly sourced wood and paper products from sustainable forests.'},
      {'cert_name': 'B Corporation', 'cert_type': 'Business', 'cert_description': 'Companies meeting high standards of social and environmental performance.'},
    ];
    for (var cert in certifications) {
      await db.insert('certifications', cert);
    }
  }

  // ============ USER OPERATIONS ============
  Future<int> createUser(User user) async {
    final db = await instance.database;
    return await db.insert('users', user.toMap());
  }

  Future<User?> loginUser(String email, String password) async {
    final db = await instance.database;
    final maps = await db.query(
      'users',
      where: 'email = ? AND password = ?',
      whereArgs: [email, password],
    );

    if (maps.isNotEmpty) {
      return User.fromMap(maps.first);
    }
    return null;
  }

  Future<User?> getUserById(int id) async {
    final db = await instance.database;
    final maps = await db.query('users', where: 'id = ?', whereArgs: [id]);
    if (maps.isNotEmpty) {
      return User.fromMap(maps.first);
    }
    return null;
  }

  // ============ CARBON FOOTPRINT OPERATIONS ============
  Future<int> addCarbonFootprint(CarbonFootprint footprint) async {
    final db = await instance.database;
    return await db.insert('carbon_footprint', footprint.toMap());
  }

  Future<List<CarbonFootprint>> getCarbonFootprintHistory(int userId) async {
    final db = await instance.database;
    final maps = await db.query(
      'carbon_footprint',
      where: 'user_id = ?',
      whereArgs: [userId],
      orderBy: 'date DESC',
      limit: 30,
    );

    return maps.map((map) => CarbonFootprint.fromMap(map)).toList();
  }

  Future<double> getTotalCarbonFootprint(int userId) async {
    final db = await instance.database;
    final result = await db.rawQuery(
      'SELECT SUM(total_footprint) as total FROM carbon_footprint WHERE user_id = ?',
      [userId],
    );
    return result.first['total'] as double? ?? 0.0;
  }

  // ============ ECO PRODUCTS OPERATIONS ============
  Future<List<EcoProduct>> getAllProducts() async {
    final db = await instance.database;
    final maps = await db.query('eco_products', orderBy: 'rating DESC');
    return maps.map((map) => EcoProduct.fromMap(map)).toList();
  }

  Future<List<EcoProduct>> searchProducts(String keyword) async {
    final db = await instance.database;
    final maps = await db.query(
      'eco_products',
      where: 'product_name LIKE ? OR category LIKE ?',
      whereArgs: ['%$keyword%', '%$keyword%'],
    );
    return maps.map((map) => EcoProduct.fromMap(map)).toList();
  }

  Future<List<EcoProduct>> getProductsByCategory(String category) async {
    final db = await instance.database;
    final maps = await db.query(
      'eco_products',
      where: 'category = ?',
      whereArgs: [category],
      orderBy: 'rating DESC',
    );
    return maps.map((map) => EcoProduct.fromMap(map)).toList();
  }

  // ============ CHALLENGES OPERATIONS ============
  Future<List<Challenge>> getAllChallenges() async {
    final db = await instance.database;
    final maps = await db.query('challenges', orderBy: 'points DESC');
    return maps.map((map) => Challenge.fromMap(map)).toList();
  }

  Future<int> joinChallenge(int userId, int challengeId) async {
    final db = await instance.database;
    return await db.insert('user_challenges', {
      'user_id': userId,
      'challenge_id': challengeId,
      'status': 'Active',
      'progress': 0,
      'created_at': DateTime.now().toIso8601String(),
    });
  }

  Future<List<Map<String, dynamic>>> getUserChallenges(int userId) async {
    final db = await instance.database;
    return await db.rawQuery('''
      SELECT c.*, uc.status, uc.progress 
      FROM challenges c 
      INNER JOIN user_challenges uc ON c.id = uc.challenge_id 
      WHERE uc.user_id = ?
    ''', [userId]);
  }

  // ============ WASTE TRACKER OPERATIONS ============
  Future<int> addWasteEntry({
    required int userId,
    required String date,
    required String wasteType,
    required double quantity,
    required bool recycled,
  }) async {
    final db = await instance.database;
    return await db.insert('waste_tracker', {
      'user_id': userId,
      'date': date,
      'waste_type': wasteType,
      'quantity': quantity,
      'recycled': recycled ? 1 : 0,
    });
  }

  Future<List<Map<String, dynamic>>> getWasteHistory(int userId) async {
    final db = await instance.database;
    return await db.query(
      'waste_tracker',
      where: 'user_id = ?',
      whereArgs: [userId],
      orderBy: 'date DESC',
      limit: 30,
    );
  }

  // ============ RECIPES OPERATIONS ============
  Future<List<Recipe>> getAllRecipes() async {
    final db = await instance.database;
    final maps = await db.query('recipes');
    return maps.map((map) => Recipe.fromMap(map)).toList();
  }

  Future<List<Recipe>> getRecipesByCategory(String category) async {
    final db = await instance.database;
    final maps = await db.query(
      'recipes',
      where: 'category = ?',
      whereArgs: [category],
    );
    return maps.map((map) => Recipe.fromMap(map)).toList();
  }

  // ============ ENERGY TIPS OPERATIONS ============
  Future<List<EnergyTip>> getAllEnergyTips() async {
    final db = await instance.database;
    final maps = await db.query('energy_tips');
    return maps.map((map) => EnergyTip.fromMap(map)).toList();
  }

  Future<List<EnergyTip>> getTipsByCategory(String category) async {
    final db = await instance.database;
    final maps = await db.query(
      'energy_tips',
      where: 'category = ?',
      whereArgs: [category],
    );
    return maps.map((map) => EnergyTip.fromMap(map)).toList();
  }

  // ============ CERTIFICATIONS OPERATIONS ============
  Future<List<Certification>> getAllCertifications() async {
    final db = await instance.database;
    final maps = await db.query('certifications');
    return maps.map((map) => Certification.fromMap(map)).toList();
  }

  // ============ COMMUNITY OPERATIONS ============
  Future<int> addCommunityPost({
    required int userId,
    required String title,
    required String content,
  }) async {
    final db = await instance.database;
    return await db.insert('community_posts', {
      'user_id': userId,
      'post_title': title,
      'post_content': content,
      'likes': 0,
      'created_at': DateTime.now().toIso8601String(),
    });
  }

  Future<List<Map<String, dynamic>>> getAllCommunityPosts() async {
    final db = await instance.database;
    return await db.rawQuery('''
      SELECT cp.*, u.username 
      FROM community_posts cp 
      INNER JOIN users u ON cp.user_id = u.id 
      ORDER BY cp.created_at DESC
    ''');
  }

  // ============ CONTACT OPERATIONS ============
  Future<int> submitContactQuery({
    required String name,
    required String email,
    required String contactNumber,
    required String message,
  }) async {
    final db = await instance.database;
    return await db.insert('contact_queries', {
      'name': name,
      'email': email,
      'contact_number': contactNumber,
      'message': message,
      'created_at': DateTime.now().toIso8601String(),
    });
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}

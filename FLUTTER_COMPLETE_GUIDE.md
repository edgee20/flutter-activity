# Flutter Complete Development Guide
## From Zero to Hero: Everything You Need to Know

---

## Table of Contents
1. [Flutter Basics](#flutter-basics)
2. [Widgets Deep Dive](#widgets-deep-dive)
3. [State Management](#state-management)
4. [Navigation & Routing](#navigation--routing)
5. [Networking & APIs](#networking--apis)
6. [Local Storage](#local-storage)
7. [Animations](#animations)
8. [Performance Optimization](#performance-optimization)
9. [Testing](#testing)
10. [Best Practices](#best-practices)

---

## Flutter Basics

### What is Flutter?
Flutter is Google's UI toolkit for building natively compiled applications for mobile, web, and desktop from a single codebase. It uses the Dart programming language and provides a reactive framework.

### Dart Fundamentals

#### Variables and Types
```dart
// Variable declaration
var name = 'Flutter';           // Type inference
String title = 'Developer';     // Explicit type
dynamic anything = 42;          // Can be any type
final String constant = 'Fixed'; // Runtime constant
const int compile = 100;        // Compile-time constant

// Nullable types (null safety)
String? nullable;               // Can be null
String nonNull = 'value';       // Cannot be null
nullable ??= 'default';         // Null-aware assignment
```

#### Functions
```dart
// Regular function
String greet(String name) {
  return 'Hello, $name';
}

// Arrow function (single expression)
String greetShort(String name) => 'Hello, $name';

// Optional positional parameters
String fullName(String first, [String? last]) {
  return last != null ? '$first $last' : first;
}

// Named parameters
String createUser({required String name, int age = 18}) {
  return '$name is $age years old';
}

// Anonymous functions
var multiply = (int a, int b) => a * b;
```

#### Classes and Objects
```dart
class Person {
  // Properties
  final String name;
  int age;
  String? email;
  
  // Constructor
  Person(this.name, this.age, {this.email});
  
  // Named constructor
  Person.guest() : name = 'Guest', age = 0;
  
  // Methods
  void introduce() {
    print('I am $name, $age years old');
  }
  
  // Getters
  String get info => '$name ($age)';
  
  // Setters
  set updateAge(int newAge) {
    if (newAge > 0) age = newAge;
  }
}

// Inheritance
class Student extends Person {
  final String school;
  
  Student(String name, int age, this.school) : super(name, age);
  
  @override
  void introduce() {
    super.introduce();
    print('I study at $school');
  }
}

// Abstract classes
abstract class Animal {
  void makeSound(); // Abstract method
  
  void sleep() {
    print('Sleeping...');
  }
}

class Dog extends Animal {
  @override
  void makeSound() {
    print('Woof!');
  }
}

// Mixins (for composition)
mixin Flyable {
  void fly() => print('Flying!');
}

class Bird extends Animal with Flyable {
  @override
  void makeSound() => print('Chirp!');
}
```

#### Collections
```dart
// Lists
List<String> fruits = ['Apple', 'Banana', 'Orange'];
fruits.add('Mango');
fruits.remove('Banana');
print(fruits.length);
print(fruits[0]);

// Sets (unique items)
Set<int> numbers = {1, 2, 3, 3, 4}; // {1, 2, 3, 4}
numbers.add(5);

// Maps (key-value pairs)
Map<String, int> scores = {
  'Alice': 95,
  'Bob': 87,
  'Charlie': 92,
};
scores['David'] = 88;
print(scores['Alice']);

// Iterating
for (var fruit in fruits) {
  print(fruit);
}

fruits.forEach((fruit) => print(fruit));

var upperFruits = fruits.map((f) => f.toUpperCase()).toList();
var filtered = fruits.where((f) => f.startsWith('A')).toList();
```

#### Async Programming
```dart
// Future (single async operation)
Future<String> fetchData() async {
  await Future.delayed(Duration(seconds: 2));
  return 'Data loaded';
}

// Using async/await
void loadData() async {
  try {
    String result = await fetchData();
    print(result);
  } catch (e) {
    print('Error: $e');
  }
}

// Multiple futures
Future<void> loadMultiple() async {
  var results = await Future.wait([
    fetchData(),
    Future.delayed(Duration(seconds: 1), () => 'Quick data'),
  ]);
  print(results); // ['Data loaded', 'Quick data']
}

// Stream (multiple async values)
Stream<int> countStream() async* {
  for (int i = 1; i <= 5; i++) {
    await Future.delayed(Duration(seconds: 1));
    yield i; // Emit value
  }
}

// Listening to streams
void listenToStream() {
  countStream().listen(
    (number) => print('Number: $number'),
    onError: (error) => print('Error: $error'),
    onDone: () => print('Stream completed'),
  );
}

// StreamController (manual stream)
StreamController<String> controller = StreamController<String>();
controller.stream.listen((data) => print(data));
controller.add('Hello');
controller.add('World');
controller.close();
```

---

## Widgets Deep Dive

### The Widget Tree
Everything in Flutter is a widget. The UI is built as a tree of widgets, where each widget describes part of the user interface.

```dart
// Basic widget structure
MaterialApp
  └─ Scaffold
      ├─ AppBar
      └─ Body
          └─ Column
              ├─ Text
              ├─ Image
              └─ Button
```

### StatelessWidget
**Immutable widgets that don't maintain state.**

```dart
import 'package:flutter/material.dart';

class MyStatelessWidget extends StatelessWidget {
  // Constructor parameters (immutable)
  final String title;
  final Color color;
  
  // Constructor
  const MyStatelessWidget({
    Key? key,
    required this.title,
    this.color = Colors.blue,
  }) : super(key: key);
  
  // Build method - called when widget needs to be rendered
  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      padding: const EdgeInsets.all(16.0),
      child: Text(
        title,
        style: const TextStyle(fontSize: 24),
      ),
    );
  }
}

// Usage
MyStatelessWidget(
  title: 'Hello Flutter',
  color: Colors.green,
)
```

**When to use StatelessWidget:**
- Display static content
- Widget doesn't change based on user interaction
- Configuration comes from parent widget
- Examples: Icons, Text, Images, Static layouts

### StatefulWidget
**Widgets that maintain mutable state that might change during the widget's lifetime.**

```dart
import 'package:flutter/material.dart';

// The widget itself (immutable)
class MyStatefulWidget extends StatefulWidget {
  final String initialTitle;
  
  const MyStatefulWidget({
    Key? key,
    required this.initialTitle,
  }) : super(key: key);
  
  // Creates the mutable state
  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

// The state class (mutable)
class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  // Mutable state variables
  int _counter = 0;
  String _displayText = '';
  bool _isLoading = false;
  
  // Lifecycle methods
  
  @override
  void initState() {
    // Called once when state is created
    // Perfect for: initialization, subscriptions, API calls
    super.initState();
    _displayText = widget.initialTitle; // Access widget properties
    _loadInitialData();
  }
  
  @override
  void didChangeDependencies() {
    // Called when dependencies change (after initState, before build)
    // Perfect for: accessing InheritedWidget, Theme, MediaQuery
    super.didChangeDependencies();
  }
  
  @override
  void didUpdateWidget(MyStatefulWidget oldWidget) {
    // Called when parent rebuilds with different configuration
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initialTitle != widget.initialTitle) {
      setState(() {
        _displayText = widget.initialTitle;
      });
    }
  }
  
  @override
  void dispose() {
    // Called when widget is removed permanently
    // Perfect for: cleanup, cancel subscriptions, dispose controllers
    super.dispose();
  }
  
  // Custom methods
  void _incrementCounter() {
    setState(() {
      // setState tells Flutter to rebuild this widget
      _counter++;
    });
  }
  
  Future<void> _loadInitialData() async {
    setState(() => _isLoading = true);
    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      _isLoading = false;
      _displayText = 'Data loaded: $_counter';
    });
  }
  
  @override
  Widget build(BuildContext context) {
    // Called every time setState is called
    return Scaffold(
      appBar: AppBar(title: Text(_displayText)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_isLoading)
              const CircularProgressIndicator()
            else
              Text(
                'Counter: $_counter',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _incrementCounter,
              child: const Text('Increment'),
            ),
          ],
        ),
      ),
    );
  }
}
```

**Widget Lifecycle:**
```
1. Constructor called
2. createState() called → creates State object
3. initState() called → one-time initialization
4. didChangeDependencies() called → dependencies ready
5. build() called → creates widget tree
6. [Widget is displayed]
7. setState() called → triggers rebuild
8. build() called again → updates UI
9. didUpdateWidget() called → parent rebuilt with new config
10. dispose() called → cleanup before removal
```

**When to use StatefulWidget:**
- User interaction changes UI (buttons, forms, checkboxes)
- Animations
- Data that changes over time
- Real-time updates (streams, timers)
- Examples: Forms, Counters, Lists with filtering, Animated widgets

### Key Widgets Reference

#### Layout Widgets

```dart
// Container - box with decoration, padding, margins
Container(
  width: 200,
  height: 100,
  padding: const EdgeInsets.all(16),
  margin: const EdgeInsets.symmetric(horizontal: 20),
  decoration: BoxDecoration(
    color: Colors.blue,
    borderRadius: BorderRadius.circular(12),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.2),
        blurRadius: 8,
        offset: const Offset(0, 4),
      ),
    ],
  ),
  child: const Text('Hello'),
)

// Column - vertical layout
Column(
  mainAxisAlignment: MainAxisAlignment.center,  // vertical
  crossAxisAlignment: CrossAxisAlignment.start, // horizontal
  mainAxisSize: MainAxisSize.min,              // shrink to fit
  children: [
    Text('First'),
    Text('Second'),
    Text('Third'),
  ],
)

// Row - horizontal layout
Row(
  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  children: [
    Icon(Icons.star),
    Icon(Icons.star),
    Icon(Icons.star),
  ],
)

// Stack - overlapping widgets
Stack(
  alignment: Alignment.center,
  children: [
    Container(width: 200, height: 200, color: Colors.blue),
    Positioned(
      top: 10,
      right: 10,
      child: Icon(Icons.favorite),
    ),
    const Text('Centered'),
  ],
)

// ListView - scrollable list
ListView(
  children: [
    ListTile(title: Text('Item 1')),
    ListTile(title: Text('Item 2')),
    ListTile(title: Text('Item 3')),
  ],
)

// ListView.builder - efficient for large lists
ListView.builder(
  itemCount: 100,
  itemBuilder: (context, index) {
    return ListTile(title: Text('Item $index'));
  },
)

// GridView - 2D scrollable grid
GridView.builder(
  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 2,        // 2 columns
    crossAxisSpacing: 10,
    mainAxisSpacing: 10,
    childAspectRatio: 1.5,
  ),
  itemCount: 20,
  itemBuilder: (context, index) {
    return Card(child: Center(child: Text('$index')));
  },
)

// Expanded - takes remaining space
Row(
  children: [
    Container(width: 100, color: Colors.red),
    Expanded(
      flex: 2, // takes 2x space
      child: Container(color: Colors.green),
    ),
    Expanded(
      child: Container(color: Colors.blue),
    ),
  ],
)

// Flexible - shrinks to fit
Row(
  children: [
    Flexible(
      child: Text('This text will wrap if too long'),
    ),
  ],
)

// SizedBox - fixed size spacer
const SizedBox(width: 20, height: 20)

// Padding - adds padding
Padding(
  padding: const EdgeInsets.all(16),
  child: Text('Padded text'),
)

// Center - centers child
Center(child: Text('Centered'))

// Align - aligns child
Align(
  alignment: Alignment.topRight,
  child: Icon(Icons.close),
)
```

#### Input Widgets

```dart
// TextField - text input
TextField(
  decoration: const InputDecoration(
    labelText: 'Username',
    hintText: 'Enter your username',
    prefixIcon: Icon(Icons.person),
    border: OutlineInputBorder(),
  ),
  onChanged: (value) {
    print('Text changed: $value');
  },
  controller: _textController, // TextEditingController
)

// TextEditingController usage
class MyForm extends StatefulWidget {
  @override
  State<MyForm> createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {
  final TextEditingController _controller = TextEditingController();
  
  @override
  void dispose() {
    _controller.dispose(); // Always dispose controllers
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(controller: _controller),
        ElevatedButton(
          onPressed: () {
            print(_controller.text); // Get current value
            _controller.clear();      // Clear field
          },
          child: const Text('Submit'),
        ),
      ],
    );
  }
}

// Checkbox
Checkbox(
  value: _isChecked,
  onChanged: (bool? value) {
    setState(() => _isChecked = value ?? false);
  },
)

// Switch
Switch(
  value: _isSwitched,
  onChanged: (bool value) {
    setState(() => _isSwitched = value);
  },
)

// Radio buttons
Column(
  children: [
    Radio<int>(
      value: 1,
      groupValue: _selectedValue,
      onChanged: (int? value) {
        setState(() => _selectedValue = value!);
      },
    ),
    Radio<int>(
      value: 2,
      groupValue: _selectedValue,
      onChanged: (int? value) {
        setState(() => _selectedValue = value!);
      },
    ),
  ],
)

// DropdownButton
DropdownButton<String>(
  value: _selectedItem,
  items: ['Option 1', 'Option 2', 'Option 3']
      .map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      })
      .toList(),
  onChanged: (String? newValue) {
    setState(() => _selectedItem = newValue!);
  },
)

// Slider
Slider(
  value: _sliderValue,
  min: 0,
  max: 100,
  divisions: 10,
  label: _sliderValue.round().toString(),
  onChanged: (double value) {
    setState(() => _sliderValue = value);
  },
)

// DatePicker
ElevatedButton(
  onPressed: () async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    if (picked != null) {
      print('Selected: $picked');
    }
  },
  child: const Text('Pick Date'),
)
```

#### Button Widgets

```dart
// ElevatedButton - raised button with shadow
ElevatedButton(
  onPressed: () {
    print('Pressed!');
  },
  style: ElevatedButton.styleFrom(
    backgroundColor: Colors.blue,
    foregroundColor: Colors.white,
    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
  ),
  child: const Text('Elevated Button'),
)

// TextButton - flat button
TextButton(
  onPressed: () {},
  child: const Text('Text Button'),
)

// OutlinedButton - button with border
OutlinedButton(
  onPressed: () {},
  child: const Text('Outlined Button'),
)

// IconButton - icon-only button
IconButton(
  icon: const Icon(Icons.favorite),
  onPressed: () {},
  color: Colors.red,
  iconSize: 32,
)

// FloatingActionButton - circular floating button
FloatingActionButton(
  onPressed: () {},
  child: const Icon(Icons.add),
  backgroundColor: Colors.blue,
)

// GestureDetector - detect gestures on any widget
GestureDetector(
  onTap: () => print('Tapped'),
  onDoubleTap: () => print('Double tapped'),
  onLongPress: () => print('Long pressed'),
  child: Container(
    padding: const EdgeInsets.all(16),
    color: Colors.blue,
    child: const Text('Tap me'),
  ),
)

// InkWell - gesture detector with ripple effect
InkWell(
  onTap: () {},
  child: Container(
    padding: const EdgeInsets.all(16),
    child: const Text('Tap for ripple'),
  ),
)
```

---

## State Management

### setState (Built-in)
**Best for:** Simple, local state within a single widget.

```dart
class Counter extends StatefulWidget {
  @override
  State<Counter> createState() => _CounterState();
}

class _CounterState extends State<Counter> {
  int _count = 0;
  
  void _increment() {
    setState(() {
      _count++; // Modify state and trigger rebuild
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Count: $_count'),
        ElevatedButton(
          onPressed: _increment,
          child: const Text('Increment'),
        ),
      ],
    );
  }
}
```

**Pros:** Simple, built-in, no dependencies
**Cons:** Doesn't scale well, rebuilds entire widget tree, hard to share state

### InheritedWidget
**Best for:** Sharing state down the widget tree without passing props.

```dart
// 1. Create InheritedWidget
class CounterProvider extends InheritedWidget {
  final int counter;
  final void Function() increment;
  
  const CounterProvider({
    Key? key,
    required this.counter,
    required this.increment,
    required Widget child,
  }) : super(key: key, child: child);
  
  // Static method to access from context
  static CounterProvider? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<CounterProvider>();
  }
  
  // Determines when to notify listeners
  @override
  bool updateShouldNotify(CounterProvider oldWidget) {
    return oldWidget.counter != counter;
  }
}

// 2. Wrap app with provider
class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _counter = 0;
  
  void _increment() {
    setState(() => _counter++);
  }
  
  @override
  Widget build(BuildContext context) {
    return CounterProvider(
      counter: _counter,
      increment: _increment,
      child: MaterialApp(
        home: HomePage(),
      ),
    );
  }
}

// 3. Access from any child widget
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = CounterProvider.of(context)!;
    
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Counter: ${provider.counter}'),
            ElevatedButton(
              onPressed: provider.increment,
              child: const Text('Increment'),
            ),
          ],
        ),
      ),
    );
  }
}
```

### Provider Package
**Best for:** Medium to large apps, most popular solution.

```dart
// pubspec.yaml
// dependencies:
//   provider: ^6.0.0

import 'package:provider/provider.dart';

// 1. Create a ChangeNotifier model
class CounterModel extends ChangeNotifier {
  int _count = 0;
  
  int get count => _count;
  
  void increment() {
    _count++;
    notifyListeners(); // Notify all listeners to rebuild
  }
  
  void decrement() {
    _count--;
    notifyListeners();
  }
  
  void reset() {
    _count = 0;
    notifyListeners();
  }
}

// 2. Provide the model at root
void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => CounterModel(),
      child: const MyApp(),
    ),
  );
}

// 3. Multiple providers
void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CounterModel()),
        ChangeNotifierProvider(create: (_) => UserModel()),
        ChangeNotifierProvider(create: (_) => ThemeModel()),
      ],
      child: const MyApp(),
    ),
  );
}

// 4. Consume the provider
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Method 1: Consumer widget (rebuilds only this part)
    return Scaffold(
      body: Consumer<CounterModel>(
        builder: (context, counter, child) {
          return Column(
            children: [
              Text('Count: ${counter.count}'),
              ElevatedButton(
                onPressed: counter.increment,
                child: const Text('Increment'),
              ),
            ],
          );
        },
      ),
    );
  }
}

// Method 2: Provider.of (rebuilds entire widget)
class AnotherPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final counter = Provider.of<CounterModel>(context);
    
    return Text('Count: ${counter.count}');
  }
}

// Method 3: context.watch (cleaner syntax)
class ModernPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final counter = context.watch<CounterModel>();
    
    return Text('Count: ${counter.count}');
  }
}

// Method 4: context.read (doesn't listen to changes)
class ButtonOnly extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Won't rebuild when counter changes
    return ElevatedButton(
      onPressed: () {
        context.read<CounterModel>().increment();
      },
      child: const Text('Increment'),
    );
  }
}

// Advanced: Selector (rebuild only when specific property changes)
class OptimizedWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Selector<CounterModel, int>(
      selector: (context, counter) => counter.count,
      builder: (context, count, child) {
        return Text('Count: $count');
      },
    );
  }
}
```

**Provider Types:**
```dart
// ChangeNotifierProvider - for ChangeNotifier classes
ChangeNotifierProvider(create: (_) => MyModel())

// Provider - for simple objects
Provider(create: (_) => SomeService())

// StreamProvider - for streams
StreamProvider<int>(
  create: (_) => Stream.periodic(Duration(seconds: 1), (i) => i),
  initialData: 0,
)

// FutureProvider - for futures
FutureProvider<String>(
  create: (_) => fetchUserData(),
  initialData: 'Loading...',
)

// ProxyProvider - depends on other providers
ProxyProvider<AuthModel, ApiService>(
  update: (context, auth, previous) => ApiService(auth.token),
)
```

### Riverpod (Modern Provider)
**Best for:** Type-safe, compile-time safe state management.

```dart
// pubspec.yaml
// dependencies:
//   flutter_riverpod: ^2.0.0

import 'package:flutter_riverpod/flutter_riverpod.dart';

// 1. Create providers
final counterProvider = StateProvider<int>((ref) => 0);

// Provider types
final simpleProvider = Provider<String>((ref) => 'Hello');

final futureProvider = FutureProvider<String>((ref) async {
  await Future.delayed(Duration(seconds: 2));
  return 'Data loaded';
});

final streamProvider = StreamProvider<int>((ref) {
  return Stream.periodic(Duration(seconds: 1), (i) => i);
});

// StateNotifier (more complex state)
class CounterNotifier extends StateNotifier<int> {
  CounterNotifier() : super(0);
  
  void increment() => state++;
  void decrement() => state--;
}

final counterNotifierProvider = StateNotifierProvider<CounterNotifier, int>(
  (ref) => CounterNotifier(),
);

// 2. Wrap app with ProviderScope
void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

// 3. Consume providers
class HomePage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final count = ref.watch(counterProvider);
    
    return Scaffold(
      body: Column(
        children: [
          Text('Count: $count'),
          ElevatedButton(
            onPressed: () {
              ref.read(counterProvider.notifier).state++;
            },
            child: const Text('Increment'),
          ),
        ],
      ),
    );
  }
}

// With Consumer widget
class AnotherPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final count = ref.watch(counterProvider);
        return Text('Count: $count');
      },
    );
  }
}

// ConsumerStatefulWidget
class StatefulPage extends ConsumerStatefulWidget {
  @override
  ConsumerState<StatefulPage> createState() => _StatefulPageState();
}

class _StatefulPageState extends ConsumerState<StatefulPage> {
  @override
  Widget build(BuildContext context) {
    final count = ref.watch(counterProvider);
    return Text('Count: $count');
  }
}
```

### BLoC (Business Logic Component)
**Best for:** Large enterprise apps, complex business logic.

```dart
// pubspec.yaml
// dependencies:
//   flutter_bloc: ^8.0.0

import 'package:flutter_bloc/flutter_bloc.dart';

// 1. Define events
abstract class CounterEvent {}

class IncrementEvent extends CounterEvent {}
class DecrementEvent extends CounterEvent {}

// 2. Define state
class CounterState {
  final int count;
  const CounterState(this.count);
}

// 3. Create BLoC
class CounterBloc extends Bloc<CounterEvent, CounterState> {
  CounterBloc() : super(const CounterState(0)) {
    // Register event handlers
    on<IncrementEvent>((event, emit) {
      emit(CounterState(state.count + 1));
    });
    
    on<DecrementEvent>((event, emit) {
      emit(CounterState(state.count - 1));
    });
  }
}

// 4. Provide BLoC
void main() {
  runApp(
    BlocProvider(
      create: (context) => CounterBloc(),
      child: const MyApp(),
    ),
  );
}

// Multiple BLoCs
void main() {
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => CounterBloc()),
        BlocProvider(create: (_) => AuthBloc()),
      ],
      child: const MyApp(),
    ),
  );
}

// 5. Consume BLoC
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<CounterBloc, CounterState>(
        builder: (context, state) {
          return Column(
            children: [
              Text('Count: ${state.count}'),
              ElevatedButton(
                onPressed: () {
                  context.read<CounterBloc>().add(IncrementEvent());
                },
                child: const Text('Increment'),
              ),
            ],
          );
        },
      ),
    );
  }
}

// BlocListener - for side effects (navigation, dialogs)
BlocListener<CounterBloc, CounterState>(
  listener: (context, state) {
    if (state.count == 10) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Reached 10!')),
      );
    }
  },
  child: MyWidget(),
)

// BlocConsumer - builder + listener combined
BlocConsumer<CounterBloc, CounterState>(
  listener: (context, state) {
    // Handle side effects
  },
  builder: (context, state) {
    return Text('Count: ${state.count}');
  },
)
```

### GetX
**Best for:** Fast development, minimal boilerplate.

```dart
// pubspec.yaml
// dependencies:
//   get: ^4.6.0

import 'package:get/get.dart';

// 1. Create controller
class CounterController extends GetxController {
  // Reactive variable
  var count = 0.obs;
  
  void increment() {
    count++;
  }
  
  // Lifecycle
  @override
  void onInit() {
    super.onInit();
    print('Controller initialized');
  }
  
  @override
  void onClose() {
    print('Controller closed');
    super.onClose();
  }
}

// 2. Use in UI
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Get controller
    final CounterController controller = Get.put(CounterController());
    
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            // Obx - reactive widget
            Obx(() => Text('Count: ${controller.count}')),
            ElevatedButton(
              onPressed: controller.increment,
              child: const Text('Increment'),
            ),
          ],
        ),
      ),
    );
  }
}

// GetBuilder (less performant but simpler)
GetBuilder<CounterController>(
  init: CounterController(),
  builder: (controller) {
    return Text('Count: ${controller.count}');
  },
)
```

---

## Navigation & Routing

### Basic Navigation

```dart
// Navigate to new screen
Navigator.push(
  context,
  MaterialPageRoute(builder: (context) => SecondScreen()),
);

// Go back
Navigator.pop(context);

// Pop and return data
Navigator.pop(context, 'Result data');

// Push and get result
final result = await Navigator.push(
  context,
  MaterialPageRoute(builder: (context) => SecondScreen()),
);
print('Got result: $result');

// Replace current screen
Navigator.pushReplacement(
  context,
  MaterialPageRoute(builder: (context) => NewScreen()),
);

// Remove all and push
Navigator.pushAndRemoveUntil(
  context,
  MaterialPageRoute(builder: (context) => HomeScreen()),
  (route) => false, // Remove all previous routes
);

// Custom transition
Navigator.push(
  context,
  PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => SecondScreen(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(opacity: animation, child: child);
    },
  ),
);
```

### Named Routes

```dart
// Define routes
void main() {
  runApp(
    MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(),
        '/second': (context) => SecondScreen(),
        '/third': (context) => ThirdScreen(),
      },
    ),
  );
}

// Navigate using name
Navigator.pushNamed(context, '/second');

// Pass arguments
Navigator.pushNamed(
  context,
  '/second',
  arguments: {'id': 123, 'name': 'John'},
);

// Receive arguments
class SecondScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    return Text('ID: ${args['id']}');
  }
}

// onGenerateRoute for dynamic routes
MaterialApp(
  onGenerateRoute: (settings) {
    if (settings.name == '/user') {
      final userId = settings.arguments as String;
      return MaterialPageRoute(
        builder: (context) => UserScreen(userId: userId),
      );
    }
    return null;
  },
)
```

### Navigator 2.0 (Declarative Routing)

```dart
import 'package:flutter/material.dart';

class MyRouterDelegate extends RouterDelegate<String>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<String> {
  @override
  final GlobalKey<NavigatorState> navigatorKey;
  
  String? _selectedRoute;
  
  MyRouterDelegate() : navigatorKey = GlobalKey<NavigatorState>();
  
  @override
  String? get currentConfiguration => _selectedRoute;
  
  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      pages: [
        const MaterialPage(child: HomeScreen()),
        if (_selectedRoute != null)
          MaterialPage(child: DetailScreen(route: _selectedRoute!)),
      ],
      onPopPage: (route, result) {
        if (!route.didPop(result)) return false;
        _selectedRoute = null;
        notifyListeners();
        return true;
      },
    );
  }
  
  @override
  Future<void> setNewRoutePath(String configuration) async {
    _selectedRoute = configuration;
  }
  
  void selectRoute(String route) {
    _selectedRoute = route;
    notifyListeners();
  }
}

// Use in MaterialApp.router
MaterialApp.router(
  routerDelegate: MyRouterDelegate(),
  routeInformationParser: MyRouteInformationParser(),
)
```

### Go Router (Recommended)

```dart
// pubspec.yaml
// dependencies:
//   go_router: ^6.0.0

import 'package:go_router/go_router.dart';

// Define routes
final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/user/:id',
      builder: (context, state) {
        final id = state.params['id']!;
        return UserScreen(userId: id);
      },
    ),
    GoRoute(
      path: '/settings',
      builder: (context, state) => const SettingsScreen(),
      routes: [
        // Nested route: /settings/profile
        GoRoute(
          path: 'profile',
          builder: (context, state) => const ProfileScreen(),
        ),
      ],
    ),
  ],
  errorBuilder: (context, state) => const NotFoundScreen(),
);

// Use in app
MaterialApp.router(
  routerConfig: router,
)

// Navigate
context.go('/user/123');           // Replace current
context.push('/settings');         // Push new
context.pop();                     // Go back

// With query parameters
context.go('/search?q=flutter');

// Access query params
final query = state.queryParams['q'];
```

---

## Networking & APIs

### HTTP Package

```dart
// pubspec.yaml
// dependencies:
//   http: ^0.13.0

import 'package:http/http.dart' as http;
import 'dart:convert';

// GET request
Future<User> fetchUser(int id) async {
  final response = await http.get(
    Uri.parse('https://api.example.com/users/$id'),
  );
  
  if (response.statusCode == 200) {
    return User.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load user');
  }
}

// POST request
Future<User> createUser(String name, String email) async {
  final response = await http.post(
    Uri.parse('https://api.example.com/users'),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({
      'name': name,
      'email': email,
    }),
  );
  
  if (response.statusCode == 201) {
    return User.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to create user');
  }
}

// PUT request
Future<User> updateUser(int id, String name) async {
  final response = await http.put(
    Uri.parse('https://api.example.com/users/$id'),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({'name': name}),
  );
  
  return User.fromJson(jsonDecode(response.body));
}

// DELETE request
Future<void> deleteUser(int id) async {
  await http.delete(
    Uri.parse('https://api.example.com/users/$id'),
  );
}

// Model class
class User {
  final int id;
  final String name;
  final String email;
  
  User({required this.id, required this.name, required this.email});
  
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
    };
  }
}

// Use in widget
class UserListScreen extends StatefulWidget {
  @override
  State<UserListScreen> createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  late Future<User> futureUser;
  
  @override
  void initState() {
    super.initState();
    futureUser = fetchUser(1);
  }
  
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<User>(
      future: futureUser,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Text(snapshot.data!.name);
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }
        return const CircularProgressIndicator();
      },
    );
  }
}
```

### Dio (Advanced HTTP Client)

```dart
// pubspec.yaml
// dependencies:
//   dio: ^5.0.0

import 'package:dio/dio.dart';

// Create Dio instance
final dio = Dio(
  BaseOptions(
    baseUrl: 'https://api.example.com',
    connectTimeout: const Duration(seconds: 5),
    receiveTimeout: const Duration(seconds: 3),
    headers: {
      'Authorization': 'Bearer token',
    },
  ),
);

// Interceptors
dio.interceptors.add(
  InterceptorsWrapper(
    onRequest: (options, handler) {
      print('Sending request: ${options.path}');
      return handler.next(options);
    },
    onResponse: (response, handler) {
      print('Received response: ${response.statusCode}');
      return handler.next(response);
    },
    onError: (error, handler) {
      print('Error: ${error.message}');
      return handler.next(error);
    },
  ),
);

// GET
Future<User> getUser(int id) async {
  try {
    final response = await dio.get('/users/$id');
    return User.fromJson(response.data);
  } on DioException catch (e) {
    throw Exception('Failed: ${e.message}');
  }
}

// POST with progress
Future<void> uploadFile(File file) async {
  FormData formData = FormData.fromMap({
    'file': await MultipartFile.fromFile(file.path),
  });
  
  await dio.post(
    '/upload',
    data: formData,
    onSendProgress: (sent, total) {
      print('Progress: ${(sent / total * 100).toStringAsFixed(0)}%');
    },
  );
}

// Cancel requests
CancelToken cancelToken = CancelToken();

dio.get('/users', cancelToken: cancelToken);

// Cancel it
cancelToken.cancel('Cancelled by user');
```

### API Service Pattern

```dart
class ApiService {
  final Dio _dio = Dio(
    BaseOptions(baseUrl: 'https://api.example.com'),
  );
  
  // Singleton pattern
  static final ApiService _instance = ApiService._internal();
  factory ApiService() => _instance;
  ApiService._internal();
  
  Future<List<User>> getUsers() async {
    try {
      final response = await _dio.get('/users');
      return (response.data as List)
          .map((json) => User.fromJson(json))
          .toList();
    } catch (e) {
      rethrow;
    }
  }
  
  Future<User> getUser(int id) async {
    final response = await _dio.get('/users/$id');
    return User.fromJson(response.data);
  }
  
  Future<User> createUser(User user) async {
    final response = await _dio.post('/users', data: user.toJson());
    return User.fromJson(response.data);
  }
}

// Usage
final apiService = ApiService();
final users = await apiService.getUsers();
```

---

## Local Storage

### Shared Preferences

```dart
// pubspec.yaml
// dependencies:
//   shared_preferences: ^2.0.0

import 'package:shared_preferences/shared_preferences.dart';

// Save data
Future<void> saveData() async {
  final prefs = await SharedPreferences.getInstance();
  
  await prefs.setString('username', 'john_doe');
  await prefs.setInt('age', 25);
  await prefs.setBool('isDarkMode', true);
  await prefs.setDouble('score', 95.5);
  await prefs.setStringList('favorites', ['flutter', 'dart']);
}

// Read data
Future<void> loadData() async {
  final prefs = await SharedPreferences.getInstance();
  
  String? username = prefs.getString('username');
  int? age = prefs.getInt('age');
  bool? isDarkMode = prefs.getBool('isDarkMode') ?? false;
  List<String>? favorites = prefs.getStringList('favorites');
}

// Remove data
Future<void> clearData() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.remove('username');
  await prefs.clear(); // Remove all
}

// Check if key exists
final hasKey = prefs.containsKey('username');
```

### SQLite Database

```dart
// pubspec.yaml
// dependencies:
//   sqflite: ^2.0.0
//   path: ^1.8.0

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

// Database helper
class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();
  
  static Database? _database;
  
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }
  
  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'app_database.db');
    
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE users(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT NOT NULL,
            email TEXT NOT NULL,
            age INTEGER
          )
        ''');
      },
    );
  }
  
  // Insert
  Future<int> insertUser(Map<String, dynamic> user) async {
    Database db = await database;
    return await db.insert('users', user);
  }
  
  // Query all
  Future<List<Map<String, dynamic>>> getAllUsers() async {
    Database db = await database;
    return await db.query('users');
  }
  
  // Query with WHERE
  Future<List<Map<String, dynamic>>> getUser(int id) async {
    Database db = await database;
    return await db.query(
      'users',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
  
  // Update
  Future<int> updateUser(Map<String, dynamic> user) async {
    Database db = await database;
    return await db.update(
      'users',
      user,
      where: 'id = ?',
      whereArgs: [user['id']],
    );
  }
  
  // Delete
  Future<int> deleteUser(int id) async {
    Database db = await database;
    return await db.delete(
      'users',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}

// Usage
final dbHelper = DatabaseHelper();

// Insert
await dbHelper.insertUser({
  'name': 'John',
  'email': 'john@example.com',
  'age': 25,
});

// Query
List<Map<String, dynamic>> users = await dbHelper.getAllUsers();
```

### Hive (NoSQL)

```dart
// pubspec.yaml
// dependencies:
//   hive: ^2.2.0
//   hive_flutter: ^1.1.0
// dev_dependencies:
//   hive_generator: ^2.0.0
//   build_runner: ^2.3.0

import 'package:hive_flutter/hive_flutter.dart';

// 1. Initialize Hive
void main() async {
  await Hive.initFlutter();
  await Hive.openBox('myBox');
  runApp(MyApp());
}

// 2. Simple key-value storage
var box = Hive.box('myBox');

// Write
box.put('name', 'John');
box.put('age', 25);
box.put('user', {'name': 'John', 'email': 'john@email.com'});

// Read
String name = box.get('name', defaultValue: 'Guest');
int? age = box.get('age');

// Delete
box.delete('name');
box.clear(); // Delete all

// 3. Type adapters for custom objects
@HiveType(typeId: 0)
class Person extends HiveObject {
  @HiveField(0)
  final String name;
  
  @HiveField(1)
  final int age;
  
  Person(this.name, this.age);
}

// Generate adapter: flutter packages pub run build_runner build

// Register and use
void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(PersonAdapter());
  await Hive.openBox<Person>('persons');
  runApp(MyApp());
}

var personBox = Hive.box<Person>('persons');
personBox.add(Person('John', 25));
Person? person = personBox.getAt(0);

// 4. Watch for changes
ValueListenableBuilder(
  valueListenable: box.listenable(),
  builder: (context, Box box, widget) {
    return Text(box.get('name', defaultValue: 'Guest'));
  },
)
```

---

## Animations

### Implicit Animations (Automatic)

```dart
// AnimatedContainer
AnimatedContainer(
  duration: const Duration(milliseconds: 300),
  width: _isExpanded ? 200 : 100,
  height: _isExpanded ? 200 : 100,
  color: _isExpanded ? Colors.blue : Colors.red,
  curve: Curves.easeInOut,
  child: const Text('Tap me'),
)

// AnimatedOpacity
AnimatedOpacity(
  opacity: _isVisible ? 1.0 : 0.0,
  duration: const Duration(milliseconds: 500),
  child: const Text('Fading text'),
)

// AnimatedPositioned (inside Stack)
Stack(
  children: [
    AnimatedPositioned(
      duration: const Duration(milliseconds: 300),
      left: _isMoved ? 100 : 0,
      top: _isMoved ? 100 : 0,
      child: Container(width: 50, height: 50, color: Colors.blue),
    ),
  ],
)

// AnimatedAlign
AnimatedAlign(
  duration: const Duration(milliseconds: 300),
  alignment: _isRight ? Alignment.centerRight : Alignment.centerLeft,
  child: const FlutterLogo(size: 50),
)

// AnimatedCrossFade
AnimatedCrossFade(
  duration: const Duration(milliseconds: 300),
  firstChild: const Icon(Icons.favorite_border),
  secondChild: const Icon(Icons.favorite),
  crossFadeState: _isFavorite 
      ? CrossFadeState.showSecond 
      : CrossFadeState.showFirst,
)

// AnimatedSwitcher
AnimatedSwitcher(
  duration: const Duration(milliseconds: 500),
  child: Text(
    _count.toString(),
    key: ValueKey<int>(_count), // Key required for switching
    style: const TextStyle(fontSize: 48),
  ),
)
```

### Explicit Animations (Manual Control)

```dart
class MyAnimation extends StatefulWidget {
  @override
  State<MyAnimation> createState() => _MyAnimationState();
}

class _MyAnimationState extends State<MyAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  
  @override
  void initState() {
    super.initState();
    
    // 1. Create controller
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    
    // 2. Create animation
    _animation = Tween<double>(begin: 0, end: 300).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
    
    // 3. Listen to changes
    _animation.addListener(() {
      setState(() {}); // Rebuild on each frame
    });
    
    // 4. Listen to status
    _animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller.reverse();
      } else if (status == AnimationStatus.dismissed) {
        _controller.forward();
      }
    });
    
    // Start animation
    _controller.forward();
  }
  
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Container(
      width: _animation.value,
      height: _animation.value,
      color: Colors.blue,
    );
  }
}

// Using AnimatedBuilder (better performance)
class BetterAnimation extends StatefulWidget {
  @override
  State<BetterAnimation> createState() => _BetterAnimationState();
}

class _BetterAnimationState extends State<BetterAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _sizeAnimation;
  late Animation<Color?> _colorAnimation;
  
  @override
  void initState() {
    super.initState();
    
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);
    
    _sizeAnimation = Tween<double>(begin: 50, end: 200).animate(_controller);
    
    _colorAnimation = ColorTween(
      begin: Colors.blue,
      end: Colors.red,
    ).animate(_controller);
  }
  
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Container(
          width: _sizeAnimation.value,
          height: _sizeAnimation.value,
          color: _colorAnimation.value,
          child: child, // Static child doesn't rebuild
        );
      },
      child: const Center(
        child: Text('Animating'),
      ),
    );
  }
}
```

### Hero Animations

```dart
// First screen
Hero(
  tag: 'hero-image',
  child: Image.network('https://example.com/image.jpg'),
)

// Second screen (same tag)
Hero(
  tag: 'hero-image',
  child: Image.network('https://example.com/image.jpg'),
)

// Navigate between screens
Navigator.push(
  context,
  MaterialPageRoute(builder: (_) => SecondScreen()),
);
```

### Custom Animations

```dart
// Staggered animations
class StaggeredAnimation extends StatefulWidget {
  @override
  State<StaggeredAnimation> createState() => _StaggeredAnimationState();
}

class _StaggeredAnimationState extends State<StaggeredAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacity;
  late Animation<double> _width;
  late Animation<double> _height;
  
  @override
  void initState() {
    super.initState();
    
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    
    _opacity = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.3, curve: Curves.ease),
      ),
    );
    
    _width = Tween<double>(begin: 50, end: 200).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.3, 0.6, curve: Curves.ease),
      ),
    );
    
    _height = Tween<double>(begin: 50, end: 200).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.6, 1.0, curve: Curves.ease),
      ),
    );
    
    _controller.forward();
  }
  
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Opacity(
          opacity: _opacity.value,
          child: Container(
            width: _width.value,
            height: _height.value,
            color: Colors.blue,
          ),
        );
      },
    );
  }
  
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
```

---

## Performance Optimization

### Widget Optimization

```dart
// 1. Use const constructors
const Text('Hello');
const SizedBox(height: 10);

// 2. Extract widgets to avoid rebuilds
class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const ExpensiveWidget(), // Won't rebuild
        CheapWidget(),
      ],
    );
  }
}

// 3. Use keys for lists
ListView.builder(
  itemBuilder: (context, index) {
    return ListTile(
      key: ValueKey(items[index].id), // Important for reordering
      title: Text(items[index].name),
    );
  },
)

// 4. Avoid anonymous functions in build
// Bad
ElevatedButton(
  onPressed: () {
    print('Pressed');
  },
  child: const Text('Press'),
)

// Good
void _handlePress() {
  print('Pressed');
}

ElevatedButton(
  onPressed: _handlePress,
  child: const Text('Press'),
)

// 5. Use ListView.builder for large lists
// Don't use ListView(children: [...]) for many items
ListView.builder(
  itemCount: 1000,
  itemBuilder: (context, index) {
    return ListTile(title: Text('Item $index'));
  },
)

// 6. Separate expensive computations
Future<List<Data>> _expensiveComputation() async {
  return await compute(processData, rawData);
}

// 7. Use RepaintBoundary for complex widgets
RepaintBoundary(
  child: ComplexWidget(),
)
```

### Image Optimization

```dart
// 1. Cache network images
Image.network(
  'https://example.com/image.jpg',
  cacheWidth: 400,  // Resize to save memory
  cacheHeight: 300,
)

// 2. Use cached_network_image package
CachedNetworkImage(
  imageUrl: 'https://example.com/image.jpg',
  placeholder: (context, url) => CircularProgressIndicator(),
  errorWidget: (context, url, error) => Icon(Icons.error),
)

// 3. Use appropriate image formats
// WebP for photos, SVG for icons

// 4. Load images based on screen density
Image.asset(
  'assets/images/logo.png',
  // Automatically loads logo.png, logo@2x.png, logo@3x.png
)
```

### Memory Management

```dart
// 1. Dispose controllers
@override
void dispose() {
  _textController.dispose();
  _scrollController.dispose();
  _animationController.dispose();
  _streamSubscription.cancel();
  super.dispose();
}

// 2. Use AutomaticKeepAliveClientMixin for TabViews
class MyTab extends StatefulWidget {
  @override
  State<MyTab> createState() => _MyTabState();
}

class _MyTabState extends State<MyTab>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  
  @override
  Widget build(BuildContext context) {
    super.build(context); // Required
    return Text('Tab content');
  }
}

// 3. Use addPostFrameCallback for after-build operations
@override
void initState() {
  super.initState();
  WidgetsBinding.instance.addPostFrameCallback((_) {
    // Execute after first frame
  });
}
```

### Performance Monitoring

```dart
// 1. Performance overlay
MaterialApp(
  showPerformanceOverlay: true,
  // ...
)

// 2. Timeline events
import 'dart:developer';

Timeline.startSync('expensive_operation');
// Do work
Timeline.finishSync();

// 3. Measure widget build time
@override
Widget build(BuildContext context) {
  return PerformanceOverlay.allEnabled();
}
```

---

## Testing

### Unit Tests

```dart
// test/counter_test.dart
import 'package:test/test.dart';

class Counter {
  int value = 0;
  void increment() => value++;
  void decrement() => value--;
}

void main() {
  group('Counter tests', () {
    late Counter counter;
    
    setUp(() {
      counter = Counter();
    });
    
    test('initial value is 0', () {
      expect(counter.value, 0);
    });
    
    test('increment increases value', () {
      counter.increment();
      expect(counter.value, 1);
    });
    
    test('decrement decreases value', () {
      counter.decrement();
      expect(counter.value, -1);
    });
  });
  
  // Async test
  test('async operation', () async {
    final result = await Future.delayed(
      Duration(seconds: 1),
      () => 'done',
    );
    expect(result, 'done');
  });
}

// Run: flutter test test/counter_test.dart
```

### Widget Tests

```dart
// test/widget_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';

void main() {
  testWidgets('Counter increments', (WidgetTester tester) async {
    // Build widget
    await tester.pumpWidget(
      MaterialApp(
        home: CounterScreen(),
      ),
    );
    
    // Verify initial state
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);
    
    // Tap button
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump(); // Rebuild widget
    
    // Verify updated state
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });
  
  testWidgets('Find widgets by key', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Container(
            key: const Key('myContainer'),
            child: const Text('Hello'),
          ),
        ),
      ),
    );
    
    expect(find.byKey(const Key('myContainer')), findsOneWidget);
    expect(find.text('Hello'), findsOneWidget);
  });
  
  testWidgets('Scroll test', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: ListView.builder(
          itemCount: 100,
          itemBuilder: (context, index) {
            return Text('Item $index');
          },
        ),
      ),
    );
    
    // Scroll
    await tester.drag(find.byType(ListView), const Offset(0, -300));
    await tester.pump();
    
    expect(find.text('Item 50'), findsOneWidget);
  });
}
```

### Integration Tests

```dart
// integration_test/app_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:my_app/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  
  testWidgets('full app test', (tester) async {
    app.main();
    await tester.pumpAndSettle();
    
    // Login flow
    await tester.enterText(
      find.byKey(const Key('emailField')),
      'test@example.com',
    );
    await tester.enterText(
      find.byKey(const Key('passwordField')),
      'password123',
    );
    await tester.tap(find.text('Login'));
    await tester.pumpAndSettle();
    
    // Verify navigation
    expect(find.text('Home Screen'), findsOneWidget);
  });
}

// Run: flutter test integration_test/app_test.dart
```

### Mocking

```dart
// pubspec.yaml
// dev_dependencies:
//   mockito: ^5.0.0
//   build_runner: ^2.0.0

import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

// Original class
class ApiService {
  Future<String> fetchData() async {
    // Real implementation
    return 'real data';
  }
}

// Generate mock: flutter pub run build_runner build
@GenerateMocks([ApiService])
import 'api_test.mocks.dart';

void main() {
  test('mock api call', () async {
    final mockApi = MockApiService();
    
    // Setup mock behavior
    when(mockApi.fetchData()).thenAnswer((_) async => 'mock data');
    
    // Use mock
    final result = await mockApi.fetchData();
    expect(result, 'mock data');
    
    // Verify called
    verify(mockApi.fetchData()).called(1);
  });
}
```

---

## Best Practices

### Code Organization

```
lib/
  ├── main.dart
  ├── app.dart
  ├── core/
  │   ├── constants/
  │   ├── utils/
  │   └── extensions/
  ├── data/
  │   ├── models/
  │   ├── repositories/
  │   └── services/
  ├── presentation/
  │   ├── screens/
  │   ├── widgets/
  │   └── providers/
  └── routes/
```

### Naming Conventions

```dart
// Classes: PascalCase
class UserProfile {}

// Variables, functions: camelCase
String userName = 'John';
void fetchData() {}

// Constants: lowerCamelCase
const double pi = 3.14159;

// Private: prefix with _
class _PrivateClass {}
String _privateVariable = 'secret';

// Files: snake_case
// user_profile.dart
// api_service.dart
```

### Error Handling

```dart
// Try-catch
try {
  final result = await riskyOperation();
  print(result);
} on NetworkException catch (e) {
  print('Network error: $e');
} on FormatException catch (e) {
  print('Format error: $e');
} catch (e) {
  print('Unknown error: $e');
} finally {
  print('Always executes');
}

// Result pattern
class Result<T> {
  final T? data;
  final String? error;
  
  Result.success(this.data) : error = null;
  Result.failure(this.error) : data = null;
  
  bool get isSuccess => data != null;
  bool get isFailure => error != null;
}

Future<Result<User>> getUser() async {
  try {
    final user = await api.fetchUser();
    return Result.success(user);
  } catch (e) {
    return Result.failure(e.toString());
  }
}
```

### Responsive Design

```dart
// MediaQuery
final size = MediaQuery.of(context).size;
final width = size.width;
final height = size.height;
final orientation = MediaQuery.of(context).orientation;

// LayoutBuilder
LayoutBuilder(
  builder: (context, constraints) {
    if (constraints.maxWidth > 600) {
      return DesktopLayout();
    } else {
      return MobileLayout();
    }
  },
)

// OrientationBuilder
OrientationBuilder(
  builder: (context, orientation) {
    return orientation == Orientation.portrait
        ? PortraitLayout()
        : LandscapeLayout();
  },
)

// Responsive values
double responsiveFont(BuildContext context) {
  final width = MediaQuery.of(context).size.width;
  if (width > 600) return 24;
  if (width > 400) return 18;
  return 14;
}
```

### Accessibility

```dart
// Semantic widgets
Semantics(
  label: 'Profile picture',
  child: Image.asset('profile.jpg'),
)

// Exclude from semantics
ExcludeSemantics(
  child: DecorativeImage(),
)

// Merge semantics
MergeSemantics(
  child: Row(
    children: [
      Icon(Icons.person),
      Text('John Doe'),
    ],
  ),
)

// Screen reader hints
Tooltip(
  message: 'Add to favorites',
  child: IconButton(
    icon: Icon(Icons.favorite),
    onPressed: () {},
  ),
)
```

### Security

```dart
// Environment variables
// .env file (don't commit)
API_KEY=your_secret_key

// Use with flutter_dotenv
import 'package:flutter_dotenv/flutter_dotenv.dart';

await dotenv.load();
String apiKey = dotenv.env['API_KEY']!;

// Secure storage
// pubspec.yaml: flutter_secure_storage: ^8.0.0
final storage = FlutterSecureStorage();

await storage.write(key: 'token', value: 'secret_token');
String? token = await storage.read(key: 'token');
await storage.delete(key: 'token');

// Input validation
String? validateEmail(String? value) {
  if (value == null || value.isEmpty) {
    return 'Email required';
  }
  final regex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  if (!regex.hasMatch(value)) {
    return 'Invalid email';
  }
  return null;
}

TextFormField(
  validator: validateEmail,
  // ...
)
```

---

## Ready-Made Widget Templates

### Template 1: StatefulWidget with Persistent Icon Toggle

```dart
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Persistent favorite icon that saves state across app restarts
class PersistentFavoriteIcon extends StatefulWidget {
  final String itemId; // Unique identifier for this item
  final VoidCallback? onToggle;
  
  const PersistentFavoriteIcon({
    Key? key,
    required this.itemId,
    this.onToggle,
  }) : super(key: key);

  @override
  State<PersistentFavoriteIcon> createState() => _PersistentFavoriteIconState();
}

class _PersistentFavoriteIconState extends State<PersistentFavoriteIcon>
    with SingleTickerProviderStateMixin {
  bool _isFavorite = false;
  bool _isLoading = true;
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _setupAnimation();
    _loadFavoriteState();
  }

  void _setupAnimation() {
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.3).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );
  }

  Future<void> _loadFavoriteState() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _isFavorite = prefs.getBool('favorite_${widget.itemId}') ?? false;
      _isLoading = false;
    });
  }

  Future<void> _toggleFavorite() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _isFavorite = !_isFavorite;
    });
    
    await prefs.setBool('favorite_${widget.itemId}', _isFavorite);
    
    // Trigger animation
    _animationController.forward().then((_) {
      _animationController.reverse();
    });
    
    // Call callback if provided
    widget.onToggle?.call();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const SizedBox(
        width: 24,
        height: 24,
        child: CircularProgressIndicator(strokeWidth: 2),
      );
    }

    return ScaleTransition(
      scale: _scaleAnimation,
      child: IconButton(
        icon: Icon(
          _isFavorite ? Icons.favorite : Icons.favorite_border,
          color: _isFavorite ? Colors.red : Colors.grey,
        ),
        onPressed: _toggleFavorite,
      ),
    );
  }
}

// Usage:
// PersistentFavoriteIcon(
//   itemId: 'product_123',
//   onToggle: () => print('Favorite toggled!'),
// )
```

### Template 2: Reusable Form Field with Validation

```dart
import 'package:flutter/material.dart';

/// Reusable text field with built-in validation and error handling
class CustomTextField extends StatefulWidget {
  final String label;
  final String? hint;
  final IconData? prefixIcon;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final bool obscureText;
  final int? maxLines;
  final void Function(String)? onChanged;
  
  const CustomTextField({
    Key? key,
    required this.label,
    this.hint,
    this.prefixIcon,
    this.controller,
    this.validator,
    this.keyboardType,
    this.obscureText = false,
    this.maxLines = 1,
    this.onChanged,
  }) : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late TextEditingController _internalController;
  bool _obscureText = false;
  String? _errorText;

  @override
  void initState() {
    super.initState();
    _internalController = widget.controller ?? TextEditingController();
    _obscureText = widget.obscureText;
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _internalController.dispose();
    }
    super.dispose();
  }

  void _validate(String value) {
    if (widget.validator != null) {
      setState(() {
        _errorText = widget.validator!(value);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: _internalController,
          obscureText: _obscureText,
          keyboardType: widget.keyboardType,
          maxLines: widget.obscureText ? 1 : widget.maxLines,
          decoration: InputDecoration(
            hintText: widget.hint,
            prefixIcon: widget.prefixIcon != null 
                ? Icon(widget.prefixIcon) 
                : null,
            suffixIcon: widget.obscureText
                ? IconButton(
                    icon: Icon(
                      _obscureText ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                  )
                : null,
            errorText: _errorText,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.blue, width: 2),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.red, width: 2),
            ),
          ),
          onChanged: (value) {
            _validate(value);
            widget.onChanged?.call(value);
          },
          validator: widget.validator,
        ),
      ],
    );
  }
}

// Usage:
// CustomTextField(
//   label: 'Email',
//   hint: 'Enter your email',
//   prefixIcon: Icons.email,
//   keyboardType: TextInputType.emailAddress,
//   validator: (value) {
//     if (value == null || value.isEmpty) return 'Email is required';
//     if (!value.contains('@')) return 'Invalid email';
//     return null;
//   },
// )
```

### Template 3: Loading Button with States

```dart
import 'package:flutter/material.dart';

/// Button with loading, success, and error states
class LoadingButton extends StatefulWidget {
  final String text;
  final Future<bool> Function() onPressed;
  final Color? color;
  final IconData? icon;
  
  const LoadingButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.color,
    this.icon,
  }) : super(key: key);

  @override
  State<LoadingButton> createState() => _LoadingButtonState();
}

enum ButtonState { idle, loading, success, error }

class _LoadingButtonState extends State<LoadingButton> {
  ButtonState _state = ButtonState.idle;

  Future<void> _handlePress() async {
    if (_state == ButtonState.loading) return;

    setState(() => _state = ButtonState.loading);

    try {
      final success = await widget.onPressed();
      
      setState(() {
        _state = success ? ButtonState.success : ButtonState.error;
      });

      // Reset to idle after showing result
      await Future.delayed(const Duration(seconds: 2));
      if (mounted) {
        setState(() => _state = ButtonState.idle);
      }
    } catch (e) {
      setState(() => _state = ButtonState.error);
      await Future.delayed(const Duration(seconds: 2));
      if (mounted) {
        setState(() => _state = ButtonState.idle);
      }
    }
  }

  Color _getButtonColor() {
    switch (_state) {
      case ButtonState.loading:
        return Colors.grey;
      case ButtonState.success:
        return Colors.green;
      case ButtonState.error:
        return Colors.red;
      default:
        return widget.color ?? Theme.of(context).primaryColor;
    }
  }

  Widget _getButtonChild() {
    switch (_state) {
      case ButtonState.loading:
        return const SizedBox(
          width: 20,
          height: 20,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          ),
        );
      case ButtonState.success:
        return const Icon(Icons.check, color: Colors.white);
      case ButtonState.error:
        return const Icon(Icons.error_outline, color: Colors.white);
      default:
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (widget.icon != null) ...[
              Icon(widget.icon, size: 20),
              const SizedBox(width: 8),
            ],
            Text(
              widget.text,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      child: ElevatedButton(
        onPressed: _state == ButtonState.idle ? _handlePress : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: _getButtonColor(),
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: _getButtonChild(),
      ),
    );
  }
}

// Usage:
// LoadingButton(
//   text: 'Submit',
//   icon: Icons.send,
//   onPressed: () async {
//     await Future.delayed(Duration(seconds: 2));
//     return true; // Return true for success, false for error
//   },
// )
```

### Template 4: Animated List Item with Swipe Actions

```dart
import 'package:flutter/material.dart';

/// List item with swipe-to-delete and swipe-to-edit actions
class SwipeableListItem extends StatefulWidget {
  final Widget child;
  final VoidCallback? onDelete;
  final VoidCallback? onEdit;
  final Color deleteColor;
  final Color editColor;
  
  const SwipeableListItem({
    Key? key,
    required this.child,
    this.onDelete,
    this.onEdit,
    this.deleteColor = Colors.red,
    this.editColor = Colors.blue,
  }) : super(key: key);

  @override
  State<SwipeableListItem> createState() => _SwipeableListItemState();
}

class _SwipeableListItemState extends State<SwipeableListItem>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _handleDelete() async {
    await _controller.reverse();
    widget.onDelete?.call();
  }

  @override
  Widget build(BuildContext context) {
    return SizeTransition(
      sizeFactor: _animation,
      child: Dismissible(
        key: UniqueKey(),
        background: Container(
          color: widget.editColor,
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.only(left: 20),
          child: const Icon(Icons.edit, color: Colors.white, size: 28),
        ),
        secondaryBackground: Container(
          color: widget.deleteColor,
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.only(right: 20),
          child: const Icon(Icons.delete, color: Colors.white, size: 28),
        ),
        confirmDismiss: (direction) async {
          if (direction == DismissDirection.endToStart) {
            // Swiped left - delete
            return await showDialog<bool>(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('Confirm Delete'),
                content: const Text('Are you sure you want to delete this item?'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context, false),
                    child: const Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () => Navigator.pop(context, true),
                    child: const Text('Delete', style: TextStyle(color: Colors.red)),
                  ),
                ],
              ),
            ) ?? false;
          } else {
            // Swiped right - edit
            widget.onEdit?.call();
            return false; // Don't dismiss
          }
        },
        onDismissed: (direction) {
          if (direction == DismissDirection.endToStart) {
            _handleDelete();
          }
        },
        child: widget.child,
      ),
    );
  }
}

// Usage:
// ListView.builder(
//   itemCount: items.length,
//   itemBuilder: (context, index) {
//     return SwipeableListItem(
//       onDelete: () => setState(() => items.removeAt(index)),
//       onEdit: () => _editItem(items[index]),
//       child: ListTile(
//         title: Text(items[index].name),
//         subtitle: Text(items[index].description),
//       ),
//     );
//   },
// )
```

### Template 5: Bottom Sheet Modal

```dart
import 'package:flutter/material.dart';

/// Reusable bottom sheet with customizable content
class CustomBottomSheet extends StatelessWidget {
  final String title;
  final Widget content;
  final List<Widget>? actions;
  final bool isDismissible;
  
  const CustomBottomSheet({
    Key? key,
    required this.title,
    required this.content,
    this.actions,
    this.isDismissible = true,
  }) : super(key: key);

  static Future<T?> show<T>({
    required BuildContext context,
    required String title,
    required Widget content,
    List<Widget>? actions,
    bool isDismissible = true,
  }) {
    return showModalBottomSheet<T>(
      context: context,
      isDismissible: isDismissible,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => CustomBottomSheet(
        title: title,
        content: content,
        actions: actions,
        isDismissible: isDismissible,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle bar
          Container(
            margin: const EdgeInsets.only(top: 12),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          // Title
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (isDismissible)
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
              ],
            ),
          ),
          const Divider(height: 1),
          // Content
          Flexible(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: content,
            ),
          ),
          // Actions
          if (actions != null) ...[
            const Divider(height: 1),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: actions!,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

// Usage:
// CustomBottomSheet.show(
//   context: context,
//   title: 'Filter Options',
//   content: Column(
//     children: [
//       CheckboxListTile(
//         title: Text('Option 1'),
//         value: true,
//         onChanged: (value) {},
//       ),
//       CheckboxListTile(
//         title: Text('Option 2'),
//         value: false,
//         onChanged: (value) {},
//       ),
//     ],
//   ),
//   actions: [
//     TextButton(
//       onPressed: () => Navigator.pop(context),
//       child: Text('Cancel'),
//     ),
//     ElevatedButton(
//       onPressed: () {
//         // Apply filters
//         Navigator.pop(context);
//       },
//       child: Text('Apply'),
//     ),
//   ],
// );
```

### Template 6: Search Bar with Debouncing

```dart
import 'package:flutter/material.dart';
import 'dart:async';

/// Search bar with debouncing to reduce API calls
class DebouncedSearchBar extends StatefulWidget {
  final String hint;
  final void Function(String) onSearch;
  final Duration debounceDuration;
  final Widget Function(String)? suffixBuilder;
  
  const DebouncedSearchBar({
    Key? key,
    this.hint = 'Search...',
    required this.onSearch,
    this.debounceDuration = const Duration(milliseconds: 500),
    this.suffixBuilder,
  }) : super(key: key);

  @override
  State<DebouncedSearchBar> createState() => _DebouncedSearchBarState();
}

class _DebouncedSearchBarState extends State<DebouncedSearchBar> {
  final TextEditingController _controller = TextEditingController();
  Timer? _debounce;
  bool _isSearching = false;

  @override
  void dispose() {
    _debounce?.cancel();
    _controller.dispose();
    super.dispose();
  }

  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    
    setState(() => _isSearching = query.isNotEmpty);
    
    _debounce = Timer(widget.debounceDuration, () {
      widget.onSearch(query);
      setState(() => _isSearching = false);
    });
  }

  void _clearSearch() {
    _controller.clear();
    widget.onSearch('');
    setState(() => _isSearching = false);
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      onChanged: _onSearchChanged,
      decoration: InputDecoration(
        hintText: widget.hint,
        prefixIcon: const Icon(Icons.search),
        suffixIcon: _isSearching
            ? const SizedBox(
                width: 20,
                height: 20,
                child: Padding(
                  padding: EdgeInsets.all(12),
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
              )
            : _controller.text.isNotEmpty
                ? IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: _clearSearch,
                  )
                : widget.suffixBuilder?.call(_controller.text),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: Colors.grey[200],
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      ),
    );
  }
}

// Usage:
// DebouncedSearchBar(
//   hint: 'Search products...',
//   onSearch: (query) async {
//     print('Searching for: $query');
//     // Call API or filter list
//     final results = await searchAPI(query);
//     setState(() => searchResults = results);
//   },
//   debounceDuration: Duration(milliseconds: 800),
// )
```

### Template 7: Pull to Refresh List

```dart
import 'package:flutter/material.dart';

/// List with pull-to-refresh functionality
class RefreshableList<T> extends StatefulWidget {
  final Future<List<T>> Function() onRefresh;
  final Widget Function(BuildContext, T, int) itemBuilder;
  final Widget? emptyWidget;
  final Widget? errorWidget;
  
  const RefreshableList({
    Key? key,
    required this.onRefresh,
    required this.itemBuilder,
    this.emptyWidget,
    this.errorWidget,
  }) : super(key: key);

  @override
  State<RefreshableList<T>> createState() => _RefreshableListState<T>();
}

class _RefreshableListState<T> extends State<RefreshableList<T>> {
  List<T> _items = [];
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final items = await widget.onRefresh();
      setState(() {
        _items = items;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_error != null) {
      return widget.errorWidget ??
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error_outline, size: 64, color: Colors.red),
                const SizedBox(height: 16),
                Text('Error: $_error'),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _loadData,
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
    }

    if (_items.isEmpty) {
      return widget.emptyWidget ??
          const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.inbox, size: 64, color: Colors.grey),
                SizedBox(height: 16),
                Text('No items found', style: TextStyle(color: Colors.grey)),
              ],
            ),
          );
    }

    return RefreshIndicator(
      onRefresh: _loadData,
      child: ListView.builder(
        physics: const AlwaysScrollableScrollPhysics(),
        itemCount: _items.length,
        itemBuilder: (context, index) {
          return widget.itemBuilder(context, _items[index], index);
        },
      ),
    );
  }
}

// Usage:
// RefreshableList<Product>(
//   onRefresh: () async {
//     return await apiService.getProducts();
//   },
//   itemBuilder: (context, product, index) {
//     return ListTile(
//       title: Text(product.name),
//       subtitle: Text('\$${product.price}'),
//     );
//   },
//   emptyWidget: Center(child: Text('No products available')),
// )
```

### Template 8: Infinite Scroll List

```dart
import 'package:flutter/material.dart';

/// List that loads more items when scrolling to bottom
class InfiniteScrollList<T> extends StatefulWidget {
  final Future<List<T>> Function(int page) onLoadMore;
  final Widget Function(BuildContext, T) itemBuilder;
  final int itemsPerPage;
  
  const InfiniteScrollList({
    Key? key,
    required this.onLoadMore,
    required this.itemBuilder,
    this.itemsPerPage = 20,
  }) : super(key: key);

  @override
  State<InfiniteScrollList<T>> createState() => _InfiniteScrollListState<T>();
}

class _InfiniteScrollListState<T> extends State<InfiniteScrollList<T>> {
  final ScrollController _scrollController = ScrollController();
  final List<T> _items = [];
  int _currentPage = 0;
  bool _isLoading = false;
  bool _hasMore = true;

  @override
  void initState() {
    super.initState();
    _loadMore();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      if (!_isLoading && _hasMore) {
        _loadMore();
      }
    }
  }

  Future<void> _loadMore() async {
    if (_isLoading) return;

    setState(() => _isLoading = true);

    try {
      final newItems = await widget.onLoadMore(_currentPage);
      
      setState(() {
        _items.addAll(newItems);
        _currentPage++;
        _isLoading = false;
        _hasMore = newItems.length >= widget.itemsPerPage;
      });
    } catch (e) {
      setState(() => _isLoading = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error loading data: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: _scrollController,
      itemCount: _items.length + (_hasMore ? 1 : 0),
      itemBuilder: (context, index) {
        if (index == _items.length) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: CircularProgressIndicator(),
            ),
          );
        }
        return widget.itemBuilder(context, _items[index]);
      },
    );
  }
}

// Usage:
// InfiniteScrollList<Product>(
//   onLoadMore: (page) async {
//     return await apiService.getProducts(page: page, limit: 20);
//   },
//   itemBuilder: (context, product) {
//     return Card(
//       child: ListTile(
//         title: Text(product.name),
//         subtitle: Text('\$${product.price}'),
//       ),
//     );
//   },
//   itemsPerPage: 20,
// )
```

### Template 9: Animated Expandable Card

```dart
import 'package:flutter/material.dart';

/// Card that expands to show more content
class ExpandableCard extends StatefulWidget {
  final String title;
  final String subtitle;
  final Widget expandedContent;
  final IconData? icon;
  final Color? headerColor;
  
  const ExpandableCard({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.expandedContent,
    this.icon,
    this.headerColor,
  }) : super(key: key);

  @override
  State<ExpandableCard> createState() => _ExpandableCardState();
}

class _ExpandableCardState extends State<ExpandableCard>
    with SingleTickerProviderStateMixin {
  bool _isExpanded = false;
  late AnimationController _controller;
  late Animation<double> _iconTurns;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _iconTurns = Tween<double>(begin: 0.0, end: 0.5).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleExpanded() {
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        children: [
          InkWell(
            onTap: _toggleExpanded,
            borderRadius: BorderRadius.circular(12),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: widget.headerColor?.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  if (widget.icon != null) ...[
                    Icon(widget.icon, color: widget.headerColor),
                    const SizedBox(width: 16),
                  ],
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.title,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          widget.subtitle,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                  RotationTransition(
                    turns: _iconTurns,
                    child: const Icon(Icons.expand_more),
                  ),
                ],
              ),
            ),
          ),
          AnimatedCrossFade(
            firstChild: const SizedBox.shrink(),
            secondChild: Padding(
              padding: const EdgeInsets.all(16),
              child: widget.expandedContent,
            ),
            crossFadeState: _isExpanded
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            duration: const Duration(milliseconds: 300),
          ),
        ],
      ),
    );
  }
}

// Usage:
// ExpandableCard(
//   title: 'Product Details',
//   subtitle: 'Tap to see more information',
//   icon: Icons.info_outline,
//   headerColor: Colors.blue,
//   expandedContent: Column(
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: [
//       Text('Detailed description goes here...'),
//       SizedBox(height: 8),
//       Text('Price: \$99.99'),
//       Text('Stock: 50 units'),
//     ],
//   ),
// )
```

### Template 10: Rating Widget with Persistence

```dart
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Star rating widget that saves rating to local storage
class PersistentRatingWidget extends StatefulWidget {
  final String itemId;
  final int maxRating;
  final double starSize;
  final void Function(int)? onRatingChanged;
  
  const PersistentRatingWidget({
    Key? key,
    required this.itemId,
    this.maxRating = 5,
    this.starSize = 32,
    this.onRatingChanged,
  }) : super(key: key);

  @override
  State<PersistentRatingWidget> createState() => _PersistentRatingWidgetState();
}

class _PersistentRatingWidgetState extends State<PersistentRatingWidget> {
  int _currentRating = 0;
  int _hoverRating = 0;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadRating();
  }

  Future<void> _loadRating() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _currentRating = prefs.getInt('rating_${widget.itemId}') ?? 0;
      _isLoading = false;
    });
  }

  Future<void> _setRating(int rating) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('rating_${widget.itemId}', rating);
    
    setState(() => _currentRating = rating);
    widget.onRatingChanged?.call(rating);
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return SizedBox(
        width: widget.starSize * widget.maxRating,
        height: widget.starSize,
        child: const Center(child: CircularProgressIndicator(strokeWidth: 2)),
      );
    }

    return MouseRegion(
      onExit: (_) => setState(() => _hoverRating = 0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(widget.maxRating, (index) {
          final starIndex = index + 1;
          final isActive = _hoverRating > 0
              ? starIndex <= _hoverRating
              : starIndex <= _currentRating;

          return MouseRegion(
            onEnter: (_) => setState(() => _hoverRating = starIndex),
            child: GestureDetector(
              onTap: () => _setRating(starIndex),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeInOut,
                child: Icon(
                  isActive ? Icons.star : Icons.star_border,
                  size: widget.starSize,
                  color: isActive ? Colors.amber : Colors.grey,
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}

// Usage:
// PersistentRatingWidget(
//   itemId: 'product_123',
//   maxRating: 5,
//   starSize: 36,
//   onRatingChanged: (rating) {
//     print('User rated: $rating stars');
//     // Send to API
//   },
// )
```

---

## Conclusion

This guide covers the fundamental and advanced concepts of Flutter development. Keep learning and building!

**Additional Resources:**
- Official Documentation: https://docs.flutter.dev
- Flutter Cookbook: https://docs.flutter.dev/cookbook
- Dart Language Tour: https://dart.dev/guides/language/language-tour
- Flutter YouTube Channel: https://www.youtube.com/c/flutterdev
- Flutter Community: https://flutter.dev/community

**Remember:**
- Write clean, readable code
- Test your application thoroughly
- Optimize for performance
- Follow Flutter best practices
- Keep learning and experimenting!

Happy Fluttering! 🚀

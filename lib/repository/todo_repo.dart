import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rxdart/rxdart.dart';

import '../config/config.dart';
import '../data/data.dart';

abstract class BaseTodoRepository {
  String get generateNewId;
  Stream<List<Todo>> fetchTodos();
  Stream<Todo> getTodo({required String todoId});
  Future<void> upsertTodo(Todo todo);
  Future<void> deleteTodo(String todoId);
  Future<void> deleteTodos(List<String> todoIds);
}

final todoRepositoryProvider = Provider<TodoRepositoryImpl>(
  (ref) => TodoRepositoryImpl(),
);

class TodoRepositoryImpl implements BaseTodoRepository {
  final _auth = FirebaseAuth.instance;
  final _todoCollection = FirebaseFirestore.instance.collection('todos');

  @override
  String get generateNewId => _todoCollection.doc().id;

  @override
  Stream<List<Todo>> fetchTodos() {
    final userId = _auth.currentUser?.uid ?? '';
    try {
      final otherUserTodosStream = _todoCollection
          .where('isPublished', isEqualTo: true)
          .where('userId', isNotEqualTo: userId)
          .snapshots();

      final userTodosStream =
          _todoCollection.where('userId', isEqualTo: userId).snapshots();

      return Rx.combineLatest2(otherUserTodosStream, userTodosStream,
          (QuerySnapshot otherUserTodos, QuerySnapshot userTodos) {
        final otherTodos = otherUserTodos.docs.map((doc) {
          final data = doc.data() as Map<String, dynamic>;
          return Todo.fromJson(data);
        }).toList();

        final myTodos = userTodos.docs.map((doc) {
          final data = doc.data() as Map<String, dynamic>;
          return Todo.fromJson(data);
        }).toList();

        return [...myTodos, ...otherTodos];
      });
    } on FirebaseException catch (error) {
      logger.e('Error fetching todos: $error');
      return Stream.error('Failed to fetch todos');
    }
  }

  @override
  Stream<Todo> getTodo({required String todoId}) {
    return _todoCollection.doc(todoId).snapshots().map((snapshot) {
      if (snapshot.exists && snapshot.data() != null) {
        return Todo.fromJson(snapshot.data()!);
      } else {
        throw Exception('Todo with ID "$todoId" not found.');
      }
    }).handleError((dynamic error) {
      if (error is FirebaseException) {
        throw Exception(
            'Error retrieving todo data from Firebase: ${error.message}');
      } else {
        throw Exception('An unknown error occurred: $error');
      }
    });
  }

  @override
  Future<void> upsertTodo(Todo todo) async {
    try {
      // Check for duplicate todo by title and userId
      final querySnapshot = await _todoCollection
          .where('title', isEqualTo: todo.title)
          .where('userId', isEqualTo: todo.userId)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        final existingTodo = querySnapshot.docs.first.data();
        if (existingTodo['id'] != todo.id) {
          throw Exception('The title "${todo.title}" is already created.');
        }
      }

      // Insert or update the todo
      await _todoCollection.doc(todo.id).set(todo.toJson());
    } catch (error) {
      logger.e('Error upserting todo: $error');
      rethrow;
    }
  }

  @override
  Future<void> deleteTodo(String todoId) async {
    try {
      await _todoCollection.doc(todoId).delete();
    } catch (error) {
      logger.e('Error deleting todo: $error');
      rethrow;
    }
  }

  @override
  Future<void> deleteTodos(List<String> todoIds) async {
    final batch = FirebaseFirestore.instance.batch();

    for (var todoId in todoIds) {
      final docRef = _todoCollection.doc(todoId);
      batch.delete(docRef);
    }

    try {
      await batch.commit();
    } catch (error) {
      logger.e('Error deleting todos: $error');
      rethrow;
    }
  }
}

final todoProviderStream = StreamProvider.family<Todo?, String>((ref, todoId) {
  final todoRepository = ref.watch(todoRepositoryProvider);
  return todoRepository.getTodo(todoId: todoId);
});

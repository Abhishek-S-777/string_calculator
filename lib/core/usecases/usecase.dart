abstract class UseCase<Type, Params> {
  /// Executes the use case with the given parameters.
  ///
  /// Returns a [Future] that completes with the result of type [Type].
  Future<Type> call(Params params);
}

// Represents that there are no parameters to be passed for a particular method
class NoParams {}
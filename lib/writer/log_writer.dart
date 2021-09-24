/// Base class for all log writers
abstract class LogWriter {
  Future writeAsync(String message);
}

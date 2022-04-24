abstract class IRouteService {
  Future<void> push(String route, Object params);
  Future<void> pushAndClear(String route, Object params);
}

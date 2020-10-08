const API_KEY = 'AIzaSyA3kg7YWugGl1lTXmAmaBGPNhDW9pEh5bo';

class LocationHelper {
  static String generateLocationPReview({
    double latitude,
    double longitude,
  }) {
    return 'https://maps.googleapis.com/maps/api/staticmap?center=$latitude,$longitude&zoom=13&size=600x300'
        '&maptype=roadmap&markers=color:blue%7Clabel:G%7C$latitude,$longitude&key=$API_KEY';
  }

  // TODO: implement geocoding hit to google maps api gk punya api :( bosque
}

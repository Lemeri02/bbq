ymaps.ready(init);

function init(){
  const map = document.getElementById('map');

  if (map) {
    const address = map.getAttribute('data-address');

    const myMap = new ymaps.Map("map", {
        center: [55.76, 37.64],
        zoom: 10
    });

    ymaps.geocode(address, {
      result: 1
    }).then(function (res) {
        const coordinates = res.geoObjects.get(0).geometry.getCoordinates();

        myMap.geoObjects.add(
            new ymaps.Placemark(
              coordinates,
              {iconContent: address},
              {preset: 'islands#blueStretchyIcon'}
            )
        );

        myMap.setCenter(coordinates);
        myMap.setZoom(15);
      }, function (err) {
        console.log('Ошибка при определении местоположения');
      }
    );
  }
}

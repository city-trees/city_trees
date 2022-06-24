import { Map, GeolocateControl, GeoJSONSource } from 'mapbox-gl'

// @see https://github.com/anneb/mapbox-wc
class MapboxMap extends HTMLElement {
  map: Map


  addTreeLayer() {
    this.map.on('load', () => {
      console.log('aded source')
      this.map.addSource('earthquakes', {
        type: 'geojson',
        data: {
          "type": "FeatureCollection",
          "features": []
        }
      });

      this.map.addLayer({
        'id': 'earthquakes-layer',
        'type': 'circle',
        'source': 'earthquakes',
        'paint': {
          'circle-radius': 8,
          'circle-stroke-width': 2,
          'circle-color': 'red',
          'circle-stroke-color': 'white'
        }
      });
    });
  }

  connectedCallback() {
    this.render();
    console.log('connected')
    const container = this.shadowRoot.querySelector('#map-container') as HTMLDivElement;

    this.map = new Map({
      accessToken: 'pk.eyJ1IjoibWFyY2lua29wYWN6IiwiYSI6ImNrenlteHJvaTAxdWUzY254ZHppMG5nN3QifQ.U3tuBCRNFosiS3buKpUxnQ',
      container,
      style: 'mapbox://styles/mapbox/streets-v11',
      center: [17.03, 51.1],
      zoom: 12
    });

    this.map.addControl(
      new GeolocateControl({
        positionOptions: {
          enableHighAccuracy: true
        },
        trackUserLocation: true,
        showUserHeading: true
      })
    );

    this.addTreeLayer()

    const resizeObserver = new ResizeObserver(entries => {
      for (let entry of entries) {
        if (entry.contentBoxSize) {
          this.map.resize();
        }
      }
    });
    resizeObserver.observe(container);

    window.addEventListener('phx:trees', ({ detail }: any) => {
      setTimeout(() => {
        (this.map.getSource('earthquakes') as GeoJSONSource).setData({
          "type": "FeatureCollection",
          "features": detail.trees.map((tree) => {
            return {
              "type": "Feature",
              "properties": {

              },
              "geometry": {
                "type": "Point",
                "coordinates": tree.location.coordinates
              }
            }
          })
        })
      }, 1000)
    }, false)
  }
  render() {
    this.attachShadow({ mode: "open" });
    this.shadowRoot.innerHTML = `
        <link href="https://api.mapbox.com/mapbox-gl-js/v2.8.2/mapbox-gl.css" rel="stylesheet">
        <style>
          #map-container {
            height: 100%;
            width: 100%;
          }
        </style>
        
        <div id="map-container" part="map-container"></div>
    `;
  }
}

customElements.define('mapbox-map', MapboxMap)

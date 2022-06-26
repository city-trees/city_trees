import { renderShadow } from "../../../utils/element";

class GeolocationInputs extends HTMLElement {
  longitudeInput!: HTMLInputElement;
  latitudeInput!: HTMLInputElement;
  watchId!: number

  cacheDom = () => {
    this.longitudeInput = this.querySelector('[slot="longitude"]')!.querySelector('input')!;
    this.latitudeInput = this.querySelector('[slot="latitude"]')!.querySelector('input')!;
  }

  attachEvents() {
    this.watchId = navigator.geolocation.watchPosition(
      (position: GeolocationPosition) => {
        this.longitudeInput.setAttribute('value', position.coords.longitude.toString());
        this.latitudeInput.setAttribute('value',position.coords.latitude.toString());
      }, 
      (error: GeolocationPositionError) => {

      })
  }

  connectedCallback() {
    this.render()
    this.cacheDom()
    this.attachEvents()
  }

  disconnectedCallback(): void {
    if (this.watchId) {
      navigator.geolocation.clearWatch(this.watchId)
    }
  }

  render() {
    renderShadow(this, 
      `
      <slot id="longitude" name="longitude"></slot>
      <slot id="latitude" name="latitude"></slot>
      `
    )
  }
}
customElements.define('geolocation-inputs', GeolocationInputs)

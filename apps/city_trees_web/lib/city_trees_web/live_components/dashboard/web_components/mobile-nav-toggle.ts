

export class MobileNavToggle extends HTMLElement {

  connectedCallback() {
    this.addEventListener('click', () => {
      const event = new CustomEvent('mobile-nav-toggle', {composed: true, bubbles: true});
      this.dispatchEvent(event)
    })
  }
}

customElements.define('mobile-nav-toggle', MobileNavToggle)



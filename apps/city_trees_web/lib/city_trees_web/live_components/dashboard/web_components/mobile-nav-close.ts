
export class MobileNavClose extends HTMLElement {
  handleToggle = () => {
    this.classList.toggle('opacity-0')
    this.classList.toggle('opacity-100')
    
  }
  connectedCallback() {
    document.addEventListener('mobile-nav-toggle', this.handleToggle)
    this.addEventListener('click', () => {
      const event = new CustomEvent('mobile-nav-toggle', {composed: true, bubbles: true});
      this.dispatchEvent(event)
    })
  }

  disconnectedCallback() {
    document.removeEventListener('mobile-nav-toggle', this.handleToggle)
  }
}

customElements.define('mobile-nav-close', MobileNavClose)
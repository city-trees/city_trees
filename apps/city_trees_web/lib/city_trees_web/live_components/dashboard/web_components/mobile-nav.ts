
export class MobileNav extends HTMLElement {
  handleToggle = () => {
    this.classList.toggle('translate-x-0')
    this.classList.toggle('-translate-x-full')
    
  }
  
  connectedCallback() {
    document.addEventListener('mobile-nav-toggle', this.handleToggle)
  }

  disconnectedCallback() {
    document.removeEventListener('mobile-nav-toggle', this.handleToggle)
  }
}

customElements.define('mobile-nav', MobileNav)

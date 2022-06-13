
class MobileNav extends HTMLElement {
  connectedCallback() {}
}

customElements.define('mobile-nav', MobileNav)

class MobileNavToggle extends HTMLElement {
  connectedCallback() {
    this.navBar = document.querySelector('mobile-nav');

    this.addEventListener('click', () => {
      this.navBar.classList.toggle('translate-x-0')
    })
  }
}

customElements.define('mobile-nav-toggle', MobileNavToggle)
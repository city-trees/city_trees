
class MobileNav extends HTMLElement {
  connectedCallback() { }
}

customElements.define('mobile-nav', MobileNav)

class MobileNavClose extends HTMLElement {
  connectedCallback() {
    this.navBar = document.querySelector('mobile-nav');
    this.mobilNavClose = document.querySelector('mobile-nav-close');

    this.addEventListener('click', () => {
      this.navBar.classList.toggle('-translate-x-full')
      this.navBar.classList.toggle('translate-x-0')
    
      this.classList.toggle('opacity-0')
      this.classList.toggle('opacity-100')
    })
  }
}

customElements.define('mobile-nav-close', MobileNavClose)


class MobileNavToggle extends HTMLElement {
  connectedCallback() {
    this.navBar = document.querySelector('mobile-nav');
    this.mobilNavClose = document.querySelector('mobile-nav-close');

    this.addEventListener('click', () => {
      this.navBar.classList.toggle('translate-x-0')
      this.navBar.classList.toggle('-translate-x-full')

      this.mobilNavClose.classList.toggle('opacity-0')
      this.mobilNavClose.classList.toggle('opacity-100')
    })
  }
}

customElements.define('mobile-nav-toggle', MobileNavToggle)
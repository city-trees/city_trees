import { css, html, LitElement } from "lit";
import { SplitPanelMobile } from "../../../web_components/split-panel";

class MobileNavSplitPanel extends LitElement {
  mapIcon: HTMLElement | null = null;
  tableIcon: HTMLElement | null = null;

  static styles = css` 
    #map-icon-slot {
      display: none;
    }
    #table-icon-slot {
      display: none;
    }
  `

  handleSplitPanelMobile = (event: SplitPanelMobile) => {
    event.stopPropagation()
    console.log(event.detail)
    if (event.detail.visiblePanel === "map") {
      this.mapIcon!.style.display = 'none'
      this.tableIcon!.style.display = 'visible'
    }
  }

  cacheDom = () => {
    this.mapIcon = this.renderRoot.querySelector('#map-icon-slot');
    this.tableIcon = this.renderRoot.querySelector('#table-icon-slot');
  }

  attachEvents() {
    document.addEventListener('split-panel-mobile', this.handleSplitPanelMobile as EventListener)
  }

  disconnectEvents() {
    document.removeEventListener('split-panel-mobile', this.handleSplitPanelMobile as EventListener)
  }

  firstUpdated() {
    this.cacheDom()
    this.attachEvents()
  }

  disconnectedCallback(): void {
    this.disconnectEvents();
  }

  render() {
    return html`
      <slot id="map-icon-slot" name="map-icon"></slot>
      <slot id="table-icon-slot" name="table-icon"></slot>
    `;
  }
}
customElements.define('mobile-nav-split-panel', MobileNavSplitPanel)

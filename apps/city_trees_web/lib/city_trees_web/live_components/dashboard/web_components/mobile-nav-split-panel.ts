import { renderShadow } from "../../../utils/element";
import { emitter, EventName } from "../../../utils/event";


class MobileNavSplitPanel extends HTMLElement {
  mapIcon: HTMLElement | null = null;
  tableIcon: HTMLElement | null = null;

  switchMap = () => {
    this.mapIcon!.style.display = 'none'
    this.tableIcon!.style.display = 'block'
  }

  switchContent = () => {
    this.mapIcon!.style.display = 'block'
    this.tableIcon!.style.display = 'none'
  }

  handleSplitPanelMobile = ({mode, panel}: {mode: string, panel: string}) => {
    if (panel === "map") {
      this.switchMap()
    } else {
      this.switchContent()
    }
  }

  cacheDom = () => {
    this.mapIcon = this.shadowRoot!.querySelector('#map-icon');
    this.tableIcon = this.shadowRoot!.querySelector('#table-icon');
  }

  attachLocalEvents() {
    this.tableIcon?.addEventListener('click', (e) => {
      e.stopPropagation();
      this.switchContent()
      emitter.emit(EventName.SplitPanelSwitchPanel, "content")
    })
    this.mapIcon?.addEventListener('click', (e) => {
      e.stopPropagation();
      this.switchMap()
      emitter.emit(EventName.SplitPanelSwitchPanel, "map")
    })
  }

  attachEvents() {
    emitter.addEventListener(EventName.SplitPanelSwitchMobile, this.handleSplitPanelMobile)
  }

  disconnectEvents() {
    emitter.removeListener(EventName.SplitPanelSwitchMobile, this.handleSplitPanelMobile)
  }

  connectedCallback() {
    this.render()
    this.cacheDom()
    this.attachEvents()
    this.attachLocalEvents()
  }

  disconnectedCallback() {
    this.disconnectEvents();
  }

  render() {
    renderShadow(this, 
      `
      <slot id="map-icon" name="map-icon"></slot>
      <slot id="table-icon" name="table-icon"></slot>
    `,
    `
      #map-icon {
        display: none;
      }
      #table-icon {
        display: none;
      }
    `);
  }
}
customElements.define('mobile-nav-split-panel', MobileNavSplitPanel)

import { css, html, LitElement } from "lit";
import { emitter, EventName } from "../../../utils/event";


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

  handleSplitPanelMobile = ({mode, panel}: {mode: string, panel: string}) => {
    if (panel === "map") {
      this.mapIcon!.style.display = 'none'
      this.tableIcon!.style.display = 'visible'
    }
  }

  cacheDom = () => {
    this.mapIcon = this.renderRoot.querySelector('#map-icon');
    this.tableIcon = this.renderRoot.querySelector('#table-icon');
  }

  attachLocalEvents() {
    this.tableIcon?.addEventListener('click', (e) => {
      e.stopPropagation();
      emitter.emit(EventName.SplitPanelSwitchPanel, "content")
    })
    this.mapIcon?.addEventListener('click', (e) => {
      e.stopPropagation();
      emitter.emit(EventName.SplitPanelSwitchPanel, "map")
    })
  }

  attachEvents() {
    emitter.addEventListener(EventName.SplitPanelSwitchMobile, this.handleSplitPanelMobile)
  }

  disconnectEvents() {
    emitter.removeListener(EventName.SplitPanelSwitchMobile, this.handleSplitPanelMobile)
  }

  firstUpdated() {
    this.cacheDom()
    this.attachEvents()
    this.attachLocalEvents()
  }

  disconnectedCallback(): void {
    this.disconnectEvents();
  }

  render() {
    return html`
      <slot id="map-icon" name="map-icon"></slot>
      <slot id="table-icon" name="table-icon"></slot>
    `;
  }
}
customElements.define('mobile-nav-split-panel', MobileNavSplitPanel)

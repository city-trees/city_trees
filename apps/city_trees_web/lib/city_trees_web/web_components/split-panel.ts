
import { renderShadow } from '../utils/element';
import { emitter, EventName } from '../utils/event';
import { debounce } from '../utils/lodash';

const medianWidth = 10

export class SplitPanel extends HTMLElement {
  #isResizing = false;
  isMobileView: boolean | null = null;
  visiblePanel:  "map" | "content" = "map"

  rec: DOMRect | null = null;
  median!: HTMLDivElement
  mapPanel!: HTMLDivElement
  contentPanel!: HTMLDivElement

  set isResizing(value) {
    this.#isResizing = value;
    if (value) {
      this.setAttribute("resizing", "");
    } else {
      this.style.userSelect = "";
      this.style.cursor = "";
      this.removeAttribute("resizing");
    }
  }
  get isResizing() {
    return this.#isResizing;
  }

  cacheDom = () => {
    this.median = this.shadowRoot!.querySelector('#median')!;
    this.mapPanel = this.querySelector('[slot="map-panel"]')!
    this.contentPanel = this.querySelector('[slot="content-panel"]')!
  }

  updateRec = () => {
    this.rec = this.getBoundingClientRect();
  }

  switchToMobile = () => {
    this.isMobileView = true;
    this.style.gridTemplateColumns = `100% 0px 100%`;
    this.style.overflowX = 'hidden';

    emitter.emit(EventName.SplitPanelSwitchMobile, {
      panel: this.visiblePanel,
      mode: 'mobile'
    })
  }

  switchDesktop = () => {
    this.isMobileView = false;
    this.style.gridTemplateColumns = '1fr max-content 1fr';
    this.style.overflowX = 'auto'
    this.mapPanel.style.transform = `none`
    this.contentPanel.style.transform = `none`

    emitter.emit(EventName.SplitPanelSwitchMobile, {
      panel: this.visiblePanel,
      mode: 'desktop'
    })
  }

  handleResolution = () => {
    if (this.isMobileView !== true && window.innerWidth < 1024) {
      this.switchToMobile();
    }
    if (this.isMobileView !== false && window.innerWidth > 1024) {
      this.switchDesktop();
    }
  }

  resize = debounce(() => {
    this.updateRec()
    this.handleResolution();
  }, 500)

  handlePointerdown = (event: PointerEvent) => {
    event.stopPropagation()
    this.isResizing = true;
    this.addEventListener("pointermove", this.handleResizeDrag);
    this.addEventListener("pointerup", this.handlePointerup);
  }
  handlePointerup = (event: PointerEvent) => {
    event.stopPropagation()
    this.isResizing = false;
    this.removeEventListener("pointermove", this.handleResizeDrag);
    this.removeEventListener("pointerup", this.handlePointerup);
  }

  handleResizeDrag = (e: PointerEvent) => {
    e.stopPropagation()
    const newMedianLeft = e.clientX - this.rec!.left;
    this.style.gridTemplateColumns = `calc(${newMedianLeft}px - ${medianWidth / 2}px) ${medianWidth}px 1fr`;
  }

  handleMobileNav = (panel: "content" | "map") => {
    if(panel === 'content') {
      this.visiblePanel = "content"
      this.mapPanel.style.transform = `translate(-100%)`
      this.contentPanel.style.transform = `translate(-100%)`
    } else {
      this.visiblePanel = "map"
      this.mapPanel.style.transform = `none`
      this.contentPanel.style.transform = `none`
    }
  }
  attachLocalEvents =  () => {
    this.median.addEventListener("pointerdown", this.handlePointerdown);
  }
  attachEvents = () => {
    window.addEventListener('resize', this.resize);
    emitter.addEventListener(EventName.SplitPanelSwitchPanel, this.handleMobileNav)
  }
  
  disconnectEvents = () => {
    window.removeEventListener('resize', this.resize);
    emitter.removeListener(EventName.SplitPanelSwitchPanel, this.handleMobileNav)
  }

  connectedCallback() {
    this.render();
    this.cacheDom()
    this.attachEvents();
    this.attachLocalEvents()
    this.updateRec();
    this.handleResolution();
  }

  disconnectedCallback(): void {
    this.disconnectEvents();
  }

  static styles = ` 
    :host { 
      display: grid;
      min-height: 100%;
      max-height: 100%;
      min-width: 100%;
      max-width: 100%;
    }
    :host([resizing]){ 
      user-select: none; 
    }
    :host([resizing]){ 
      cursor: col-resize; 
    }
    :host { 
      grid-template-columns: 1fr max-content 1fr; 
    }
    :host #median { 
      inline-size: 0.5rem; grid-column: 2 / 3; 
    }
    :host #median:hover { 
      cursor: col-resize; 
    }
    :host #map-panel { 
      grid-column: 1 / 2; grid-row: 1 / 1; 
    }
    :host #content-panel { 
      grid-column: 3 / 4; grid-row: 1 / 1; 
    }
    :host([resizing][direction=col]){ cursor: row-resize; }

    #median { 
      background: #ccc; 
      width: ${medianWidth}px;
      background: grey;
    }
    ::slotted(*) { overflow: auto; }
  `;

  static html = `
    <slot id="map-panel" name="map-panel"></slot>
    <div id="median" part="median"></div>
    <slot id="content-panel" name="content-panel"></slot>
  `

  render() {
    renderShadow(this, SplitPanel.html, SplitPanel.styles)
  }
}

customElements.define('split-panel', SplitPanel);
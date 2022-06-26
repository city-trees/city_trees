
import { LitElement, css, html } from 'lit';
import { emitter, EventName } from '../utils/event';
import { debounce } from '../utils/lodash';

const medianWidth = 10

export class SplitPanel extends LitElement {
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
    this.median = this.renderRoot.querySelector('#median')!;
    this.mapPanel = this.renderRoot.querySelector('#map-panel')!
    this.contentPanel = this.renderRoot.querySelector('#content-panel')!
  }

  updateRec = () => {
    this.rec = this.getBoundingClientRect();
  }

  switchToMobile = () => {
    console.log('switch mobile')
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
    console.log(panel, this.mapPanel)
    if(panel === 'content') {
      this.mapPanel.style.transform = `translate(-1000px)`
      this.contentPanel.style.transform = `translate(-1000px)`
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

  firstUpdated() {
    this.cacheDom()
    this.attachEvents();
    this.attachLocalEvents()
    this.updateRec();
    this.handleResolution();
  }

  disconnectedCallback(): void {
    super.disconnectedCallback();
    this.disconnectEvents();
  }

  static styles = css` 
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

  render() {
    return html`
      <slot id="map-panel" name="map-panel"></slot>
      <div id="median" part="median"></div>
      <slot id="content-panel" name="content-panel"></slot>
    `;
  }
}

customElements.define('split-panel', SplitPanel);
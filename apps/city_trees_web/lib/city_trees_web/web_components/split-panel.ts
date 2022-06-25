
import { LitElement, css, html } from 'lit';

export class SplitPanel extends LitElement {
  #isResizing = false;

  rec: DOMRect;
  median: HTMLDivElement;
  
  static medianWidth = 10

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
      grid-template-columns: var(--first-size, 1fr) max-content var(--second-size, 1fr); 
    }
    :host #median { 
      inline-size: 0.5rem; grid-column: 2 / 3; 
    }
    :host #median:hover { 
      cursor: col-resize; 
    }
    :host #slot1 { 
      grid-column: 1 / 2; grid-row: 1 / 1; 
    }
    :host #slot2 { 
      grid-column: 3 / 4; grid-row: 1 / 1; 
    }
    :host([resizing][direction=col]){ cursor: row-resize; }

    #median { 
      background: #ccc; 
      width: ${this.medianWidth}px;
      background: grey;
    }
    ::slotted(*) { overflow: auto; }
  `;
  render() {
    return html`
      <slot id="slot1" name="1"></slot>
      <div id="median" part="median"></div>
      <slot id="slot2" name="2"></slot>
    `;
  }
  cacheElements() {
    this.median = this.renderRoot.querySelector('#median');
  }
  updateRec() {
    this.rec = this.getBoundingClientRect();
  }

  firstUpdated() {
    this.cacheElements()
    this.attachEvents();
    this.updateRec() 
  }
  attachEvents() {
    window.addEventListener('resize', this.resize)
    this.median.addEventListener("pointerdown", this.pointerdown);
  }
  resize = () => {
    this.updateRec()
    console.log('resize')
  }
  pointerdown = (event: PointerEvent) => {
    event.stopPropagation()
    this.isResizing = true;
    this.addEventListener("pointermove", this.resizeDrag);
    this.addEventListener("pointerup", this.pointerup);
  }
  pointerup = (event: PointerEvent) => {
    event.stopPropagation()
    this.isResizing = false;
    this.removeEventListener("pointermove", this.resizeDrag);
    this.removeEventListener("pointerup", this.pointerup);
  }

  resizeDrag = (e: PointerEvent) => {
    e.stopPropagation()
    const newMedianLeft = e.clientX - this.rec.left;
    this.style.gridTemplateColumns = `calc(${newMedianLeft}px - ${SplitPanel.medianWidth / 2}px) ${SplitPanel.medianWidth}px 1fr`;
  }

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
}

customElements.define('split-panel', SplitPanel);
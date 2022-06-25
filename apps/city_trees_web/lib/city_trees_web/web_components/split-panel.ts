
class WcSplitPanel extends HTMLElement {
    #isResizing = false;

    top: number;
    left: number;
    median: HTMLDivElement

    constructor() {
        super();
        this.bind(this);
    }
    bind(element) {
        element.attachEvents = element.attachEvents.bind(element);
        element.render = element.render.bind(element);
        element.cacheDom = element.cacheDom.bind(element);
        element.pointerdown = element.pointerdown.bind(element);
        element.resizeDrag = element.resizeDrag.bind(element);
    }
    render() {
        this.attachShadow({ mode: "open" });
        this.shadowRoot.innerHTML = `
          <style>
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

              #median { background: #ccc; }
              ::slotted(*) { overflow: auto; }
          </style>

          <slot id="slot1" name="1"></slot>
          <div id="median" part="median"></div>
          <slot id="slot2" name="2"></slot>
      `;
    }
    connectedCallback() {
        this.render();
        this.cacheDom();
        this.attachEvents();
    }
    cacheDom() {
        this.median = this.shadowRoot.querySelector("#median")
    }
    attachEvents() {
        this.median.addEventListener("pointerdown", this.pointerdown);
    }
    pointerdown(e) {
        this.isResizing = true;
        const clientRect = this.getBoundingClientRect();
        this.left = clientRect.x;
        this.top = clientRect.y;
        this.addEventListener("pointermove", this.resizeDrag);
        this.addEventListener("pointerup", this.pointerup);
    }
    pointerup() {
        this.isResizing = false;
        this.removeEventListener("pointermove", this.resizeDrag);
        this.removeEventListener("pointerup", this.pointerup);
    }
    resizeDrag(e) {
        e.stopPropagation()
        const newMedianLeft = e.clientX - this.left;
        const median = this.median.getBoundingClientRect().width;
        this.style.gridTemplateColumns = `calc(${newMedianLeft}px - ${median / 2}px) ${median}px 1fr`;
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

customElements.define("split-panel", WcSplitPanel);


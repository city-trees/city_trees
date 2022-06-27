

export const renderShadow = (el: HTMLElement, html: string, css?: string) => {
  if(el.shadowRoot) {
    return;
  }
  const shadow = el.attachShadow({ mode: 'open' });
  shadow.innerHTML = css
    ? `<style>${css}</style>${html}`
    : `${html}`
}
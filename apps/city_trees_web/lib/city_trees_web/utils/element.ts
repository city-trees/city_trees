

export const renderShadow = (el: HTMLElement, html: string, css?: string) => {
  const shadow = el.attachShadow({ mode: 'open' });
  shadow.innerHTML = css
    ? `<style>${css}</style>${html}`
    : `${html}`
}
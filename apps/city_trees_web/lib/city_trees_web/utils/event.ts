
type EventHandler = (...args: any[]) => void;

export enum EventName {
  SplitPanelSwitchPanel = "splitPanelSwitchPanel",
  SplitPanelSwitchMobile = "splitPanelSwitchMobile"
}
export type EventMap = {
  splitPanelSwitchPanel: (panel: "map" | "content") => void
  splitPanelSwitchMobile: ({
    panel, 
    mode
  }: { panel: "map" | "content", mode: "desktop" | "mobile"}) => void
}

type EmitterEventMap = {
  [key: string]: EventHandler
};


class EventEmitter<EventMap extends EmitterEventMap> {
  private readonly listeners: Map<keyof EventMap, Set<EventHandler>> = new Map<keyof EventMap, Set<EventHandler>>();

  public addEventListener<E extends keyof EventMap>(name: E, handler: EventMap[E]): this {
    (this.getHandlers(name) ?? this.addHandlers(name)).add(handler);

    return this;
  }

  public emit<E extends keyof EventMap>(name: E, ...args: Parameters<EventMap[E]>): this {
    const handlers = this.getHandlers(name);

    if (handlers) {
      for (const handler of handlers) {
        handler(...args);
      }
    }

    return this;
  }

  public removeListener<E extends keyof EventMap>(name: E, handler: EventMap[E]): this {
    const handlers = this.getHandlers(name);

    if (handlers) {
      handlers.delete(handler);
    }

    return this;
  }

  /**
   * Get Handlers for event
   */
  private getHandlers<E extends keyof EventMap>(name: E): Set<EventHandler> | undefined {
    return this.listeners.get(name);
  }

  private addHandlers<E extends keyof EventMap>(name: E): Set<EventHandler> {
    const handlers = new Set<EventHandler>();
    this
      .listeners
      .set(name, handlers);

    return handlers;
  }
}



export const emitter = new EventEmitter<EventMap>()                                        
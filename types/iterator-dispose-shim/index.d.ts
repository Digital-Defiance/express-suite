/**
 * Augment standard iterator interfaces with disposable hooks so that
 * Node's Buffer iterators satisfy TypeScript 5.8 disposable typing.
 */
declare global {
  interface Iterator<T, TReturn = any, TNext = any> {
    [Symbol.dispose](): void;
  }

  interface IterableIterator<T, TReturn = any, TNext = any>
    extends Iterator<T, TReturn, TNext> {
    [Symbol.dispose](): void;
  }

  interface AsyncIterator<T, TReturn = any, TNext = any> {
    [Symbol.asyncDispose](): PromiseLike<void>;
  }

  interface AsyncIterableIterator<T, TReturn = any, TNext = any>
    extends AsyncIterator<T, TReturn, TNext> {
    [Symbol.asyncDispose](): PromiseLike<void>;
  }
}

export {};

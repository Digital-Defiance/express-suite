// Global setup for all Jest tests in the workspace
// Mock lru-cache to handle Jest transformation issues

// Must use require in setup file
const Module = require('module');
const originalRequire = Module.prototype.require;

Module.prototype.require = function(id) {
  if (id === 'lru-cache') {
    // Return a proper constructor
    class LRUCache {
      constructor(options) {
        this.max = options?.max || 500;
        this.cache = new Map();
      }
      get(key) {
        return this.cache.get(key);
      }
      set(key, value) {
        if (this.cache.size >= this.max) {
          const firstKey = this.cache.keys().next().value;
          this.cache.delete(firstKey);
        }
        this.cache.set(key, value);
      }
      has(key) {
        return this.cache.has(key);
      }
      delete(key) {
        return this.cache.delete(key);
      }
      clear() {
        this.cache.clear();
      }
    }
    return LRUCache;
  }
  return originalRequire.apply(this, arguments);
};

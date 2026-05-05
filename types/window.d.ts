/**
 * Window interface extensions for browser environment
 *
 * This file extends the Window interface to support custom properties
 * used in browser-based applications within the Digital Defiance monorepo.
 */

/**
 * Application configuration interface
 * Defines the structure of the APP_CONFIG object attached to the window
 */
interface IAppConfig {
  /**
   * Hostname for the application
   */
  hostname: string;

  /**
   * Site title displayed in the UI
   */
  siteTitle: string;

  /**
   * Server URL for backend services
   */
  server: string;

  /**
   * Whether TOTP two-factor authentication is available on this deployment
   */
  totpAvailable?: boolean;

  /**
   * Additional configuration properties
   */
  [key: string]: unknown;
}

/**
 * Extend Window interface to include custom properties
 */
declare global {
  interface Window {
    /**
     * Application configuration object
     * Typically injected during server-side rendering or build time
     */
    APP_CONFIG?: IAppConfig;
  }
}

// This export statement is required to make this file a module
// and ensure the interface augmentation works correctly
export {};

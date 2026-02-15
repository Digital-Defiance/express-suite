# Requirements Document

## Introduction

This feature adds Let's Encrypt support to the `@digitaldefiance/node-express-suite` package via `greenlock-express`. When enabled, the Application class will automatically obtain and renew TLS certificates from Let's Encrypt, serve the Express app over HTTPS on port 443, and redirect HTTP traffic from port 80 to HTTPS. The feature supports multiple hostnames and wildcard domains, and coexists with the existing dev-certificate HTTPS support.

## Glossary

- **Application**: The main Express server class (`Application`) in `node-express-suite` that manages HTTP/HTTPS server lifecycle.
- **Environment**: The configuration class (`Environment`) and its interface (`IEnvironment`) that hold all application settings loaded from environment variables.
- **Greenlock**: The `greenlock-express` library that automates Let's Encrypt certificate issuance and renewal for Node.js applications.
- **ACME**: Automatic Certificate Management Environment — the protocol used by Let's Encrypt to issue certificates.
- **Maintainer_Email**: The email address registered with Let's Encrypt for certificate notifications and account recovery.
- **Site_Config**: The configuration object describing which hostnames and subjects Greenlock should manage certificates for.
- **HTTP_Redirect_Server**: A lightweight HTTP server on port 80 whose sole purpose is to redirect all traffic to HTTPS and serve ACME HTTP-01 challenge responses.

## Requirements

### Requirement 1: Let's Encrypt Configuration

**User Story:** As a developer, I want to configure Let's Encrypt settings through environment variables, so that I can enable automated TLS certificate management without code changes.

#### Acceptance Criteria

1. THE Environment SHALL expose a `letsEncrypt` configuration object on the `IEnvironment` interface containing `enabled`, `maintainerEmail`, `hostnames`, `staging`, and `configDir` fields.
2. WHEN the `LETS_ENCRYPT_ENABLED` environment variable is set to `true` or `1`, THE Environment SHALL set `letsEncrypt.enabled` to `true`.
3. WHEN `letsEncrypt.enabled` is `true`, THE Environment SHALL require a valid `LETS_ENCRYPT_EMAIL` environment variable containing the maintainer email address.
4. WHEN `LETS_ENCRYPT_HOSTNAMES` is provided, THE Environment SHALL parse the comma-separated list of hostnames into an array, supporting both fully qualified domain names and wildcard entries (e.g., `*.example.com`).
5. WHEN `LETS_ENCRYPT_STAGING` is set to `true` or `1`, THE Environment SHALL configure Greenlock to use the Let's Encrypt staging directory for testing.
6. WHEN `LETS_ENCRYPT_CONFIG_DIR` is provided, THE Environment SHALL use the specified directory for storing Greenlock configuration and certificates; WHEN it is not provided, THE Environment SHALL default to `./greenlock.d`.
7. IF `letsEncrypt.enabled` is `true` and `LETS_ENCRYPT_EMAIL` is missing or empty, THEN THE Environment SHALL throw a validation error during construction.
8. IF `letsEncrypt.enabled` is `true` and `LETS_ENCRYPT_HOSTNAMES` is missing or empty, THEN THE Environment SHALL throw a validation error during construction.

### Requirement 2: Greenlock-Express Integration

**User Story:** As a developer, I want the Application class to automatically set up Greenlock-Express when Let's Encrypt is enabled, so that my app is served over HTTPS with valid certificates.

#### Acceptance Criteria

1. WHEN `letsEncrypt.enabled` is `true`, THE Application SHALL initialize Greenlock-Express with the configured maintainer email, hostnames, staging flag, and config directory.
2. WHEN Greenlock-Express is initialized, THE Application SHALL serve the Express app over HTTPS on port 443.
3. WHEN Greenlock-Express is initialized, THE Application SHALL skip the existing dev-certificate HTTPS setup to avoid port conflicts.
4. WHEN `letsEncrypt.enabled` is `false` or not set, THE Application SHALL retain the existing HTTP and optional dev-certificate HTTPS behavior unchanged.

### Requirement 3: HTTP to HTTPS Redirect

**User Story:** As a developer, I want HTTP traffic on port 80 to be automatically redirected to HTTPS, so that all client connections use encrypted transport.

#### Acceptance Criteria

1. WHEN `letsEncrypt.enabled` is `true`, THE Application SHALL start an HTTP_Redirect_Server on port 80.
2. WHEN the HTTP_Redirect_Server receives a non-ACME request, THE HTTP_Redirect_Server SHALL respond with an HTTP 301 redirect to the equivalent HTTPS URL on port 443.
3. WHEN the HTTP_Redirect_Server receives an ACME HTTP-01 challenge request, THE HTTP_Redirect_Server SHALL pass the request to Greenlock for challenge validation.
4. WHEN the Application stops, THE Application SHALL gracefully shut down the HTTP_Redirect_Server alongside the HTTPS server.

### Requirement 4: Server Lifecycle Management

**User Story:** As a developer, I want the Application to manage the Greenlock server lifecycle alongside the existing server lifecycle, so that start and stop operations are consistent.

#### Acceptance Criteria

1. WHEN `letsEncrypt.enabled` is `true` and `start()` is called, THE Application SHALL wait for both the HTTPS server and the HTTP_Redirect_Server to be ready before setting the application to the ready state.
2. WHEN `stop()` is called, THE Application SHALL close all active server connections for both the HTTPS server and the HTTP_Redirect_Server before completing shutdown.
3. WHEN `letsEncrypt.enabled` is `true`, THE Application SHALL still start the primary HTTP server on `environment.port` (default 3000) for internal or health-check traffic.

### Requirement 5: Multiple Hostname and Wildcard Support

**User Story:** As a developer, I want to specify multiple hostnames and wildcard domains for certificate issuance, so that a single server can handle TLS for all my domains.

#### Acceptance Criteria

1. WHEN multiple hostnames are provided in `LETS_ENCRYPT_HOSTNAMES`, THE Application SHALL configure Greenlock to request a certificate covering all specified hostnames as Subject Alternative Names.
2. WHEN a wildcard hostname (e.g., `*.example.com`) is included, THE Application SHALL configure Greenlock to use DNS-01 challenge validation for that entry.
3. THE Environment SHALL validate that each hostname entry is either a valid fully qualified domain name or a valid wildcard pattern (matching `*.domain.tld`).

### Requirement 6: Documentation

**User Story:** As a developer, I want clear documentation explaining how to enable and configure Let's Encrypt support, so that I can set it up correctly in my deployment.

#### Acceptance Criteria

1. THE Documentation SHALL include a section in the package README describing the Let's Encrypt environment variables (`LETS_ENCRYPT_ENABLED`, `LETS_ENCRYPT_EMAIL`, `LETS_ENCRYPT_HOSTNAMES`, `LETS_ENCRYPT_STAGING`, `LETS_ENCRYPT_CONFIG_DIR`).
2. THE Documentation SHALL provide an example `.env` configuration for enabling Let's Encrypt with a single hostname.
3. THE Documentation SHALL provide an example `.env` configuration for enabling Let's Encrypt with multiple hostnames including a wildcard.
4. THE Documentation SHALL explain the port requirements (80 and 443) and any necessary system permissions or firewall rules.
5. THE Documentation SHALL describe the relationship between Let's Encrypt mode and the existing dev-certificate HTTPS mode, clarifying that they are mutually exclusive at runtime.

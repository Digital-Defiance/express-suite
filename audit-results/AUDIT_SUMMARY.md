# Express Suite Audit Summary

*Generated: 11/24/2025, 11:51:51 PM*

## Overall Metrics

- **Total Packages**: 9
- **Documentation Score**: 22.8%
- **Test Coverage Score**: 40.8%
- **Critical Issues**: 1230
- **Warnings**: 1251

## Package Status

| Package | Documentation | Coverage | Issues |
|---------|--------------|----------|--------|
| @digitaldefiance/ecies-lib | 13.0% | 82.9% | 🔴 474 (247 critical) |
| @digitaldefiance/express-suite-react-components | 2.9% | 0.0% | 🔴 361 (167 critical) |
| @digitaldefiance/express-suite-starter | 1.4% | 92.2% | 🔴 154 (71 critical) |
| @digitaldefiance/express-suite-test-utils | 29.0% | 0.0% | 🔴 46 (22 critical) |
| @digitaldefiance/i18n-lib | 14.0% | 93.2% | 🔴 420 (221 critical) |
| @digitaldefiance/mongoose-types | NaN% | 0.0% | ⚠️ 3 |
| @digitaldefiance/node-ecies-lib | 24.8% | 0.0% | 🔴 222 (97 critical) |
| @digitaldefiance/node-express-suite | 5.0% | 0.0% | 🔴 534 (264 critical) |
| @digitaldefiance/suite-core-lib | 14.5% | 98.4% | 🔴 267 (141 critical) |

## Top Documentation Gaps

1. 🔴 **@digitaldefiance/node-express-suite**: 264 undocumented exports
   - Document all exported functions, classes, and interfaces in the README

2. 🔴 **@digitaldefiance/ecies-lib**: 247 undocumented exports
   - Document all exported functions, classes, and interfaces in the README

3. 🔴 **@digitaldefiance/i18n-lib**: 221 undocumented exports
   - Document all exported functions, classes, and interfaces in the README

4. 🔴 **@digitaldefiance/express-suite-react-components**: 167 undocumented exports
   - Document all exported functions, classes, and interfaces in the README

5. 🔴 **@digitaldefiance/suite-core-lib**: 141 undocumented exports
   - Document all exported functions, classes, and interfaces in the README

6. 🔴 **@digitaldefiance/node-ecies-lib**: 97 undocumented exports
   - Document all exported functions, classes, and interfaces in the README

7. 🔴 **@digitaldefiance/express-suite-starter**: 71 undocumented exports
   - Document all exported functions, classes, and interfaces in the README

8. 🔴 **@digitaldefiance/express-suite-test-utils**: 22 undocumented exports
   - Document all exported functions, classes, and interfaces in the README

9. 🟠 **@digitaldefiance/node-express-suite**: 110 major features without examples
   - Add usage examples for major features in the README

10. 🟠 **@digitaldefiance/i18n-lib**: 94 major features without examples
   - Add usage examples for major features in the README

## Top Test Coverage Gaps

1. 🔴 **@digitaldefiance/express-suite-react-components**: Statement coverage at 0.0% (target: 90%)
   - Add tests to increase statement coverage by 90.0%

2. 🔴 **@digitaldefiance/express-suite-test-utils**: Statement coverage at 0.0% (target: 90%)
   - Add tests to increase statement coverage by 90.0%

3. 🔴 **@digitaldefiance/mongoose-types**: Statement coverage at 0.0% (target: 90%)
   - Add tests to increase statement coverage by 90.0%

4. 🔴 **@digitaldefiance/node-ecies-lib**: Statement coverage at 0.0% (target: 90%)
   - Add tests to increase statement coverage by 90.0%

5. 🔴 **@digitaldefiance/node-express-suite**: Statement coverage at 0.0% (target: 90%)
   - Add tests to increase statement coverage by 90.0%

6. 🟠 **@digitaldefiance/express-suite-react-components**: 170 untested exports
   - Add tests for all exported functions and classes

7. 🟠 **@digitaldefiance/ecies-lib**: 127 untested exports
   - Add tests for all exported functions and classes

8. 🟠 **@digitaldefiance/node-express-suite**: 118 untested exports
   - Add tests for all exported functions and classes

9. 🟠 **@digitaldefiance/i18n-lib**: 88 untested exports
   - Add tests for all exported functions and classes

10. 🟠 **@digitaldefiance/express-suite-react-components**: Branch coverage at 0.0% (target: 85%)
   - Add tests for untested branches and edge cases

## Recommendations

### Documentation

**Priority**: high

8 package(s) have undocumented exports

**Affected Packages**: @digitaldefiance/node-express-suite, @digitaldefiance/ecies-lib, @digitaldefiance/i18n-lib

**Action Items**:

- Review and document all exported functions, classes, and interfaces
- Add usage examples for major features
- Update README files with API documentation

### Testing

**Priority**: high

6 package(s) have test coverage below 90%

**Affected Packages**: @digitaldefiance/express-suite-react-components, @digitaldefiance/express-suite-test-utils, @digitaldefiance/mongoose-types

**Action Items**:

- Add tests for untested exports
- Add tests for error conditions and edge cases
- Increase branch coverage by testing all code paths

### Documentation

**Priority**: medium

8 package(s) have major features without usage examples

**Affected Packages**: @digitaldefiance/node-express-suite, @digitaldefiance/i18n-lib, @digitaldefiance/ecies-lib

**Action Items**:

- Add code examples for all major features (classes and primary functions)
- Ensure examples are tested and work correctly
- Include examples in README files

### Integration

**Priority**: medium

1 cross-package integration(s) are not documented

**Affected Packages**: @digitaldefiance/express-suite-react-components

**Action Items**:

- Document how packages integrate with each other
- Add examples of cross-package usage
- Update README files with integration documentation

### Integration

**Priority**: medium

4 cross-package integration(s) lack tests

**Affected Packages**: @digitaldefiance/express-suite-react-components, @digitaldefiance/express-suite-starter

**Action Items**:

- Add integration tests for cross-package functionality
- Test that documented integration patterns work correctly
- Verify binary compatibility between related packages

## Detailed Reports

- [Full HTML Report](./audit-results/index.html)
- [Full JSON Report](./audit-results/full-report.json)

### Individual Package Reports

- [@digitaldefiance/ecies-lib](./audit-results/-digitaldefiance-ecies-lib.html)
- [@digitaldefiance/express-suite-react-components](./audit-results/-digitaldefiance-express-suite-react-components.html)
- [@digitaldefiance/express-suite-starter](./audit-results/-digitaldefiance-express-suite-starter.html)
- [@digitaldefiance/express-suite-test-utils](./audit-results/-digitaldefiance-express-suite-test-utils.html)
- [@digitaldefiance/i18n-lib](./audit-results/-digitaldefiance-i18n-lib.html)
- [@digitaldefiance/mongoose-types](./audit-results/-digitaldefiance-mongoose-types.html)
- [@digitaldefiance/node-ecies-lib](./audit-results/-digitaldefiance-node-ecies-lib.html)
- [@digitaldefiance/node-express-suite](./audit-results/-digitaldefiance-node-express-suite.html)
- [@digitaldefiance/suite-core-lib](./audit-results/-digitaldefiance-suite-core-lib.html)

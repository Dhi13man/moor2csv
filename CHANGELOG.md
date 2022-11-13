# Changelog

All notable changes to this project will be documented in this file.

## [2.0.0] - 13th November, 2022

- **MAJOR:** Migrated to [Null safety](https://dart.dev/null-safety)
- **MAJOR:** [Moor to Drift Migration](https://drift.simonbinder.eu/docs/upgrading/#name)
- **BREAKING:** Changed the previous constructor based usage to use the newly exposed, async-capable `Future<void> writeToCSV` method.
- **BREAKING:** Removed all unnecessary boolean `wasCreated`, `permitted` variables. Instead expose the only needed `(PermissionStatus) permissionStatus` enum.
- All dependencies upgraded to latest versions.

## [1.5.4] - 23rd May, 2021

Seperated path_provider apis for IoS and Android. Fixes bug of generated file not showing in Android.

## [1.5.3] - 25th November, 2020

Seperated path_provider apis for IoS and Android. Fixes bug of generated file not showing in Android.

## [1.5.2] - 11th November, 2020

Fixed Date-Time saving. Will now be saved to and parsed from in Iso8601String form. Also added new tests to verify it.

## [1.5.1] - 11th November, 2020

Fix minor bugs with DateTime fields. toString() applied for values before parsing to CSV format.

## [1.5.0] - 11th November, 2020

Big update. Includes:

1. Error handling when File not accessible.

2. Generated CSVs in compliance with [Standard CSV Rules](https://tools.ietf.org/html/rfc4180).

3. Slightly better documentaion.

## [1.0.5] - 09th November, 2020

Bug Fix from version 1.0.3.

## [1.0.3] - 09th November, 2020

Added error handling for file writing and optimized imports.

Initial Package Upload has been made. Open to suggestions and contributions.

## [1.0.2] - 09th November, 2020

Added usage examples, slightly better documentation and more explanation in code.

## [1.0.0] - 08th November, 2020

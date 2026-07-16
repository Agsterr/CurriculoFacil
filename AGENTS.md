# AGENTS.md

## Cursor Cloud specific instructions

### What this project is
`Currículo Fácil` is an offline-first Flutter app (Dart) for creating/editing/exporting résumés. All data is stored locally in SQLite (`sqflite` on mobile, `sqflite_common_ffi` on desktop). There is **no backend** — the `API_*` values in `.env` are unused placeholders. Officially targeted platforms are **Android** and **Windows** (see `android/`, `windows/`).

### Toolchain (already provisioned in the Cloud VM)
- Flutter SDK lives at `/opt/flutter` and is on `PATH` via symlinks in `/usr/local/bin` (`flutter`, `dart`). Dart 3.12+.
- Standard commands (documented in `README.md` / `ARCHITECTURE.md`): `flutter pub get`, `flutter analyze`, `flutter test`.
- Code generation (freezed / riverpod_generator / json_serializable): `dart run build_runner build --delete-conflicting-outputs`. Generated `*.g.dart`/`*.freezed.dart` files are committed, so codegen is only needed after editing annotated models.

### Known pre-existing issues (NOT environment problems — don't chase them)
- `test/widget_test.dart` references a non-existent `MyApp` class and fails to compile. The rest of the suite (e.g. `test/features/.../personal_data_page_test.dart`) passes. `flutter analyze` also reports this as an error plus assorted lint warnings.
- `pubspec.yaml` declares the asset dir `assets/images/`, but empty dirs aren't tracked by git. If `flutter test`/`run` complains about a missing asset directory, create it: `mkdir -p assets/images`.

### Running the app in this headless Cloud VM
There is no KVM (so an Android emulator is impractical) and web is unsupported (`lib/main.dart` imports `dart:io`). Use the **Linux desktop** target for a runnable GUI:

1. Linux scaffolding is intentionally not committed. Generate it once: `flutter create --platforms=linux .`
2. The `pdf_render_maintained` plugin has broken Linux support (its CMake target/header don't match Flutter's convention). It is only used by résumé OCR import, not the core create/edit flow. To make the Linux build succeed, remove the `linux:` platform entry from that plugin's cached pubspec at `~/.pub-cache/hosted/pub.dev/pdf_render_maintained-*/pubspec.yaml`, then run `flutter clean && flutter pub get`.
3. Build: `flutter build linux --debug`. Always `flutter clean` before rebuilding after plugin/config changes — a stale CMake cache pins `CMAKE_INSTALL_PREFIX` to `/usr/local` and fails with a permission-denied install error.
4. A GUI desktop is available on `DISPLAY=:1` (TigerVNC). Run: `DISPLAY=:1 ./build/linux/x64/debug/bundle/curriculofacil`. libEGL `DRI3`/accelerated-rendering warnings are expected (software rendering) and harmless.
5. On desktop, the SQLite database is written to `.dart_tool/sqflite_common_ffi/databases/curriculo_facil.db` (inspect with `sqlite3`).

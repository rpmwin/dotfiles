# Desktop / Device Screenshots (computer use, iOS Simulator, Android Emulator)

Each full screenshot costs ~1-2k tokens and stays in context for the rest of the session.

- MUST prefer a text source first: the app's CLI, logs, accessibility/UI dump (`agent-device snapshot`), or files on disk.
- MUST screenshot only to locate a target or verify an outcome — not after every action.
- SHOULD zoom/crop to the region of interest instead of a full-screen capture.
- SHOULD chain several inputs (type, key, tap) before the next screenshot when their effect is predictable.
- MUST NOT re-screenshot an unchanged screen to "check again"; wait for a real change first.

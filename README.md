# Roblox Jump Pad Script

A reliable server-side **Jump Pad script** for Roblox Obbies and platformers that launches players high into the air using physics velocity and spawns a dynamic smoke particle effect.

## Features
- **Reliable Launch System:** Uses `BodyVelocity` to give players a smooth and powerful upward boost.
- **Dynamic Smoke Effect:** Spawns a temporary, clean particle effect at the player's position and automatically cleans it up after use.
- **Built-in Cooldown:** Prevents spamming and unintended physics bugs using a per-player cooldown timer.
- **Server-Side Execution:** Fully secure and handled on the server.

## Setup & Installation

1. Open your place in **Roblox Studio**.
2. Create a Part in your Workspace to act as your Jump Pad.
3. Insert a standard **Script** (not a LocalScript) directly inside the Part.
4. Paste the code from `JumpPadScript.lua` into the script.
5. Adjust `JUMP_KRAFT` (default: `200`) at the top of the script if you want higher or lower jumps.

## License

This project is open-source and available under the [MIT License](LICENSE).

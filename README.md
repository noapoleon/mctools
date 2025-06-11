A set of custom made tools to manage and deploy my minecraft servers.

# Configuration
To run the scripts properly you need to provide a `.env` file.
### 1. Copy the example config file
```bash
cp .env.example .env
```
### 2. Edit `.env`
Open `.env` in your favorite editor and fill in your specific values:
```bash
# Paths to files and tools
SERVER_DIR=/path/to/server/       # Full path to your Minecraft server directory

# Server connection settings
RCON_HOST=127.0.0.1              # IP address where your Minecraft server is running
RCON_PORT=25575                  # RCON port (default is 25575)
RCON_PASS=your_secure_rcon_pass  # Your RCON password from server.properties
```



# Todo
- Add scripts for:
    - [ ] `whitelist.sh`: old versions of minecraft still use `api.mojang.com` which is giving 403 errors recently
        - [x] Use `.env` file
        - [x] add <username>
        - [x] remove <username>
        - [ ] list
        - [ ] on
        - [ ] off
        - [ ] reload
    - [ ] `mcdelaystop.sh`
        - [ ] Use `.env` file
    - [ ] `start_server.sh`
        - [ ] Use `.env` file

# lua-finger

> Finger daemon written in Lua

Finger server compliant with [RFC 742](https://www.rfc-editor.org/rfc/rfc742).

## Requirements

- Lua 5.4
- [LuaRocks](https://luarocks.org/)
- [LuaSocket](https://aiq0.github.io/luasocket/index.html)

## Usage

`finger.lua` is an executable script; running it starts the server on port 79. Pass as a second
argument a path to a folder of text files to use as responses:

```bash
./finger.lua ./finger
```

Unlike traditional Finger daemons, which pull specific files from users' home directories, this server returns the contents of various text files.

The server can return three types of responses:

- `_index.txt`: returned when a request is made without specifying a user (`finger @server`)
- `<user>.txt`: returned when a request for a specific user is made (`finger <user>@server`)
- `_notfound.txt`: returned when a request for a user is made, but no text file exists for that user

## Example

A systemd service, with `finger.lua` installed at `/usr/bin/finger`.

```
$ cat /etc/systemd/system/finger.service
[Unit]
Description=Finger

[Service]
Type=simple
Restart=always
RestartSec=5
ExecStart=/usr/bin/finger /var/finger

[Install]
WantedBy=default.target
```

## License

MIT &copy; [Geoff Kimball](https://geoffkimball.com)

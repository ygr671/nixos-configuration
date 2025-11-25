import subprocess
from libqtile.widget import base 

class PipewireVolume(base.ThreadPoolText):
    defaults = [
        ("update_interval", 0.1, "Update interval between 2 refreshes"),
        ("format", "{volume}%", "Format"),
        ("max_volume", 100, "Max volume"),
    ]

    def __init__(self, **config):
        super().__init__("0%", **config)
        self.add_defaults(PipewireVolume.defaults)

    def poll(self):
        try:
            result = subprocess.run(
                    ["wpctl", "get-volume", "@DEFAULT_AUDIO_SINK@"],
                    capture_output=True,
                    text=True
            )

            output = result.stdout.strip()
            if not output:
                return "N/A"

            parts = output.split()
            raw_value = float(parts[1])

            percent = int(raw_value * 100)

            return self.format.format(volume = percent)

        except Exception as e:
            return f"ERR"

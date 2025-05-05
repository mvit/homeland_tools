import glob
import struct

cndyfiles = glob.glob("allbindump/*.cndy")
cndyinfo = []

print(len(cndyfiles))
for file in cndyfiles:
    with open(file, "rb") as infile:
        filesize = len(infile.read())
        infile.seek(0)
        magic = infile.read(4)
        assert magic == b"CNDY"

        namecount, namesize = struct.unpack(">II", infile.read(8))
        command_names = infile.read(namesize).decode("shift-jis").split("\x00")[:namecount]
        
        pad_correct = 0 if (namecount % 4 == 0) else 4 - namecount % 4
        command_ids = list(infile.read(namecount + pad_correct))[:namecount]

        rest = infile.read()

        cndy = {
            "filename": file,
            "remaining_filesize": filesize - infile.tell(),
            "command_names":command_names[:namecount],
            "command_ids":[hex(x) for x in command_ids[:namecount]],
        }

        cndyinfo.append(cndy)

import json

with open("cndy.json", "w", encoding="utf-16") as outfile:
    outfile.write(json.dumps(cndyinfo, indent=4))
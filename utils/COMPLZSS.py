import struct
import sys
import glob

# Lookup table for bit masks (1 << n) - 1 where n ranges from 0 to 16
LZSS_BIT_MASKS = [
    0x0000, 0x0001, 0x0003, 0x0007, 0x000F, 0x001F, 0x003F,
    0x007F, 0x00FF, 0x01FF, 0x03FF, 0x07FF, 0x0FFF, 0x1FFF,
    0x3FFF, 0x7FFF, 0xFFFF
]

class LZSSBitStreamReader:
    def __init__(self, data: bytes):
        self.data = data
        self.offset = 0
        self.bit_buffer = 0
        self.bits_available = 0

    def read_bits(self, num_bits: int) -> int:
        if num_bits < 0 or num_bits > 16:
            raise ValueError(f"Invalid bit count: {num_bits} (0-16 allowed)")

        # Refill buffer until we have enough bits
        while self.bits_available < num_bits:
            if self.offset >= len(self.data):
                print("Warning: Compressed data underflow", file=sys.stderr)
                return 0  # Gracefully handle EOF

            self.bit_buffer |= self.data[self.offset] << self.bits_available
            self.bits_available += 8
            self.offset += 1

        # Extract requested bits
        mask = LZSS_BIT_MASKS[num_bits]
        result = self.bit_buffer & mask

        # Update buffer state
        self.bit_buffer >>= num_bits
        self.bits_available -= num_bits

        return result

def lzss_decompress(compressed_data: bytes) -> bytearray:
    """Decompresses LZSS-compressed data with 'COMP' header"""
    if len(compressed_data) < 8:
        raise ValueError("Invalid COMP header")

    # Parse header
    decompressed_size = struct.unpack('>I', compressed_data[4:8])[0]
    bit_reader = LZSSBitStreamReader(compressed_data[8:])

    # LZSS configuration
    WINDOW_SIZE = 0x2000  # Standard 8KB sliding window
    window = bytearray(WINDOW_SIZE)
    window_pos = 0
    output = bytearray()

    while len(output) < decompressed_size:
        if bit_reader.read_bits(1):  # Compressed flag
            # Handle back reference
            length = bit_reader.read_bits(4) + 3  # [3, 18]

            # End condition check (encoded as length=18)
            if length == 18:
                break

            # Get match offset (13-bit value)
            offset = bit_reader.read_bits(13)
            if offset == 0:
                raise ValueError("Invalid zero offset in LZSS stream")

            # Calculate window source position
            src_pos = (window_pos - offset) % WINDOW_SIZE

            # Copy match data
            for _ in range(length):
                byte = window[src_pos]
                output.append(byte)
                window[window_pos] = byte
                window_pos = (window_pos + 1) % WINDOW_SIZE
                src_pos = (src_pos + 1) % WINDOW_SIZE
        else:  # Literal byte
            literal = bit_reader.read_bits(8)
            output.append(literal)
            window[window_pos] = literal
            window_pos = (window_pos + 1) % WINDOW_SIZE

    # Handle edge case where output might be oversized
    if len(output) > decompressed_size:
        output = output[:decompressed_size]

    return output

def list_files(dir = "allbindump"):
    return glob.glob(f"{dir}/*.lzss")

compfiles = list_files()
compinfo = []
for file in compfiles:
    infile = open(file, "rb")
    data = infile.read()
    infile.close()

    print(file)

    decompressed_size = int.from_bytes(data[4:8], byteorder='big')
    decompressed_buf = lzss_decompress(data)

    outfile = open("dec\\"+file+"raw", "wb")
    outfile.write(decompressed_buf)
    outfile.close()
    
    comp = {
        "filename" : file,
        "filesize" : len(data),
        "decomp_buffer" : decompressed_size,
        "decomp_size" : len(decompressed_buf),
    }

    compinfo.append(comp)

import json

with open("comp.json", "w", encoding="utf-16") as outfile:
    outfile.write(json.dumps(compinfo, indent=4))

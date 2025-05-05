#pragma endian big

struct header {
    u32 count;
    u32 entries[count+1];
};

struct res_header {
    u32 unk_magic;
    u32 unk_index;
    u32 unk[6];
};

struct unk_res_header {
    u32 unk_magic;
    u32 unk_node_counts;
};

struct TRS {
    float tx;
    float ty;
    float tz;
    float rx;
    float ry;
    float rz;
    float sx;
    float sy;
    float sz;
};

struct unk_res0_entry {
    s32 entry_left;
    s32 entry_right;
};

struct unk_res0_data {
    u32 unk_magic;
    u32 unk_index;
    TRS trs;
    s32 entry_left;
    s32 entry_right;
    u32 entry_count_a;
    u32 entry_count_b;
    u32 entry_count_c;
    u32 entry_count_d;
    unk_res0_entry entry_A[entry_count_a];
    unk_res0_entry entry_B[entry_count_b];
    unk_res0_entry entry_C[entry_count_c];
    unk_res0_entry entry_D[entry_count_d];
};

struct unk_res2_data {
    u32 unk_magic;
    u32 unk_index;
    u32 flags;
    u32 something;
    u32 something2;
    u32 something3;
    
};

struct unk_resA_data {
    u32 unk_magic;
    u32 unk_index;
};

struct unk_resB_entry {
    s32 entry_left;
    s32 entry_right;
    u32 sub_resource_id;
    u32 unk_c;
    u32 unk_d;
    u8 unk_e;
    float floats[4];
};

struct unk_resB_data {
    u32 unk_magic;
    u32 unk_index;
    s32 parent_node_maybe;
    s32 entry_left;
    s32 entry_right;
    u32 unk[3];
    u8 flag_a;
    u8 flag_b;
    u8 flag_c;
    u8 flag_d;
    u16 some_size;
    unk_resB_entry entry_B[flag_b];
    unk_resB_entry entry_C[flag_c];
    unk_resB_entry entry_D[flag_d];
};

struct unk_resC_data {
    res_header header;
};

struct resD_patterndata {
    res_header header;
    u32 flags;
    u32 palette_size;
    u16 width;
    u16 height;
    u32 format;
    u32 mip_levels;
    u32 byte_size;
    u8 image_data[mip_levels * byte_size];
    u16 image_palettes[palette_size];
};

header header @ 0x0;
unk_res_header unk_res_header_at_0x48 @ 0x48;
unk_res0_data unk_res0_data_at_0x50 @ 0x50;
unk_res0_data unk_res0_data_at_0xB4 @ 0xB4;
unk_res0_data unk_res0_data_at_0xF8 @ 0xF8;
unk_res0_data unk_res0_data_at_0x13C @ 0x13C;
unk_res0_data unk_res0_data_at_0x180 @ 0x180;
unk_res0_data unk_res0_data_at_0x1C4 @ 0x1C4;
unk_res0_data unk_res0_data_at_0x208 @ 0x208;
unk_res0_data unk_res0_data_at_0x24C @ 0x24C;
unk_res0_data unk_res0_data_at_0x2A0 @ 0x2A0;
unk_resB_data unk_resb_data_at_0x2F4 @ 0x2F4;
unk_resB_data unk_resb_data_at_0x343 @ 0x343;
unk_resB_data unk_resb_data_at_0x392 @ 0x392;
unk_resA_data unk_resa_data_at_0x1121 @ 0x1121;
unk_res2_data unk_res2_data_at_0x10F1 @ 0x10F1;
unk_res2_data unk_res2_data_at_0x1109 @ 0x1109;
unk_res0_data unk_res0_data_at_0x1015 @ 0x1015;
unk_res0_data unk_res0_data_at_0x1059 @ 0x1059;
unk_res0_data unk_res0_data_at_0x10AD @ 0x10AD;
unk_resA_data unk_resa_data_at_0xA574 @ 0xA574;
unk_resB_data unk_resb_data_at_0xAA86 @ 0xAA86;
unk_resB_data unk_resb_data_at_0xAAD5 @ 0xAAD5;
unk_resB_data unk_resb_data_at_0xAB24 @ 0xAB24;
unk_resB_data unk_resB_data_at_0xAB73 @ 0xAB73;
unk_resB_data unk_resB_data_at_0xABE3 @ 0xABE3;
unk_resB_data unk_resB_data_at_0xAC32 @ 0xAC32;
unk_resB_data unk_resB_data_at_0xAC81 @ 0xAC81;
unk_resB_data unk_resB_data_at_0xACD0 @ 0xACD0;
unk_resB_data unk_resB_data_at_0xAD1F @ 0xAD1F;
unk_resC_data unk_resC_data_at_0xAD6E @ 0xAD6E;
unk_resA_data unk_resa_data_at_0xA993 @ 0xA993;
resD_patterndata resD_patterndata_at_0xAEA4 @ 0xAEA4;
resD_patterndata resD_patterndata_at_0xAF1C @ 0xAF1C;
resD_patterndata resD_patterndata_at_0xAF90 @ 0xAF94;
resD_patterndata resD_patterndata_at_0xF0CC @ 0xF0CC;
resD_patterndata resD_patterndata_at_0xF924 @ 0xF924;
resD_patterndata resD_patterndata_at_0xF998 @ 0xF99C;
resD_patterndata resD_patterndata_at_0xFA34 @ 0xFA34;
resD_patterndata resD_patterndata_at_0xFE88 @ 0xFE8C;
resD_patterndata resD_patterndata_at_0x106E4 @ 0x106E4;
resD_patterndata resD_patterndata_at_0x1075C @ 0x1075C;
resD_patterndata resD_patterndata_at_0x11BB4 @ 0x11BB4;
resD_patterndata resD_patterndata_at_0x12808 @ 0x1280C;
resD_patterndata resD_patterndata_at_0x16940 @ 0x16944;
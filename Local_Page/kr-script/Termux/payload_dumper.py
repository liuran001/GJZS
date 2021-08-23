#!/data/data/com.termux/files/usr/bin/python
# file Source: https://gist.github.com/ius/42bd02a5df2226633a342ab7a9c60f15
import struct
import hashlib
import bz2
import sys

try:
    import lzma
except ImportError:
    from backports import lzma

import update_metadata_pb2 as um

flatten = lambda l: [item for sublist in l for item in sublist]

def u32(x):
    return struct.unpack('>I', x)[0]

def u64(x):
    return struct.unpack('>Q', x)[0]

def verify_contiguous(exts):
    blocks = 0

    for ext in exts:
        if ext.start_block != blocks:
            return False

        blocks += ext.num_blocks

    return True

def data_for_op(op):
    p.seek(data_offset + op.data_offset)
    data = p.read(op.data_length)

    assert hashlib.sha256(data).digest() == op.data_sha256_hash, 'operation data hash mismatch'

    if op.type == op.REPLACE_XZ:
        dec = lzma.LZMADecompressor()
        data = dec.decompress(data) 
    elif op.type == op.REPLACE_BZ:
        dec = bz2.BZ2Decompressor()
        data = dec.decompress(data) 

    return data

def dump_part(part):
    print(f"正在提取{part.partition_name}……")

    out_file = open('%s.img' % part.partition_name, 'wb')
    h = hashlib.sha256()

    for op in part.operations:
        data = data_for_op(op)
        h.update(data)
        out_file.write(data)

    assert h.digest() == part.new_partition_info.hash, 'partition hash mismatch'

def help(file):
    print(f"""
-h | --help打印帮助
-l 仅查看{file}镜像列表不解压
-d xxx 仅解压{file}里的指定 xxx 镜像
无参数时就解压{file}全部镜像到当前目录
""")


file_name = 0


if len(sys.argv) == 4:
    file_name = sys.argv[2] if len(sys.argv) == 4 else ""
    file = sys.argv[3] if len(sys.argv) == 4 else ""
elif len(sys.argv) == 3:
    file = sys.argv[2] if len(sys.argv) == 3 else ""
else:
    file = sys.argv[1] if len(sys.argv) == 2 else ""

if len(sys.argv) == 1:
    help(file)
    exit()
elif sys.argv[1] == "-h" or sys.argv[1] == "--help":
    help(file)
    exit()
elif sys.argv[1] == "-d" and len(sys.argv) != 4:
    help(file)
    exit()
elif sys.argv[1] == "-l" and len(sys.argv) != 3:
    help(file)
    exit()


print(f"开始解析{file}文件……\n")

p = open(file, 'rb')

magic = p.read(4)
assert magic == b'CrAU'

file_format_version = u64(p.read(8))
assert file_format_version == 2

manifest_size = u64(p.read(8))

metadata_signature_size = 0

if file_format_version > 1:
    metadata_signature_size = u32(p.read(4))

manifest = p.read(manifest_size)
metadata_signature = p.read(metadata_signature_size)

data_offset = p.tell()

dam = um.DeltaArchiveManifest()
dam.ParseFromString(manifest)

for part in dam.partitions:
    for op in part.operations:
        assert op.type in (op.REPLACE, op.REPLACE_BZ, op.REPLACE_XZ), \
                'unsupported op'

    extents = flatten([op.dst_extents for op in part.operations])
    assert verify_contiguous(extents), 'operations do not span full image'

    if sys.argv[1] == "-d" and len(sys.argv) == 4:
        if part.partition_name == file_name:
            dump_part(part)
    elif sys.argv[1] == "-l" and len(sys.argv) == 3:
        print(part.partition_name)
    elif len(sys.argv) == 2:
        dump_part(part)

print(f"\n解析{file}文件完成。")

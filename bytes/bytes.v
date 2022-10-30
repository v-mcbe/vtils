module main

struct Buffer {
	mut:
		buf []byte
		read_index int
}

fn (mut buffer Buffer) read_byte() byte {
	buffer.read_index += 1
	return buffer.buf[buffer.read_index-1]
}

fn (mut buffer Buffer) write_byte(b byte) {
	buffer.buf.insert(buffer.buf.len, b)
}

fn (mut buffer Buffer) reset() {
	buffer = Buffer{}
}
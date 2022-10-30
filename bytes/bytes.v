module bytes

pub struct Buffer {
	pub mut:
		buf []byte
		read_index int
}

pub fn new_buffer(b []byte) Buffer {
	return Buffer{buf:b}
}

pub fn (mut buffer Buffer) read_byte() byte {
	buffer.read_index += 1
	return buffer.buf[buffer.read_index-1]
}

pub fn (mut buffer Buffer) write_byte(b byte) {
	buffer.buf.insert(buffer.buf.len, b)
}

pub fn (mut buffer Buffer) reset() {
	buffer = Buffer{}
}

pub fn (mut buffer Buffer) write(p []byte) int {
	for b in p {
		buffer.write_byte(b)
	}
	return p.len
}

pub fn (mut buffer Buffer) read(mut p []byte) int {
	for i, _ in p {
		p[i] = buffer.buf[i]
	}
	return p.len
}
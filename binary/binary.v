module binary

import math

interface ByteOrder {
	uint16([]byte) u16
	uint32([]byte) u32
	uint64([]byte) u64
	put_uint16(mut _ []byte, _ u16)
	put_uint32(mut _ []byte, _ u32)
	put_uint64(mut _ []byte, _ u64)
	str() string
}

pub struct BigEndian {}

fn (_ BigEndian) uint16(b []byte) u16 {
	_ = b[1]
	return u16(b[1]) | u16(b[0])<<8
}

fn (_ BigEndian) put_uint16(mut b []byte, v u16) {
		_ = b[1]
	b[0] = u8(v >> 8)
	b[1] = u8(v)
}

fn (_ BigEndian) uint32(b []byte) u32 {
	_ = b[3]
	return u32(b[3]) | u32(b[2])<<8 | u32(b[1])<<16 | u32(b[0])<<24
}

fn (_ BigEndian) put_uint32(mut b []byte, v u32) {
	_ = b[3]
	b[0] = u8(v >> 24)
	b[1] = u8(v >> 16)
	b[2] = u8(v >> 8)
	b[3] = u8(v)
}


fn (_ BigEndian) uint64(b []byte) u64 {
	_ = b[7]
	return u64(b[7]) | u64(b[6])<<8 | u64(b[5])<<16 | u64(b[4])<<24 |
		u64(b[3])<<32 | u64(b[2])<<40 | u64(b[1])<<48 | u64(b[0])<<56
}

fn (_ BigEndian) put_uint64(mut b []byte, v u64) {
	_ = b[7]
	b[0] = u8(v >> 56)
	b[1] = u8(v >> 48)
	b[2] = u8(v >> 40)
	b[3] = u8(v >> 32)
	b[4] = u8(v >> 24)
	b[5] = u8(v >> 16)
	b[6] = u8(v >> 8)
	b[7] = u8(v)

}

fn (_ BigEndian)str() string {
	return "BigEndian"
}

pub struct LittleEndian {}

fn (_ LittleEndian) uint16(b []byte) u16 {
	_ = b[1]
	return u16(b[0]) | u16(b[1])<<8
}

fn (_ LittleEndian) put_uint16(mut b []byte, v u16) {
	_ = b[1]
	b[0] = u8(v)
	b[1] = u8(v >> 8)
}

fn (_ LittleEndian) uint32(b []byte) u32 {
	_ = b[3]
	return u32(b[0]) | u32(b[1])<<8 | u32(b[2])<<16 | u32(b[3])<<24
}

fn (_ LittleEndian) put_uint32(mut b []byte, v u32) {
	_ = b[3]
	b[0] = u8(v)
	b[1] = u8(v >> 8)
	b[2] = u8(v >> 16)
	b[3] = u8(v >> 24)
}


fn (_ LittleEndian) uint64(b []byte) u64 {
	_ = b[7]
	return u64(b[0]) | u64(b[1])<<8 | u64(b[2])<<16 | u64(b[3])<<24 |
		u64(b[4])<<32 | u64(b[5])<<40 | u64(b[6])<<48 | u64(b[7])<<56
}

fn (_ LittleEndian) put_uint64(mut b []byte, v u64) {
	_ = b[7]
	b[0] = u8(v)
	b[1] = u8(v >> 8)
	b[2] = u8(v >> 16)
	b[3] = u8(v >> 24)
	b[4] = u8(v >> 32)
	b[5] = u8(v >> 40)
	b[6] = u8(v >> 48)
	b[7] = u8(v >> 56)
}

fn (_ LittleEndian)str() string {
	return "LittleEndian"
}


interface ValueReader {
	mut:
		read_value([]byte, ByteOrder)
}

pub fn read_value(b []byte, order ByteOrder, mut v ValueReader) {
	v.read_value(b, order)
}

pub fn read_bool(b []byte, order ByteOrder, mut v &bool) {
	unsafe {
		*v = b[0] != 0
	}
}

pub fn read_i8(b []byte, order ByteOrder, mut v &i8) {
	unsafe {
		*v = i8(b[0])
	}
}

pub fn read_u8(b []byte, order ByteOrder, mut v &u8) {
	unsafe {
		*v = b[0]
	}
}

pub fn read_i16(b []byte, order ByteOrder, mut v &i16) {
	unsafe {
		*v = i16(order.uint16(b))
	}
}

pub fn read_u16(b []byte, order ByteOrder, mut v &u16) {
	unsafe {
		*v = order.uint16(b)
	}
}

pub fn read_int(b []byte, order ByteOrder, mut v &int) {
	unsafe {
		*v = int(order.uint32(b))
	}
}

pub fn read_u32(b []byte, order ByteOrder, mut v &u32) {
	unsafe {
		*v = order.uint32(b)
	}
}

pub fn read_i64(b []byte, order ByteOrder, mut v &i64) {
	unsafe {
		*v = i64(order.uint64(b))
	}
}

pub fn read_u64(b []byte, order ByteOrder, mut v &u64) {
	unsafe {
		*v = order.uint64(b)
	}
}

pub fn read_f32(b []byte, order ByteOrder, mut v &f32){
	unsafe {
		*v = math.f32_from_bits(order.uint32(b))
	}
}

pub fn read_f64(b []byte, order ByteOrder, mut v &f64){
	unsafe {
		*v = math.f64_from_bits(order.uint64(b))
	}
}
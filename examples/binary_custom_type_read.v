module main

import binary

fn main(){
	mut pi := Test{}
	b := [byte(0x18), 0x2d, 0x44, 0x54, 0xfb, 0x21, 0x09, 0x40, 0x01, 0x00, 0x01]
	n := binary.read_value(b, binary.LittleEndian{}, mut pi)
	println("total length: ${n}\npi:\n	${pi}")
}


struct OtherTest {
	mut:
		test bool
}

pub fn (mut t OtherTest)read_value(b []byte, order binary.ByteOrder) int {
	return binary.read_bool(b, order, mut &t.test)
}

struct Test {
	mut:
		test f64
		other_test bool
		other_bool bool
		test2 OtherTest
}

pub fn (mut t Test)read_value(b []byte, order binary.ByteOrder) int {
	mut tot := 0
	mut bs := b.clone()

	tot += binary.read_f64_drop(mut bs, order, mut t.test)
	tot += binary.read_bool_drop(mut bs, order, mut &t.other_test)
	tot += binary.read_bool_drop(mut bs, order, mut &t.other_bool)
	tot += binary.read_value_drop(mut bs, order, mut t.test2)

	return tot
}
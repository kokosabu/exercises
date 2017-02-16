use std::mem;

fn main() {
    let one = true as u8;
    let at_sign = 64 as char;
    let two_hundred = -56i8 as u8;
    println!("{}, {}, {}", one, at_sign, two_hundred);

    let a = 300 as *const char; // `a` is a pointer to location 300.
    let b = a as u32;
    println!("{}", b);

    unsafe {
        let a = [0u8, 1u8, 0u8, 0u8];
        let b = mem::transmute::<[u8; 4], u32>(a);
        println!("{}", b); // 256
        // Or, more concisely:
        let c: u32 = mem::transmute(a);
        println!("{}", c); // 256
    }
}

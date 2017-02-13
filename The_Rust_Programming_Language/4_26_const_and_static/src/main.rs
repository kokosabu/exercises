const N: i32 = 4;
static M: i32 = 4;
static mut L: i32 = 4;

fn main() {
    const N: i32 = 5;
    // const N: i32 = 6; // error
    static M: i32 = 5;
    // static M: i32 = 6; // error
    static mut L: i32 = 5;
    // static mut L: i32 = 6; // error
    unsafe {
        L += 1;
        println!("{}, {}, {}", N, M, L);
    }
}

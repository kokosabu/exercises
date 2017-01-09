fn main() {
    let f: fn(i32) -> i32;

    f = add_one;

    print_number(5);
    print_sum(5, 6);
    print_number(f(5));
    diverges();
}

fn print_number(x: i32) {
    println!("x is: {}", x);
}

fn print_sum(x: i32, y: i32) {
// fn print_sum(x, y) {
    println!("sum is: {}", x + y);
}

fn add_one(x: i32) -> i32 {
    x + 1
}

fn diverges() -> ! {
    panic!("This function never returns!");
}

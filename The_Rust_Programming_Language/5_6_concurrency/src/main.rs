use std::thread;

fn main() {
    let x = 1;
    thread::spawn(move || {
        println!("x is {}", x);
    });
}

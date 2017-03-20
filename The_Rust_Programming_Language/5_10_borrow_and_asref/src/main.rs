use std::borrow::Borrow;
use std::fmt::Display;

fn foo<T: Borrow<i32> + Display>(a: T) {
    println!("a is borrowed: {}", a);
}

fn bar<T: AsRef<str>>(s: T) {
    let mut slice = s.as_ref();
    println!("{}", slice);
}

fn main() {
    let mut i = 5;
    foo(&i);
    foo(&mut i);

    let s = "Hello".to_string();
    bar(s);
}

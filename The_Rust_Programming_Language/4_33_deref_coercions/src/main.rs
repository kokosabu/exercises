use std::ops::Deref;

struct DerefExample<T> {
    value: T,
}

impl<T> Deref for DerefExample<T> {
    type Target = T;

    fn deref(&self) -> &T {
        &self.value
    }
}

use std::rc::Rc;

fn foo(s: &str) {
    // Borrow a string for a second.
    println!("{}", s);
}

fn foo2(s: &[i32]) {
    // Borrow a slice for a second.
    println!("{:?}", s);
}

struct Foo;

impl Foo {
    fn foo(&self) { println!("Foo"); }
}

fn main() {
    let x = DerefExample { value: 'a' };
    assert_eq!('a', *x);

    // String implements Deref<Target=str>.
    let owned = "Hello".to_string();
    let counted = Rc::new(owned);
    // Therefore, this works:
    foo(&counted);

    // Vec<T> implements Deref<Target=[T]>.
    let owned = vec![1, 2, 3];
    foo2(&owned);

    let f = &&Foo;
    f.foo();
    (&f).foo();
    (&&f).foo();
    (&&&&&&&&f).foo();
}

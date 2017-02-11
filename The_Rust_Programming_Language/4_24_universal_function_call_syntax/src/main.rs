trait Foo {
    fn f(&self);
}
trait Bar {
    fn f(&self);
}
struct Baz;
impl Foo for Baz {
    fn f(&self) { println!("Baz’s impl of Foo"); }
}
impl Bar for Baz {
    fn f(&self) { println!("Baz’s impl of Bar"); }
}

trait Foo2 {
    fn foo() -> i32;
}
struct Bar2;
impl Bar2 {
    fn foo() -> i32 {
        20
    }
}
impl Foo2 for Bar2 {
    fn foo() -> i32 {
        10
    }
}

fn main() {
    let b = Baz;
    // b.f();
    Foo::f(&b);
    Bar::f(&b);

    assert_eq!(10, <Bar2 as Foo2>::foo());
    assert_eq!(20, Bar2::foo());
}

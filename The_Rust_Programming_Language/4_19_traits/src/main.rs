struct Circle {
    x: f64,
    y: f64,
    radius: f64,
}

/*
impl Circle {
    fn area(&self) -> f64 {
        std::f64::consts::PI * (self.radius * self.radius)
    }
}
*/

trait HasArea {
    fn area(&self) -> f64;
    fn is_larger(&self, &Self) -> bool;
}

impl HasArea for Circle {
    fn area(&self) -> f64 {
        std::f64::consts::PI * (self.radius * self.radius)
    }

    fn is_larger(&self, other: &Self) -> bool {
        self.area() > other.area()
    }
}

fn print_area<T: HasArea>(shape: T) {
    println!("This shape has an area of {}", shape.area());
}

struct Square {
    x: f64,
    y: f64,
    side: f64,
}

impl HasArea for Square {
    fn area(&self) -> f64 {
        self.side * self.side
    }

    fn is_larger(&self, other: &Self) -> bool {
        self.area() > other.area()
    }
}

struct Rectangle<T> {
    x: T,
    y: T,
    width: T,
    height: T,
}

impl<T: PartialEq> Rectangle<T> {
    fn is_square(&self) -> bool {
        self.width == self.height
    }
}

impl HasArea for i32 {
    fn area(&self) -> f64 {
        println!("this is silly");

        *self as f64
    }
    fn is_larger(&self, other: &Self) -> bool {
        self > other
    }
}

use std::fmt::Debug;

fn foo<T: Clone, K: Clone + Debug>(x: T, y: K) {
    x.clone();
    y.clone();
    println!("{:?}", y);
}

fn bar<T, K>(x: T, y: K) where T: Clone, K: Clone + Debug {
    x.clone();
    y.clone();
    println!("{:?}", y);
}

trait Foo {
    fn is_valid(&self) -> bool;

    fn is_invalid(&self) -> bool { !self.is_valid() }
}

struct UseDefault;

impl Foo for UseDefault {
    fn is_valid(&self) -> bool {
        println!("Called UseDefault.is_valid.");
        true
    }
}

struct OverrideDefault;

impl Foo for OverrideDefault {
    fn is_valid(&self) -> bool {
        println!("Called OverrideDefault.is_valid.");
        true
    }

    fn is_invalid(&self) ->
        bool {
            println!("Called OverrideDefault.is_invalid!");
            true // overrides the expected value of is_invalid()
        }
}

/*
trait Foo {
    fn foo(&self);
}

trait FooBar : Foo {
    fn foobar(&self);
}

struct Baz;

impl Foo for Baz {
    fn foo(&self) { println!("foo"); }
}

impl FooBar for Baz {
    fn foobar(&self) { println!("foobar"); }
}
*/

fn main() {
    let c = Circle {
        x: 0.0f64,
        y: 0.0f64,
        radius: 1.0f64,
    };

    let s = Square {
        x: 0.0f64,
        y: 0.0f64,
        side: 1.0f64,
    };

    print_area(c);
    print_area(s);

    let mut r = Rectangle {
            x: 0,
            y: 0,
            width: 47,
            height: 47,
    };

    assert!(r.is_square());

    r.height = 42;
    assert!(!r.is_square());

    5.area();

    foo("Hello", "world");
    bar("Hello", "world");

    let default = UseDefault;
    assert!(!default.is_invalid()); // prints "Called UseDefault.is_valid."

    let over = OverrideDefault;
    assert!(over.is_invalid()); // prints "Called OverrideDefault.is_invalid!"
}

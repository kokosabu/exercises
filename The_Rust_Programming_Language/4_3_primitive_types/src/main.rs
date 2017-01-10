fn main() {
    let x = true;
    let y: bool = false;

    let x = 'x';
    let two_hearts = '💕';

    let x = 42; // x has type i32
    let y = 1.0; // y has type f64

    let a = [1, 2, 3]; // a: [i32; 3]
    let mut m = [1, 2, 3]; // m: [i32; 3]

    let a = [0; 20]; // a: [i32; 20]
    println!("{}...{}", a[0], a[19]);

    let a = [1, 2, 3];
    println!("a has {} elements", a.len());

    let names = ["Graydon", "Brian", "Niko"]; // names: [&str; 3]
    println!("The second name is: {}", names[1]);

    let a = [0, 1, 2, 3, 4];
    let complete = &a[..]; // A slice containing all of the elements in a
    let middle = &a[1..4]; // A slice of a: only the elements 1, 2, and 3

    /* Tuples */
    let x = (1, "hello");
    let x: (i32, &str) = (1, "hello");

    let mut x = (1, 2); // x: (i32, i32)
    let y = (2, 3); // y: (i32, i32)
    x = y;

    let (x, y, z) = (1, 2, 3);
    println!("x is {}", x);

    (0,); // single-element tuple
    (0); // zero in parentheses

    /* Tuple Indexing */
    let tuple = (1, 2, 3);

    let x = tuple.0;
    let y = tuple.1;
    let z = tuple.2;

    println!("x is {}", x);

    /* Functions */
    fn foo(x: i32) -> i32 { x }

    let x: fn(i32) -> i32 = foo;
}

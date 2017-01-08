fn main() {
    let x = 5;
    println!("The value of x is: {}", x);
    let (x, y) = (1, 2);
    println!("The value of x, y is: {}, {}", x, y);
    let x: i32 = 5;
    println!("The value of x is: {}", x);
    // x = 10; // error
    let mut z = 5;
    z = 10;
    println!("The value of z is: {}", z);

    let x: i32;
    // println!("The value of x is: {}", x); // error

    let x: i32 = 17;
    {
        let y2: i32 = 3;
        println!("The value of x is {} and value of y2 is {}", x, y2);
    }
    // println!("The value of x is {} and value of y2 is {}", x, y2); // This won't work

    let x2: i32 = 8;
    {
        println!("{}", x2); // Prints "8"
        let x2 = 12;
        println!("{}", x2); // Prints "12"
    }
    println!("{}", x2); // Prints "8"
    let x2 =  42;
    println!("{}", x2); // Prints "42"

    let mut x: i32 = 1;
    println!("{}", x);
    x = 7;
    let x = x; // x is now immutable and is bound to 7
    println!("{}", x);

    let y = 4;
    println!("{}", y);
    let y = "I can also be bound to text!"; // y is now of a different type
    println!("{}", y);
}

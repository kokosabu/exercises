fn main() {
    let x = 1;
    match x {
        1 => println!("one"),
        2 => println!("two"),
        3 => println!("three"),
        _ => println!("anything"),
    }

    let x = 1;
    let c = 'c';
    match c {
        x => println!("x: {} c: {}", x, c),
        //y => println!("y: {} c: {}", y, c),
    }
    println!("x: {}", x);

    let x = 1;
    match x {
        1 | 2 => println!("one or two"),
        3 => println!("three"),
        _ => println!("anything"),
    }

    struct Point {
        x: i32,
        y: i32,
    }

    let origin = Point { x: 2, y: 4 };
    match origin {
        Point { x, y } => println!("({},{})", x, y),
    }
    match origin {
        Point { x, .. } => println!("x is {}", x),
    }
    match origin {
        Point { y, .. } => println!("y is {}", y),
    }
}

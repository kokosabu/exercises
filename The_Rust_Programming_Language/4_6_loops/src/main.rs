fn main() {
    /*
    loop {
        println!("Loop forever!");
    }
    */

    let mut x = 5; // mut x: i32
    let mut done = false; // mut done: bool

    while !done {
        x += x - 3;

        println!("{}", x);

        if x % 5 == 0 {
            done = true;
        }
    }

    for x in 0..10 {
        println!("{}", x); // x: i32
    }

    for (index, value) in (5..10).enumerate() {
        println!("index = {} and value = {}", index, value);
    }

    let lines = "hello\nworld".lines();

    for (linenumber, line) in lines.enumerate() {
        println!("{}: {}", linenumber, line);
    }

    let mut x = 5;

    loop {
        x += x - 3;

        println!("{}", x);

        if x % 5 == 0 { break; }
    }

    for x in 0..10 {
        if x % 2 == 0 { continue; }

        println!("{}", x);
    }

    'outer: for x in 0..10 {
        'inner: for y in 0..10 {
            if x % 2 == 0 { continue 'outer; } // continues the loop over x
            if y % 2 == 0 { continue 'inner; } // continues the loop over y
            println!("x: {}, y: {}", x, y);
        }
    }

    'outer2: for x in 0..10 {
        'inner2: for y in 0..10 {
            if x % 2 == 0 { continue 'outer2; } // continues the loop over x
            if x % 5 == 0 { break    'outer2; } // break     the loop over x
            if y % 2 == 0 { continue 'inner2; } // continues the loop over y
            println!("x: {}, y: {}", x, y);
        }
    }
}

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

    let tuple: (u32, String) = (5, String::from("five"));
    // Here, tuple is moved, because the String moved:
    let (x, _s) = tuple;
    // The next line would give "error: use of partially moved value: `tuple`"
    // println!("Tuple is: {:?}", tuple);
    // However,
    let tuple = (5, String::from("five"));
    // Here, tuple is _not_ moved, as the String was never moved, and u32 is Copy:
    let (x, _) = tuple;
    // That means this works:
    println!("Tuple is: {:?}", tuple);

    enum OptionalTuple {
        Value(i32, i32, i32),
        Missing,
    }
    let x = OptionalTuple::Value(5, -2, 3);
    match x {
        OptionalTuple::Value(..) => println!("Got a tuple!"),
        OptionalTuple::Missing => println!("No such luck."),
    }
    let x = OptionalTuple::Missing;
    match x {
        OptionalTuple::Value(..) => println!("Got a tuple!"),
        OptionalTuple::Missing => println!("No such luck."),
    }

    let x = 5;
    match x {
        ref r => println!("Got a reference to {}", r),
    }
    match x {
        3 => println!("three"),
        5 => println!("five"),
        _ => println!("_"),
    }
    // 5にたどり着けないためError
    // match x {
    //     ref r => println!("Got a reference to {}", r),
    //     5 => println!("five"),
    // }
    match x {
        5 => println!("five"),
        ref r => println!("Got a reference to {}", r),
    }

    let x = '💅';
    let x = 'm';

    match x {
        'a' ... 'j' => println!("early letter"),
        'k' ... 'z' => println!("late letter"),
        //'z' ... 'k' => println!("late letter"),
        _ => println!("something else"),
    }

    #[derive(Debug)]
    struct Person {
        name: Option<String>,
    }

    let name = "Steve".to_string();
    let x: Option<Person> = Some(Person { name: Some(name) });
    match x {
        Some(Person { name: ref a @ Some(_), .. }) => println!("{:?}", a),
        _ => {}
    }

    let x = 5;
    match x {
        e @ 1 ... 5 | e @ 8 ... 10 => println!("got a range element {}", e),
          _ => println!("anything"),
    }

    enum OptionalInt {
        Value(i32),
        Missing,
    }
    let x = OptionalInt::Value(5);
    match x {
        OptionalInt::Value(i) if i > 5 => println!("Got an int bigger than five!"),
        OptionalInt::Value(..) => println!("Got an int!"),
        OptionalInt::Missing => println!("No such luck."),
    }

    let x = 4;
    let y = false;
    match x {
        4 | 5 if y => println!("yes"),
        _ => println!("no"),
    }
}

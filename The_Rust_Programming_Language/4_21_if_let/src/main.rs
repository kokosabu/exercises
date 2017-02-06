fn foo(x: i32) {
    println!("{}", x);
}

fn main() {
    let option: Option<i32> = Some(5);

    match option {
        Some(x) => { foo(x) },
        None => {},
    }

    if option.is_some() {
        let x = option.unwrap();
        foo(x);
    }

    if let Some(x) = option {
        foo(x);
    }

    if let Some(x) = option {
        foo(x);
    } else {
        // bar();
    }

    let mut v = vec![1, 3, 5, 7, 11];
    loop {
        match v.pop() {
            Some(x) =>  println!("{}", x),
            None => break,
        }
    }

    let mut v = vec![1, 3, 5, 7, 11];
    while let Some(x) = v.pop() {
        println!("{}", x);
    }
}

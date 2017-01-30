fn takes_slice(slice: &str) {
    println!("Got: {}", slice);
}

fn main() {
    let greeting = "Hello there."; // greeting: &'static str
    println!("{}", greeting);

    let s = "foo
    bar";
    assert_eq!("foo\n    bar", s);

    let s = "foo\
        bar";
    assert_eq!("foobar", s);

    let mut s = "Hello".to_string(); // mut s: String
    println!("{}", s);
    s.push_str(", world.");
    println!("{}", s);

    let s = "Hello".to_string();
    takes_slice(&s);

    let hachiko = "忠犬ハチ公";
    for b in hachiko.as_bytes() {
        print!("{}, ", b);
    }
    println!("");
    for c in hachiko.chars() {
        print!("{}, ", c);
    }
    println!("");

    let dog = "hachiko";
    let hachi = &dog[0..5];
    println!("{}", hachi);

    let hello = "Hello ".to_string();
    let world = "world!";
    let hello_world = hello + world;
    println!("{}", hello_world);

    let hello = "Hello ".to_string();
    let world = "world!".to_string();
    let hello_world = hello + &world;
    println!("{}", hello_world);
}

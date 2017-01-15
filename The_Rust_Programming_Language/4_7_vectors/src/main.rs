fn main() {
    let v = vec![1, 2, 3, 4, 5]; // v: Vec<i32>

    // works
    let i: usize = 0;
    v[i];

    // doesn’t
    // let j: i32 = 0;
    // v[j];

    println!("The third element of v is {}", v[2]);
    let v = vec![0; 10]; // ten zeroes
    println!("The third element of v is {}", v[2]);

    let v = vec![1, 2, 3];
    // println!("Item 7 is {}", v[7]);
    match v.get(7) {
        Some(x) => println!("Item 7 is {}", x),
        None    => println!("Sorry, this vector is too short.")
    }

    let mut v = vec![1, 2, 3, 4, 5];

    for i in &v {
        println!("A reference to {}", i);
    }

    for i in &mut v {
        *i = *i + 1;
        println!("A mutable reference to {}", i);
    }

    for i in v {
        println!("Take ownership of the vector and its element {}", i);
    }
}

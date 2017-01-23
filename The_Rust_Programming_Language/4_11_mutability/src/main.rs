fn main() {
    let mut x = 5;
    let mut x2 = 7;
    let y = &mut x;
    *y += 1;
    // y = &mut x2;
    println!("{}", *y);

    let mut x = 5;
    let mut z = &mut x;
    *z += 1;
    z = &mut x2;
    println!("{}", *z);

    use std::sync::Arc;
    let x = Arc::new(5);
    let y = x.clone();

    use std::cell::RefCell;
    let x = RefCell::new(42);
    let y = x.borrow_mut();

    //use std::cell::RefCell;
    let x = RefCell::new(42);
    let y = x.borrow_mut();
    //let z = x.borrow_mut(); // panic!
}

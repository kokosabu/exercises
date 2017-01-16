fn main() {
    let v = vec![1, 2, 3];

    println!("v[0] is: {}", v[0]);
    let v2 = v;

    // println!("v[0] is: {}", v[0]);
    println!("v[0] is: {}", v2[0]);

    fn take(v: Vec<i32>) {
        println!("v[0] is: {}", v[0]);
    }

    let v = vec![1, 2, 3];

    take(v);

    //println!("v[0] is: {}", v[0]);
}

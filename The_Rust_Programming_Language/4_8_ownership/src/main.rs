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

    let v = vec![1, 2, 3];
    println!("v[0] is: {}", v[0]);
    let mut v2 = v;
    v2.truncate(2);
    //println!("v[0] is: {}", v[0]);
    println!("v[0] is: {}", v2[0]);

    let v = 1;
    let v2 = v;
    println!("v is: {}", v);

    let a = 5;
    let _y = double(a);
    println!("{}", a);
    println!("{}", _y);

    let a = true;
    let _y = change_truth(a);
    println!("{}", a);
    println!("{}", _y);

    fn foo(v1: Vec<i32>, v2: Vec<i32>) -> (Vec<i32>, Vec<i32>, i32) {
        // do stuff with v1 and v2
        // hand back ownership, and the result of our function
        (v1, v2, 42)
    }

    let v1 = vec![1, 2, 3];
    let v2 = vec![4, 5, 6];

    println!("{}", v1[0]);
    println!("{}", v2[0]);
    //let (v1, v2, answer) = foo(v1, v2);
    let (v2, v1, answer) = foo(v1, v2);
    println!("{}", v1[0]);
    println!("{}", v2[0]);
    println!("{}", answer);


    let a = 3;
    let v1 = vec![1,2,3];

    let b = a;
    println!("{}, {}", a, b); // 代入元(a)、代入先(b)どちらもOK

    let v2 = v1;
    // println!("{}", v1[0]); // 代入元(v1)はダメ
    println!("{}", v2[0]);  // 代入先(v2)はOK
}

fn double(x: i32) -> i32 {
    x * 2
}

fn change_truth(x: bool) -> bool {
    !x
}

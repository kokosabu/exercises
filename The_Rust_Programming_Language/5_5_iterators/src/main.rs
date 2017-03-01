fn main() {
    for x in 0..10 {
        println!("{}", x);
    }

    let mut range = 0..10;
    loop {
        match range.next() {
            Some(x) => {
                println!("{}", x);
            },
            None => { break }
        }
    }

    let nums = vec![1, 2, 3];
    for i in 0..nums.len() {
        println!("{}", nums[i]);
    }

    let nums = vec![1, 2, 3];
    for num in &nums {
        println!("{}", num);
    }

    let nums = vec![1, 2, 3];
    for num in &nums {
        println!("{}", *num);
    }

    //let one_to_one_hundred = (1..101).collect();
    let one_to_one_hundred = (1..101).collect::<Vec<i32>>();
    let one_to_one_hundred = (1..101).collect::<Vec<_>>();

    let greater_than_forty_two = (0..100)
                                 .find(|x| *x > 42);
    match greater_than_forty_two {
        Some(_) => println!("Found a match!"),
        None => println!("No match found :("),
    }

    let sum = (1..4).fold(0, |sum, x| sum + x);
    println!("{}", sum);

    let num = (1..)
        .filter(|&x| x % 2 == 0)
        .filter(|&x| x % 3 == 0)
        .take(5)
        .collect::<Vec<i32>>();

    for n in num.iter() {
       println!("{}", n);
    }

}

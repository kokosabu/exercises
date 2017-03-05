use std::num::ParseIntError;

fn double_number(number_str: &str) -> Result<i32, ParseIntError> {
    number_str.parse::<i32>().map(|n| 2 * n)
}

//fn double_number(number_str: &str) -> Result<i32, ParseIntError> {
//    match number_str.parse::<i32>() {
//        Ok(n) => Ok(2 * n),
//        Err(err) => Err(err),
//    }
//}

// fn double_number(number_str: &str) -> i32 {
//     2 * number_str.parse::<i32>().unwrap()
// }

fn main() {
    match double_number("10") {
        Ok(n) => assert_eq!(n, 20),
        Err(err) => println!("Error: {:?}", err),
    }
    match double_number("a") {
        Ok(n) => assert_eq!(n, 20),
        Err(err) => println!("Error: {:?}", err),
    }
    //let n: i32 = double_number("10");
    //assert_eq!(n, 20);
    //let n: i32 = double_number("a");
    //assert_eq!(n, 20);
}

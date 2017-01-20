fn main() {
    let r;              // Introduce reference: r
    {
        let i = 1;      // Introduce scoped value: i
        r = &i;         // Store reference of i in r
    }                   // i goes out of scope and is dropped.

    println!("{}", r);  // r still refers to i
}

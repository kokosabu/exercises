struct Foo<'a> {
    x: &'a i32,
}

impl<'a> Foo<'a> {
    fn x(&self) -> &'a i32 { self.x }
}

fn main() {
    /*
    let r;              // Introduce reference: r
    {
        let i = 1;      // Introduce scoped value: i
        r = &i;         // Store reference of i in r
    }                   // i goes out of scope and is dropped.
    println!("{}", r);  // r still refers to i
    */

    /*
    //fn skip_prefix(line: &str, prefix: &str) -> &str {
    //fn skip_prefix<'a, 'b>(line: &'a str, prefix: &'b str) -> &'a str {
        // ...
    //}

    let line = "lang:en=Hello World!";
    let lang = "en";

    let v;
    {
        let p = format!("lang:{}=", lang);  // -+ p goes into scope
        v = skip_prefix(line, p.as_str());  //  |
    }                                       // -+ p goes out of scope
    println!("{}", v);
    */

    let y = &5; // this is the same as `let _y = 5; let y = &_y;`
    let f = Foo { x: y };

    println!("{}", f.x());
}

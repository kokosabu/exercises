macro_rules! myvec {
    ( $( $x:expr ),* ) => {
        {
            let mut temp_vec = Vec::new();
            $(
                temp_vec.push($x);
            )*
            temp_vec
        }
    };
}

macro_rules! foo {
    (x => $e:expr) => (println!("mode X: {}", $e));
    (y => $e:expr) => (println!("mode Y: {}", $e));
}

macro_rules! o_O {
    (
        $(
            $x:expr; [ $( $y:expr ),* ]
        );*
    ) => {
        &[ $($( $x + $y ),*),* ]
    }
}

macro_rules! five_times {
    ($x:expr) => (5 * $x);
}

macro_rules! log {
    ($msg:expr) => {{
        let state: i32 = five_times!(3);
        if state > 0 {
            println!("log({}): {}", state, $msg);
        }
    }};
}

macro_rules! foo2 {
    // () => (let x = 3;);
    ($v:ident) => (let $v = 3;);
    () => ( fn b() { println!("b"); } );
}

macro_rules! write_html {
    ($w:expr, ) => (());

    ($w:expr, $e:tt) => (write!($w, "{}", $e));

    ($w:expr, $tag:ident [ $($inner:tt)* ] $($rest:tt)*) => {{
        write!($w, "<{}>", stringify!($tag));
        write_html!($w, $($inner)*);
        write!($w, "</{}>", stringify!($tag));
        write_html!($w, $($rest)*);
    }};
}

fn main() {
    let x: Vec<u32> = vec![1, 2, 3];
    let y: Vec<u32> = {
        let mut temp_vec = Vec::new();
        temp_vec.push(1);
        temp_vec.push(2);
        temp_vec.push(3);
        temp_vec
    };
    let z: Vec<u32> = myvec![1, 2, 3];
    println!("{:?}", x);
    println!("{:?}", y);
    println!("{:?}", z);

    foo!(x => 2);
    foo!(y => 3);

    let a: &[i32]
        = o_O!(10; [1, 2, 3];
                20; [4, 5, 6]);
    assert_eq!(a, [11, 12, 13, 24, 25, 26]);

    assert_eq!(25, five_times!(2 + 3));

    let state: &str = "reticulating splines";
    log!(state);

    foo2!(x);
    println!("{}", x);
    foo2!();
    b();

    use std::fmt::Write;
    let mut out = String::new();

    write_html!(&mut out,
        html[
            head[title["Macros guide"]]
            body[h1["Macros are the best!"]]
        ]);

    assert_eq!(out,
        "<html><head><title>Macros guide</title></head>\
         <body><h1>Macros are the best!</h1></body></html>");
}

#[cfg(target_os = "macos")]
fn only() {
    println!("mac");
}

#[cfg(target_os = "linux")]
fn only() {
    println!("linux");
}

#[test]
fn hoge() {
    only();
}

fn main() {
    println!("Hello, world!");
    only();
}

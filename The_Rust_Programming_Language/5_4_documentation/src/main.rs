/// Constructs a new `Rc<T>`.
///
/// # Examples
///
/// ```
/// use std::rc::Rc;
///
/// let five = Rc::new(5);
/// ```
// pub fn new(value: T) -> Rc<T> {
//     // Implementation goes here.
// }

/// The `Option` type. See [the module level documentation](index.html) for more.
enum Option<T> {
    /// No value
    None,
    /// Some value `T`
    Some(T),
}

// /// The `Option` type. See [the module level documentation](index.html) for more.
// enum Option<T> {
//     None, /// No value
//     Some(T), /// Some value `T`
// }

fn main() {
    println!("Hello, world!");
}

/// # Examples
///
/// Simple `&str` patterns:
///
/// ```
/// let v: Vec<&str> = "Mary had a little lamb".split(' ').collect();
/// assert_eq!(v, vec!["Mary", "had", "a", "little", "lamb"]);
/// ```
///
/// More complex patterns with a lambda:
///
/// ```
/// let v: Vec<&str> = "abc1def2ghi".split(|c: char| c.is_numeric()).collect();
/// assert_eq!(v, vec!["abc", "def", "ghi"]);
/// ```

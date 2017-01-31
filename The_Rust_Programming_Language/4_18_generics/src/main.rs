struct Point<T> {
    x: T,
    y: T,
}

impl<T> Point<T> {
    fn swap(&mut self) {
        std::mem::swap(&mut self.x, &mut self.y);
    }
}

fn main() {
    enum Result<T, E> {
        Ok(T),
        Err(E),
    }
    let x: Option<i32> = Some(5);
    let x = Some(5);

    let mut int_point = Point { x: 3, y: 2 };
    let mut float_point = Point { x: 0.3, y: 0.2 };

    println!("({}, {})", int_point.x, int_point.y);
    int_point.swap();
    println!("({}, {})", int_point.x, int_point.y);

    println!("({}, {})", float_point.x, float_point.y);
    float_point.swap();
    println!("({}, {})", float_point.x, float_point.y);
}

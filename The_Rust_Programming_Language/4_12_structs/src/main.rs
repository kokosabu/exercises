struct Point {
    x: i32,
    y: i32,
}

struct PointRef<'a> {
    x: &'a mut i32,
    y: &'a mut i32,
}

struct Point3d {
    x: i32,
    y: i32,
    z: i32,
}

struct Color(i32, i32, i32);
struct Point2(i32, i32, i32);
struct Inches(i32);

fn main() {
    let origin = Point { x: 0, y: 0 }; // origin: Point

    let mut origin = Point { x: 0, y: 0 }; // origin: Point
    origin.x = 5;
    origin.y = 7;

    println!("The origin is at ({}, {})", origin.x, origin.y);

    let mut point = Point { x: 0, y: 0 };
    point.x = 5;
    let point = point; // now immutable
    // point.y = 6; // this causes an error

    let mut point = Point { x: 0, y: 0 };
    {
        let r = PointRef { x: &mut point.x, y: &mut point.y };

        *r.x = 5;
        *r.y = 6;
    }
    assert_eq!(5, point.x);
    assert_eq!(6, point.y);
    println!("The origin is at ({}, {})", point.x, point.y);

    let mut point = Point3d { x: 0, y: 0, z: 0 };
    println!("({}, {}, {})", point.x, point.y, point.z);
    point = Point3d { y: 1, .. point };
    println!("({}, {}, {})", point.x, point.y, point.z);

    let origin = Point3d { x: 0, y: 0, z: 0 };
    let point = Point3d { z: 1, x: 2, .. origin };
    println!("({}, {}, {})", point.x, point.y, point.z);

    // Tuple
    let black = Color(0, 0, 0);
    let origin = Point2(0, 0, 0);

    let black_r = black.0;
    let Point2(_, origin_y, origin_z) = origin;
    println!("({}, {}, {})", black_r, origin_y, origin_z);

    let length = Inches(10);
    let Inches(integer_length) = length;
    println!("length is {} inches", integer_length);
}

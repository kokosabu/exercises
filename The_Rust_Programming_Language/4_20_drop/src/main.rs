struct HasDrop;

impl Drop for HasDrop {
    fn drop(&mut self) {
        println!("Dropping!");
    }
}

struct Firework {
    strength: i32,
}

impl Drop for Firework {
    fn drop(&mut self) {
        println!("BOOM times {}!!!", self.strength);
    }
}

fn main() {
    println!("one");
    {
        let x = HasDrop;
        println!("two");
    }
    println!("three");

    let firecracker = Firework { strength: 1 };
    let tnt = Firework { strength: 100 };
}

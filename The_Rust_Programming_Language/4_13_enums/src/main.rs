enum Message {
    Quit,
    ChangeColor(i32, i32, i32),
    Move { x: i32, y: i32 },
    Write(String),
}

fn main() {
    let x: Message = Message::Move { x: 3, y: 4 };

    //println!("{}", Message::Quit);

    enum BoardGameTurn {
        Move { squares: i32 },
        Pass,
    }
    let y: BoardGameTurn = BoardGameTurn::Move { squares: 1 };

    let m = Message::Write("Hello, world".to_string());

    fn foo(x: String) -> Message {
        Message::Write(x)
    }
    let x = foo("Hello, world".to_string());

    let v = vec!["Hello".to_string(), "World".to_string()];
    let v1: Vec<Message> = v.into_iter().map(Message::Write).collect();
}

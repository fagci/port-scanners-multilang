use futures::{stream, StreamExt};
use std::time::Duration;
use tokio::net::TcpStream;

const TIMEOUT:Duration = Duration::from_secs(750);

async fn check(port: u16) {
    let addr = format!("{}:{}", "192.168.0.200", port);
    match tokio::time::timeout(TIMEOUT, TcpStream::connect(&addr)).await {
        Ok(Ok(_)) => println!("{}", port),
        _ => (),
    }
}

#[tokio::main]
async fn main() {
    let ports = (1u16..1024).into_iter();
    stream::iter(ports).for_each_concurrent(128, &check).await
}

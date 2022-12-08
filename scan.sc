import java.net.Socket
import scala.concurrent._
import scala.concurrent.duration._
import ExecutionContext.Implicits.global


def check(port: Int) = Future {
    val socket = new Socket("192.168.0.200", port)
    println(port)
    socket.close()
}

@main def main() = 
  var tasks = Future
    .traverse(1 to 128)(check(_).recover{ case _ => 0 })

  try
    Await.result(tasks, Duration(750, MILLISECONDS))
  catch
    case _ => 0



import java.net.Socket
import scala.concurrent._
import scala.concurrent.duration._
import ExecutionContext.Implicits.global


def check(port: Int) = Future {
    new Socket("192.168.0.200", port).close()
    println(port)
}.recover{case _ => 0}


@main def main() = 
  var tasks = Future.traverse(1 to 128)(check)

  try
    Await.result(tasks, Duration(750, MILLISECONDS))
  catch
    case _ => 0


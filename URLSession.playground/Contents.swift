import UIKit
import PlaygroundSupport

/*
 URLSession is basically used for handling HTTP and HTTPS requests.
 URLSession is consist of few important classes like
 1. URLSessionConfiguration
 2. URLSessionTask
 */


/*
 URLSessionConfiguration is used to configure session properties like
 TimeOutValues, Chaching Policies, and HTTPHeaders etc.
 https://developer.apple.com/documentation/foundation/urlsessionconfiguration
 
 URLSessionConfiguration comes with three different flavors
 1. default - default configuration
 2. ephemeral - similar to default configuration but private session
 3. background -  session perform upload or download tasks in the background. Transfers continue even when the app itself is suspended or terminated by the system
 */
let urlConfig = URLSessionConfiguration.default
urlConfig.allowsCellularAccess = true
urlConfig.waitsForConnectivity = true
urlConfig.timeoutIntervalForRequest = 60
urlConfig.timeoutIntervalForResource = 3 //How many time request should retry

let urlSession = URLSession(configuration: urlConfig)

/*
 URLSessionTask Types
 There are three types of concrete session tasks:
 
 1. URLSessionDataTask: Use this task for GET requests to retrieve data from servers to memory.
 2. URLSessionUploadTask: Use this task to upload a file from disk to a web service via a POST or PUT method.
 3. URLSessionDownloadTask: Use this task to download a file from a remote service to a temporary file location. You can also suspend, resume and cancel tasks like other two. URLSessionDownloadTask has the extra ability to pause for future resumption.
 */


let url = URL(string: "https://my-json-server.typicode.com/typicode/demo/posts")!
let urlRequest = URLRequest(url: url)

let task = urlSession.dataTask(with: url) { (data, response, error) in
  
  guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
    return
  }
  
  guard let data = data else {
    print(data.debugDescription)
    return
  }
  
  if let result = NSString(data: data, encoding: String.Encoding.utf8.rawValue) as String? {
    print(result)
  }
  
  PlaygroundPage.current.finishExecution()
}

task.resume()


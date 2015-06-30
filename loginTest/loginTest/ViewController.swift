
import UIKit
import Alamofire

class ViewController: UIViewController {

    var isLogin = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidAppear(animated: Bool) {
        if !isLogin
        {
            isLogin = true
            self.performSegueWithIdentifier( "login", sender: self )
        }
    }
}
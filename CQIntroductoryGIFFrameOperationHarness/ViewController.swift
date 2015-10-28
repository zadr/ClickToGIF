import UIKit

class ViewController: UIViewController {
	@IBOutlet weak var imageView: UIImageView?
	override func viewDidLoad() {
		super.viewDidLoad()

		let url = NSBundle.mainBundle().URLForResource("puppy", withExtension: "gif")!
		let operation = CQIntroductoryGIFFrameOperation(URL: url)

		// see note in CQIntroductoryGIFFrameOperation about using blocks vs kvo vs target/action here
		operation.target = self
		operation.action = "gifProcessed:"

		NSOperationQueue.mainQueue().addOperation(operation)
	}

	@objc func gifProcessed(operation: CQIntroductoryGIFFrameOperation) {
		print("Completed gif frame after reading " + String(operation.introductoryFrameImageData!.length) + " bytes")

		self.setImage(operation.introductoryFrameImage)
	}

	@IBAction func playAnimatedGif(sender: UIButton?) {
		let url = NSBundle.mainBundle().URLForResource("puppy", withExtension: "gif")!
		let data = NSData(contentsOfURL: url)
		print("loaded full gif frame after reading" + String(data!.length) + " bytes")

		let image = UIImage.animatedImageWithAnimatedGIFData(data)
		setImage(image, animate: true)

		UIView.animateWithDuration(0.25, animations: {
			sender?.alpha = 0.0
		})
	}

	private func setImage(image: UIImage?, animate: Bool = false) {
		if let loadedImageView = imageView, loadedImage = image {
			dispatch_async(dispatch_get_main_queue(), {
				loadedImageView.image = loadedImage

				while CGRectGetMaxX(loadedImageView.frame) > CGRectGetWidth(self.view.frame) ||
					  CGRectGetMaxY(loadedImageView.frame) > CGRectGetHeight(self.view.frame) {
						loadedImageView.transform = CGAffineTransformScale(loadedImageView.transform, 0.95, 0.95)
				}

				if animate {
					loadedImageView.startAnimating()
				}
			})
		}
	}
}

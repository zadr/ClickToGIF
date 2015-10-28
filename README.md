Download the first frame of an animated gif, instead of the full thing.

example usages:
```swift
	func example() {
		let url = NSBundle.mainBundle().URLForResource("puppy", withExtension: "gif")!
		let operation = CQIntroductoryGIFFrameOperation(URL: url)

		// note: `completionBlock` is also available from NSOperation, although it
		// works based off of KVO states, and will take an extra runloop or two to fire.
		operation.target = self
		operation.action = "gifProcessed:"

		NSOperationQueue.mainQueue().addOperation(operation)
	}

	@objc func gifProcessed(operation: CQIntroductoryGIFFrameOperation) {
		if let image = operation.introductoryFrameImageData {
			print("we have a still image of the first frame of an animated gif!")
		}
	}
```

or

```swift
	func example() {
		let url = NSBundle.mainBundle().URLForResource("puppy", withExtension: "gif")!
		let operation = CQIntroductoryGIFFrameOperation(URL: url)
		operation.completionBlock = {
			if let image = operation.introductoryFrameImageData {
				print("we have a still image of the first frame of an animated gif!")
			}
		}

		NSOperationQueue.mainQueue().addOperation(operation)
	}
```

(Or go straight to the code, in CQIntroductoryGIFFrameOperationHarness/CQIntroductoryGIFFrameOperation{.h, .m}.)
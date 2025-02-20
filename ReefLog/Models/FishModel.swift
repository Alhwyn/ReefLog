import CoreML
import SwiftUI

class FishClassifierModel {
    
    func classifyFish(image: UIImage) async -> String {
        // Resize the image to 299x299
        let resizedImage = image.resizeImageTo(size: CGSize(width: 299, height: 299))
        
        // Use the CIContext-based function to convert the image to a CVPixelBuffer.
        guard let cvPixelBuffer = resizedImage?.convertToBuffer(saveToFile: true) else {
            return "Unknown"
        }
        
        do {
            let model = try Minnow_1(configuration: MLModelConfiguration())
            let prediction = try model.prediction(image: cvPixelBuffer)
            print(prediction.target)
            return prediction.target
        } catch let error {
            print(error.localizedDescription)
            return "Unknown"
        }
    }
}

